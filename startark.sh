#!/bin/bash

# Updated 14.01.23
# Developed by !Mr5ecret#5355 & !Lukats#6146 [M&L Development Team]

# Server
map="TheIsland"
SessionName="NAME"
ServerPassword="PASW"
ServerAdminPassword="APASW"
Port="7777"
QueryPort="27015"
MaxPlayers="20"
flags="-server -log -NoBattlEye -usecache"

# Script
pr="[M&L Dev]"
re="\033[1;31m"
bl="\033[1;34m"
gr="\033[1;33m"
rs="\033[0m"
screen="ark"

# Discord
webhook_url="DISCORD WEBHOOK"
icon="ICON LINK"
name="BOT NAME"
DISCORD="/tmp/discord.discord"
roleId="PING ROLE ID"

# Script Start
command=("cd /home/ark/ShooterGame/Binaries/Linux/ && ./ShooterGameServer $map?listen?SessionName=$SessionName?ServerPassword=$ServerPassword?ServerAdminPassword=$ServerAdminPassword?Port=$Port?QueryPort=$QueryPort?MaxPlayers=$MaxPlayers $flags")

if [ "$1" = "-s" ]; then
  echo -e "${bl}${pr}${gr} Stopping previous Ark Survival Evolved server...${rs}"
  if [ $webhook_url != "null" ]; then
     message="**`date '+%T %D'`** \n 🚫 \`Stopping previous Ark Survival Evolved server...\`"
     msg_content=\"$message\"
     USERNAME=\"${name}\"
     IMAGE=\"${icon}\"
     webhook_url="${webhook_url}"
     curl -H "Content-Type: application/json" -X POST -d "{\"username\": $USERNAME, \"avatar_url\": $IMAGE, \"content\": $msg_content}" $webhook_url
   else
     echo "${output} Restart stop message failed"
  fi
  screen -XS ${screen} kill
  sleep 2
  echo -e "${bl}${pr}${gr} Starting Ark Survival Evolved server...${rs}"
  if [ $webhook_url != "null" ]; then
     message="**`date '+%T %D'`** ||<@&$roleId>|| \n ✅ \`Starting Ark Survival Evolved server...\`"
     msg_content=\"$message\"
     USERNAME=\"${name}\"
     IMAGE=\"${icon}\"
     webhook_url="${webhook_url}"
     curl -H "Content-Type: application/json" -X POST -d "{\"username\": $USERNAME, \"avatar_url\": $IMAGE, \"content\": $msg_content}" $webhook_url
   else
     echo "${output} Restart start message failed"
  fi
  screen -dmS ${screen} # Move this line here 
  latest_version=$(/root/steamcmd/steamcmd.sh +login anonymous +app_info 376030 +quit | grep "buildid" | awk '{print $3}' | tail -1)
  if [ -z "$latest_version" ]; then
    latest_version="unknown"
  fi
  echo -e "${bl}${pr}${gr} Latest version: $latest_version ${rs}"
  version=$(cat /home/ark/version.txt)
  echo -e "${bl}${pr}${gr} Server version: $version ${rs}"
  if [ "$version" == "$latest_version" ]; then
    echo -e "${bl}${pr}${gr} Your server is up to date. ${rs}"
    screen -x ${screen} -X stuff "${command[@]}"
  else
    echo -e "${bl}${pr}${re} Your server is not up to date. Latest version is $latest_version.${rs}"
    echo -e "${bl}${pr}${gr} Starting Ark Survival Evolved server... ${rs}"
    screen -x ${screen} -X stuff "${command[@]} $(printf \\r)"
  fi

elif [ "$1" = "-u" ]; then
  echo -e "${bl}${pr}${gr} Updating Ark Survival Evolved server...${rs}"
  if [ $webhook_url != "null" ]; then
     message="**`date '+%T %D'`** \n 🚫 \`Starting update... stopping previous Ark Survival Evolved server.\`"
     msg_content=\"$message\"
     USERNAME=\"${name}\"
     IMAGE=\"${icon}\"
     webhook_url="${webhook_url}"
     curl -H "Content-Type: application/json" -X POST -d "{\"username\": $USERNAME, \"avatar_url\": $IMAGE, \"content\": $msg_content}" $webhook_url
   else
     echo "${output} Restart stop message failed"
  fi
  screen -XS ${screen} kill
  /root/steamcmd/steamcmd.sh +force_install_dir /home/ark +login anonymous +app_update 376030 validate +exit || exit
  if [ $? -eq 0 ]; then
    echo -e "${bl}${pr}${gr} Update successful, starting Ark Survival Evolved server...${rs}"
    if [ $webhook_url != "null" ]; then
       message="**`date '+%T %D'`** ||<@&$roleId>|| \n ✅ \`Update successful, starting Ark Survival Evolved server...\`"
       msg_content=\"$message\"
       USERNAME=\"${name}\"
       IMAGE=\"${icon}\"
       webhook_url="${webhook_url}"
       curl -H "Content-Type: application/json" -X POST -d "{\"username\": $USERNAME, \"avatar_url\": $IMAGE, \"content\": $msg_content}" $webhook_url
     else
       echo "${output} Update message failed"
    fi
    screen -dmS ${screen}
    screen -x ${screen} -X stuff "${command[@]}
    "
  else
    echo -e "${bl}${pr}${re} Update failed, please try again.${rs}"
    if [ $webhook_url != "null" ]; then
       message="**`date '+%T %D'`** \n 🚫 \`Update failed, please try again later.\` @Ark"
       msg_content=\"$message\"
       USERNAME=\"${name}\"
       IMAGE=\"${icon}\"
       webhook_url="${webhook_url}"
       curl -H "Content-Type: application/json" -X POST -d "{\"username\": $USERNAME, \"avatar_url\": $IMAGE, \"content\": $msg_content}" $webhook_url
     else
       echo "${output} Update failed message failed"
    fi
  fi
else
  echo -e "${bl}${pr}${re} Invalid argument. Use -s to start server or -u to update server.${rs}"
fi

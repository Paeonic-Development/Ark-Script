#!/bin/bash

# Updated 15.01.23
# Developed by !Mr5ecret#5355 & !Lukats#6146 [M&L Development Team]

# Server
map="TheIsland"
SessionName="M&L Dev" # Change this
ServerPassword="PASW" # Change this
ServerAdminPassword="APASW" # Change this
Port="7777"
QueryPort="27015"
MaxPlayers="20"
flags="-server -log -NoBattlEye -usecache"
serverFolder="/home/ark/" # Change this if needed
shootergameFolder="/home/ark/ShooterGame/Binaries/Linux/" # Change this if needed
steamcmdFolder="/root/steamcmd/steamcmd.sh" # Change this if needed

# Script
pr="[M&L Dev]"
re="\033[1;31m"
bl="\033[1;34m"
gr="\033[1;33m"
rs="\033[0m"
screen="ark" # Change this if needed

# Discord
webhook_url="https://discordapp.com/api/webhooks/1063827113934856282/9uslkjZ_GKWWOTsW06So1o9cSNKpcXGw6RRr4OBafsxF0FSY5LSoWgLAwEIyBL2IZJ0c" # Change this if needed
thumbnail="https://media.discordapp.net/attachments/1057420375388078190/1057420487229182023/ML_Dev_static.png?width=205&height=205" # Change this if needed
avatar_url="https://media.discordapp.net/attachments/1022442019479625770/1048557566780788808/X_CaVe_X_standard.gif?width=205&height=205" # Change this if needed
username="M&L Dev" # Change this
roleId="1060135644078280734" # Change this
channelId="1061971883815354408" # Change this
colorRe="15158332"
colorGr="3066993"

# Console Lang
stop="Stopping previous Ark Survival Evolved server..."
start="Starting Ark Survival Evolved server..."
notUpToDate="Your server is not up to date. Latest version is"
upToDate="Your server is up to date."
update="Updating Ark Survival Evolved server..."
latest="Latest version:"
current="Server version:"
invalidArg="Invalid argument. Use -s to start server or -u to update server."
updateSuccess="Update successful, starting Ark Survival Evolved server..."
updateFail="Update failed, please try again."
unknown="Unknown"

# Embed Lang
title="M&L Ark Server"
serverStop="Stopping previous Ark Survival Evolved server..."
serverStart="Starting Ark Survival Evolved server..."
serverStartUpdate="Starting update... stopping previous Ark Survival Evolved server."
serverUpdateSuccess="Update successful, starting Ark Survival Evolved server..."
serverUpdateFail="Update failed, please try again later."

# Embed Error
embedRestart="Restart stop message failed"
embedUpdate="Update message failed"
embedFailedMessage="Update-failed message failed"

# Script Start
command=("cd $shootergameFolder && ./ShooterGameServer $map?listen?SessionName=$SessionName?ServerPassword=$ServerPassword?ServerAdminPassword=$ServerAdminPassword?Port=$Port?QueryPort=$QueryPort?MaxPlayers=$MaxPlayers $flags")

if [ "$1" = "-s" ]; then
  echo -e "${bl}${pr}${gr} ${stop}${rs}"
  curl -H "Content-Type: application/json" -X POST -d "{\"username\":\"$username\", \"avatar_url\":\"$avatar_url\", \"embeds\": [{\"title\": \"$title\", \"description\": \"$serverStop\", \"color\": $colorRe, \"thumbnail\": {\"url\": \"$thumbnail\"}}], \"channel_id\": $channelId}" $webhook_url
  screen -XS ${screen} kill
  sleep 2
  echo -e "${bl}${pr}${gr} ${start}${rs}"
  curl -H "Content-Type: application/json" -X POST -d "{\"username\":\"$username\", \"avatar_url\":\"$avatar_url\", \"embeds\": [{\"title\": \"$title\", \"description\": \"$serverStart\", \"color\": $colorGr, \"thumbnail\": {\"url\": \"$thumbnail\"}}], \"channel_id\": $channelId}" $webhook_url
  screen -dmS ${screen}
  latest_version=$(${steamcmdFolder} +login anonymous +app_info 376030 +quit | grep "buildid" | awk '{print $3}' | tail -1)
  if [ -z "$latest_version" ]; then
    latest_version="${unknown}"
  fi
  echo -e "${bl}${pr}${gr} ${latest} $latest_version${rs}"
  version=$(cat ${serverFolder}version.txt)
  echo -e "${bl}${pr}${gr} ${current} $version${rs}"
  if [ "$version" == "$latest_version" ]; then
    echo -e "${bl}${pr}${gr} ${upToDate}${rs}"
    screen -x ${screen} -X stuff "${command[@]}"
  else
    echo -e "${bl}${pr}${re} ${notUpToDate} $latest_version.${rs}"
    echo -e "${bl}${pr}${gr} ${start}${rs}"
    screen -x ${screen} -X stuff "${command[@]} $(printf \\r)"
  fi

elif [ "$1" = "-u" ]; then
  echo -e "${bl}${pr}${gr} ${update}${rs}"
  if [ $webhook_url != "null" ]; then
     curl -H "Content-Type: application/json" -X POST -d "{\"username\":\"$username\", \"avatar_url\":\"$avatar_url\", \"embeds\": [{\"title\": \"$title\", \"description\": \"$serverStartUpdate\", \"color\": $colorRe, \"thumbnail\": {\"url\": \"$thumbnail\"}}], \"channel_id\": $channelId}" $webhook_url
   else
     echo "${bl}${pr}${re} ${embedRestart}${rs}"
  fi
  screen -XS ${screen} kill
  /root/steamcmd/steamcmd.sh +force_install_dir /home/ark +login anonymous +app_update 376030 validate +exit || exit
  if [ $? -eq 0 ]; then
    echo -e "${bl}${pr}${gr} ${updateSuccess}${rs}"
    if [ $webhook_url != "null" ]; then
       curl -H "Content-Type: application/json" -X POST -d "{\"username\":\"$username\", \"avatar_url\":\"$avatar_url\", \"embeds\": [{\"title\": \"$title\", \"description\": \"||<@&$roleId>|| $serverUpdateSuccess\", \"color\": $colorGr, \"thumbnail\": {\"url\": \"$thumbnail\"}}], \"channel_id\": $channelId}" $webhook_url
     else
       echo "${bl}${pr}${re} ${embedUpdate}${rs}"
    fi
    screen -dmS ${screen}
    screen -x ${screen} -X stuff "${command[@]}
    "
  else
    echo -e "${bl}${pr}${re} ${updateFail}${rs}"
    if [ $webhook_url != "null" ]; then
       curl -H "Content-Type: application/json" -X POST -d "{\"username\":\"$username\", \"avatar_url\":\"$avatar_url\", \"embeds\": [{\"title\": \"$title\", \"description\": \"$serverUpdateFail\", \"color\": $colorGr, \"thumbnail\": {\"url\": \"$thumbnail\"}}], \"channel_id\": $channelId}" $webhook_url
     else
       echo "${bl}${pr}${re} ${embedFailedMessage}${rs}"
    fi
  fi
else
  echo -e "${bl}${pr}${re} ${invalidArg}${rs}"
fi

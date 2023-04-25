<div align="center">
  <img src="https://github.com/Paeonic-Development/.github/blob/main/images/Paeonic.png" alt="PΛΞ0NIC Development Banner">
</div>

<div align="center">
  <h1>What is Ark Survival Evolved linux bash script?</h1>
  <h4>Script is for updating server and starting and there is discord webhook to announce server start, stop and update!</h4>
</div>

<div align="center">
  <h2>How to install and run the file?</h2>
</div>

### _Where i should put the skript file?_
> Drop `startark.sh` to your root folder.

### _Give permission to execute file_
> You will need to make the file executable. Let's assume that you have downloaded your file as startark.sh, you can then run in your terminal:
```ruby
chmod +x ./startark.sh
```
> chmod is a command for changing file's permissions, +x sets execute permissions (in this case for everybody) and finally you have your file name.

### _Commands_
| Command | Description |
| --- | --- |
| -s | Starts / restarts server |
| -u | Updates and starts server |

<div align="center">
  <h2>Configs</h2>
</div>

## _Server config_
| Variables | Description |
| --- | --- |
| map="TheIsland" | Sellect your game server map |
| SessionName="Praction" | Sellect your server name |
| ServerPassword="PASW" | Set server password |
| ServerAdminPassword="APASW" | Set server admin password |
| Port="7777" | Set server port |
| QueryPort="27015" | Set server query port |
| MaxPlayers="20" | Set max players |
| flags="-server -log" | Server flags |
| serverFolder="" | Where is your main server files located |
| shootergameFolder="" | Where is your shootergame located |
| steamcmdFolder="" | Where is your steamcmd.sh installed |

## _Script config_
| Variables | Description |
| --- | --- |
| pr="[Praction]" | Console prefix |
| re="\033[1;31m" | Color red |
| bl="\033[1;34m" | Color blue |
| gr="\033[1;33m" | Color green |
| rs="\033[0m" | Reset style |
| screen="ark" | Screen name |


## _Webhook config_
| Variables | Description |
| --- | --- |
| webhook_url="" | Discord webhook url |
| thumbnail="" | Discord embed thumbnail |
| avatar_url="" | Discord webhook avatar icon |
| username="Praction" | Discord webhook name |
| roleId="1234567890123456789" | Discord ping role |
| channelId="1234567890123456789" | Discord channel id where is announcement sent |
| colorRe="15158332" | Embed color red |
| colorGr="3066993" | Embed color green |

<div align="center">
  <h2>Known issues</h2>
</div>

> Script doesnt check Ark Survival Evolved steam version.

<div align="center">
  <h2>ToDo</h2>
</div>

- [ ] Add way to enable or disable webhook.
- [ ] Add command that creates server from scratch.
- [ ] Fix Ark steam version check.
- [ ] Add way to enable or disable server password.

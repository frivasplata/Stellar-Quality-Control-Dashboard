# Stellar-Quality-Control-Dashboard
This project integrates Stellar APs from Alcatel-Lucent Enterprise working in any mode OVE, OVC or Cluster with Graylog log management system and allows you to build a Signal Quality Control Dashboard giving you a deep real time insight about:

-RSSI per AP, SSID, Station
-SNR per AP, SSID, Station
-Stations capabilities
-Channel Utilization and Occupation
-AP occupation
-SSID occupation
-AP Througput in Bps (Bytes per second) Transmited and Received
-AP Mutlicast traffic in pps (packets per second)
-AP TX and RX errors and drops in pps (packets per second)
-AP CPU and Memory available
-AP CPU temperature in Celsius centigrades

All this information doesn't requires any Omnivista server but requires a Graylog server (Graylog + elasticsearch + mongo DB), to install a Graylog server using Dockers please refer to https://docs.graylog.org/docs/docker or using a VM please download a virtual machine from here https://packages.graylog2.org/appliances/ova and pick the release you wanted.

Pre-Requisites:
1- having the Stellar AP's root password
2- A graylog server properly installed and running

Installation process
1-Upload the "Stellar Quality Control Dashboard - Content pack.json" into the Graylog server and install it, to do this use the menu System > Content Pack in the Graylog Server,this content pack file will create everything needed in the Graylog server to receive and format the data coming from the Stellar AP's.
2-Transfer the "quality-control-configuration.sh" script to the Stellar AP you wanted to monitor and run the script (you must connect as root), make this script executable with the command "chmod +x quality-control-configuration.sh", answer the questions included in the script, the port where Graylog is listening by running the content pack is the port 5555 but you can change that editing the RAW TCP input created by default when running the content pack in the previous step.
3- Edit the corntab with the command crontab -e, check that the speed.sh and signal-to-graylog.sh scripts are added to the corntab and the save it entering ":wq"
4-After 1 or 2 minutes check the data is properly arriving into the Graylog Server and the data is properly showed in the Stellar_local stream, after that you will start to see the Dashboard populated with very useful information.

enjoy

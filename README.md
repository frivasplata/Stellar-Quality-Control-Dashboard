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

All this information doesn't requires any Omnivista server but requires a Graylog server (Graylog + elasticsearch + mongo DB), to install a Graylog server please refer to https://graylog.org

Pre-Requisites:
1- have the Stellar root password
2- have a graylog server properly installed and running

Installation process
1-Install a graylog server 
2-Upload the Stellar Quality Control - Content pack into the Graylog server
3-Connect to the Stellar AP's you wanted to monitor and run the quality-control-configuration.sh script
4-Check the data is properly arriving into the Graylog Server and the data is properly showed in the Stellar_local stream, after that you will start to see the Dashboard populated with very useful information.

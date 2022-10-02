#!/bin/sh
#Script developed by Fernando Rivasplata
#Build 1.1 Aug 15 2022 8:00pm

trap_ctrlc() {
echo -e "\e[0m"
echo "-------------------------------------------------------"
echo "Script canceled, please check that the crontab is according with what you expect (crontab -e) and remove the undesired jobs..."
echo ""
menu #calling the menu function
exit 0
}
trap trap_ctrlc INT
wait


function menu() {
echo ""
echo "Press 0 to exit"
read option
if [ $option -eq 0 ]
then
	exit 0
else
	echo "This option is not available at this time"
	exit 0
fi
}
function ssid1() {
echo "Enter the name of the SSID for the ath01 and ath11:"
echo "!!!!!Do not use special characters (@$-;)"
read ssid1
#populating the signal-to-graylog.sh script
echo "wlanconfig ath01 list | grep '65535\|SNR\|Capability\|capable'" "| awk '{ printf \"%s\""", \$0; if (NR % 5 == 0) print \"\"""; else printf \" \" }' | sed 's/^/"$ap_name $ssid1 "/g' | nc" $server $port >> signal-to-graylog.sh
echo "wlanconfig ath11 list | grep '65535\|SNR\|Capability\|capable'" "| awk '{ printf \"%s\""", \$0; if (NR % 5 == 0) print \"\"""; else printf \" \" }' | sed 's/^/"$ap_name $ssid1 "/g' | nc" $server $port >> signal-to-graylog.sh
#populating the speed.sh with the AP details
echo 'ch_2g01=$(iwlist ath01 channel | grep Current |' "awk '{printf \$5}' | sed" "'s/)//g') " >> speed.sh
echo 'ch_5g11=$(iwlist ath11 channel | grep Current |' "awk '{printf \$5}'| sed" "'s/)//g') " >> speed.sh
echo 'util_2g01=$(iwpriv ath01 get_chutil |' "awk '{printf \$2}' | sed" "'s/get_chutil://g') " >> speed.sh
echo 'util_5g11=$(iwpriv ath11 get_chutil |' "awk '{printf \$2}' | sed" "'s/get_chutil://g') " >> speed.sh
echo 'bssid_01=$(iwconfig ath01 | grep Access |' "awk '{printf \$6}')" >> speed.sh
echo 'bssid_11=$(iwconfig ath11 | grep Access |' "awk '{printf \$6}')" >> speed.sh
echo 'f2=$(iw dev ath01 info | grep channel |' "awk '{printf \$3}' | sed" "'s/(//g')" >> speed.sh       
echo 'inter2=$(iw dev ath01 scan freq $f2 | grep BSS | wc -l)' >> speed.sh                 
echo 'f5=$(iw dev ath11 info | grep channel |' "awk '{printf \$3}' | sed" "'s/(//g')" >> speed.sh
echo 'inter5=$(iw dev ath11 scan freq $f5 | grep BSS | wc -l)' >> speed.sh
echo 'bintval201=$(iwpriv ath01 get_bintval |' "awk '{printf \$2}' | sed" "'s/'get_bintval:'//g')" >>speed.sh
echo 'bintval511=$(iwpriv ath11 get_bintval |' "awk '{printf \$2}' | sed" "'s/'get_bintval:'//g')" >>speed.sh
echo 'sta_count01=$(iwpriv ath01 get_sta_count |' "awk '{printf \$2}' | sed" "'s/get_sta_count://g')" >> speed.sh
echo 'sta_count11=$(iwpriv ath11 get_sta_count |' "awk '{printf \$2}' | sed" "'s/get_sta_count://g')" >> speed.sh
echo 'mgmt_rate01=$(iwpriv ath01 g_mgmt_rate |' "awk '{printf \$2}' | sed" "'s/g_mgmt_rate://g')" >> speed.sh
echo 'mgmt_rate11=$(iwpriv ath11 g_mgmt_rate |' "awk '{printf \$2}' | sed" "'s/g_mgmt_rate://g')" >> speed.sh                                                            
echo 'ver=$(showver)' >> speed.sh
echo 'tx_power2g01=$(iwlist ath01 txpower | grep Current |' "awk '{printf \$2}' | sed 's/Tx-Power=//g') " >> speed.sh
echo 'tx_power5g11=$(iwlist ath11 txpower | grep Current |' "awk '{printf \$2}' | sed 's/Tx-Power=//g') " >> speed.sh
echo 'ap_model=$(showsysinfo | grep Model |' "awk '{printf \$2}' | sed 's/Model:OAW-//g')" >> speed.sh
#sending the data to the graylog
echo 'echo' $ap_name SSID $ssid1 "BSSID" "\$bssid_01" "Channel" "\$ch_2g01" "Utilization" "\$util_2g01" "Frequency" "\$f2" "Interference" "\$inter2" "Version" "\$ver" Tx_Power "\$tx_power2g01" Beacon-Interval "\$bintval201" Clients_Connected "\$sta_count01" Minimum_MGMT_Rate "\$mgmt_rate01" AP-Model "\$ap_model""| nc" $server $port >> speed.sh
echo 'echo' $ap_name SSID $ssid1 "BSSID" "\$bssid_11" "Channel" "\$ch_5g11" "Utilization" "\$util_5g11" "Frequency" "\$f5" "Interference" "\$inter5" "Version" "\$ver" Tx_Power "\$tx_power5g11" Beacon-Interval "\$bintval511" Clients_Connected "\$sta_count11" Minimum_MGMT_Rate "\$mgmt_rate11" AP-Model "\$ap_model""| nc" $server $port >> speed.sh
}
function ssid2() {
echo "Enter the name of the SSID for the ath02 and ath12:"
echo "!!!!!Do not use special characters (@$-;)"
read ssid2
#populating the signal-to-graylog.sh script
echo "wlanconfig ath02 list | grep '65535\|SNR\|Capability\|capable'" "| awk '{ printf \"%s\""", \$0; if (NR % 5 == 0) print \"\"""; else printf \" \" }' | sed 's/^/"$ap_name $ssid2 "/g' | nc" $server $port >> signal-to-graylog.sh
echo "wlanconfig ath12 list | grep '65535\|SNR\|Capability\|capable'" "| awk '{ printf \"%s\""", \$0; if (NR % 5 == 0) print \"\"""; else printf \" \" }' | sed 's/^/"$ap_name $ssid2 "/g' | nc" $server $port >> signal-to-graylog.sh
#populating the speed.sh with the AP details
echo 'ch_2g02=$(iwlist ath02 channel | grep Current |' "awk '{printf \$5}' | sed" "'s/)//g') " >> speed.sh
echo 'ch_5g12=$(iwlist ath12 channel | grep Current |' "awk '{printf \$5}'| sed" "'s/)//g') " >> speed.sh
echo 'util_2g02=$(iwpriv ath02 get_chutil |' "awk '{printf \$2}' | sed" "'s/get_chutil://g') " >> speed.sh
echo 'util_5g12=$(iwpriv ath12 get_chutil |' "awk '{printf \$2}' | sed" "'s/get_chutil://g') " >> speed.sh
echo 'bssid_02=$(iwconfig ath02 | grep Access |' "awk '{printf \$6}')" >> speed.sh
echo 'bssid_12=$(iwconfig ath12 | grep Access |' "awk '{printf \$6}')" >> speed.sh
echo 'f2=$(iw dev ath02 info | grep channel |' "awk '{printf \$3}' | sed" "'s/(//g')" >> speed.sh       
echo 'inter2=$(iw dev ath02 scan freq $f2 | grep BSS | wc -l)' >> speed.sh                 
echo 'f5=$(iw dev ath12 info | grep channel |' "awk '{printf \$3}' | sed" "'s/(//g')" >> speed.sh
echo 'inter5=$(iw dev ath12 scan freq $f5 | grep BSS | wc -l)' >> speed.sh
echo 'bintval202=$(iwpriv ath02 get_bintval |' "awk '{printf \$2}' | sed" "'s/'get_bintval:'//g')" >>speed.sh
echo 'bintval512=$(iwpriv ath12 get_bintval |' "awk '{printf \$2}' | sed" "'s/'get_bintval:'//g')" >>speed.sh
echo 'sta_count02=$(iwpriv ath02 get_sta_count |' "awk '{printf \$2}' | sed" "'s/get_sta_count://g')" >> speed.sh
echo 'sta_count12=$(iwpriv ath12 get_sta_count |' "awk '{printf \$2}' | sed" "'s/get_sta_count://g')" >> speed.sh
echo 'mgmt_rate02=$(iwpriv ath02 g_mgmt_rate |' "awk '{printf \$2}' | sed" "'s/g_mgmt_rate://g')" >> speed.sh
echo 'mgmt_rate12=$(iwpriv ath12 g_mgmt_rate |' "awk '{printf \$2}' | sed" "'s/g_mgmt_rate://g')" >> speed.sh                                                            
echo 'ver=$(showver)' >> speed.sh
echo 'tx_power2g02=$(iwlist ath02 txpower | grep Current |' "awk '{printf \$2}' | sed 's/Tx-Power=//g') " >> speed.sh
echo 'tx_power5g12=$(iwlist ath12 txpower | grep Current |' "awk '{printf \$2}' | sed 's/Tx-Power=//g') " >> speed.sh
echo 'ap_model=$(showsysinfo | grep Model |' "awk '{printf \$2}' | sed 's/Model:OAW-//g')" >> speed.sh
#sending the data to the graylog
echo 'echo' $ap_name SSID $ssid2 "BSSID" "\$bssid_02" "Channel" "\$ch_2g02" "Utilization" "\$util_2g02" "Frequency" "\$f2" "Interference" "\$inter2" "Version" "\$ver" Tx_Power "\$tx_power2g02" Beacon-Interval "\$bintval202" Clients_Connected "\$sta_count02" Minimum_MGMT_Rate "\$mgmt_rate02" AP-Model "\$ap_model""| nc" $server $port >> speed.sh
echo 'echo' $ap_name SSID $ssid2 "BSSID" "\$bssid_12" "Channel" "\$ch_5g12" "Utilization" "\$util_5g12" "Frequency" "\$f5" "Interference" "\$inter5" "Version" "\$ver" Tx_Power "\$tx_power5g12" Beacon-Interval "\$bintval512" Clients_Connected "\$sta_count12" Minimum_MGMT_Rate "\$mgmt_rate12" AP-Model "\$ap_model""| nc" $server $port >> speed.sh
}
function ssid3() {
echo "Enter the name of the SSID for the ath03 and ath13:"
echo "!!!!!Do not use special characters (@$-;)"
read ssid3
#populating the signal-to-graylog.sh script
echo "wlanconfig ath03 list | grep '65535\|SNR\|Capability\|capable'" "| awk '{ printf \"%s\""", \$0; if (NR % 5 == 0) print \"\"""; else printf \" \" }' | sed 's/^/"$ap_name $ssid1 "/g' | nc" $server $port >> signal-to-graylog.sh
echo "wlanconfig ath13 list | grep '65535\|SNR\|Capability\|capable'" "| awk '{ printf \"%s\""", \$0; if (NR % 5 == 0) print \"\"""; else printf \" \" }' | sed 's/^/"$ap_name $ssid1 "/g' | nc" $server $port >> signal-to-graylog.sh

#populating the speed.sh with the AP details
echo 'ch_2g03=$(iwlist ath03 channel | grep Current |' "awk '{printf \$5}' | sed" "'s/)//g') " >> speed.sh
echo 'ch_5g13=$(iwlist ath13 channel | grep Current |' "awk '{printf \$5}'| sed" "'s/)//g') " >> speed.sh
echo 'util_2g03=$(iwpriv ath03 get_chutil |' "awk '{printf \$2}' | sed" "'s/get_chutil://g') " >> speed.sh
echo 'util_5g13=$(iwpriv ath13 get_chutil |' "awk '{printf \$2}' | sed" "'s/get_chutil://g') " >> speed.sh
echo 'bssid_03=$(iwconfig ath03 | grep Access |' "awk '{printf \$6}')" >> speed.sh
echo 'bssid_13=$(iwconfig ath13 | grep Access |' "awk '{printf \$6}')" >> speed.sh
echo 'f203=$(iw dev ath03 info | grep channel |' "awk '{printf \$3}' | sed" "'s/(//g')" >> speed.sh       
echo 'inter203=$(iw dev ath03 scan freq $f2 | grep BSS | wc -l)' >> speed.sh                 
echo 'f513=$(iw dev ath13 info | grep channel |' "awk '{printf \$3}' | sed" "'s/(//g')" >> speed.sh
echo 'inter513=$(iw dev ath13 scan freq $f5 | grep BSS | wc -l)' >> speed.sh
echo 'bintval203=$(iwpriv ath03 get_bintval |' "awk '{printf \$2}' | sed" "'s/'get_bintval:'//g')" >>speed.sh
echo 'bintval513=$(iwpriv ath13 get_bintval |' "awk '{printf \$2}' | sed" "'s/'get_bintval:'//g')" >>speed.sh
echo 'sta_count03=$(iwpriv ath03 get_sta_count |' "awk '{printf \$2}' | sed" "'s/get_sta_count://g')" >> speed.sh
echo 'sta_count13=$(iwpriv ath13 get_sta_count |' "awk '{printf \$2}' | sed" "'s/get_sta_count://g')" >> speed.sh
echo 'mgmt_rate03=$(iwpriv ath03 g_mgmt_rate |' "awk '{printf \$2}' | sed" "'s/g_mgmt_rate://g')" >> speed.sh
echo 'mgmt_rate13=$(iwpriv ath13 g_mgmt_rate |' "awk '{printf \$2}' | sed" "'s/g_mgmt_rate://g')" >> speed.sh                                                            
echo 'ver=$(shower)' >> speed.sh
echo 'tx_power2g03=$(iwlist ath03 txpower | grep Current |' "awk '{printf \$2}' | sed 's/Tx-Power=//g') " >> speed.sh
echo 'tx_power5g13=$(iwlist ath13 txpower | grep Current |' "awk '{printf \$2}' | sed 's/Tx-Power=//g') " >> speed.sh
echo 'ap_model=$(showsysinfo | grep Model |' "awk '{printf \$2}' | sed 's/Model:OAW-//g')" >> speed.sh
#sending the data to the graylog
echo 'echo' $ap_name SSID $ssid3 "BSSID" "\$bssid_03" "Channel" "\$ch_2g03" "Utilization" "\$util_2g03" "Frequency" "\$f203" "Interference" "\$inter203" "Version" "\$ver" Tx_Power "\$tx_power2g03" Beacon-Interval "\$bintval203" Clients_Connected "\$sta_count03" Minimum_MGMT_Rate "\$mgmt_rate03" AP-Model "\$ap_model""| nc" $server $port >> speed.sh
echo 'echo' $ap_name SSID $ssid3 "BSSID" "\$bssid_13" "Channel" "\$ch_5g13" "Utilization" "\$util_5g13" "Frequency" "\$f513" "Interference" "\$inter513" "Version" "\$ver" Tx_Power "\$tx_power5g13" Beacon-Interval "\$bintval513" Clients_Connected "\$sta_count13" Minimum_MGMT_Rate "\$mgmt_rate13" AP-Model "\$ap_model""| nc" $server $port >> speed.sh
}
function port_monitor() {
echo "Adding the commands into the speed.sh to monitor the port statistics"
echo 'rx1=$(cat /proc/net/dev |grep -w' $adapter "| grep -v '-' | cut -f2 -d""':'" "|awk '{print "\$1"}')" >> speed.sh
echo 'tx1=$(cat /proc/net/dev |grep -w' $adapter "| grep -v '-' | cut -f2 -d""':'" "|awk '{print "\$9"}')" >> speed.sh
echo 'err_rx1=$(cat /proc/net/dev |grep -w' $adapter "| grep -v '-' | cut -f2 -d""':'" "|awk '{print "\$3"}')" >> speed.sh
echo 'err_tx1=$(cat /proc/net/dev |grep -w' $adapter "| grep -v '-' | cut -f2 -d""':'" "|awk '{print "\$11"}')" >> speed.sh
echo 'mcast_rx1=$(cat /proc/net/dev |grep -w' $adapter "| grep -v '-' | cut -f2 -d""':'" "|awk '{print "\$8"}')" >> speed.sh
echo 'mcast_tx1=$(cat /proc/net/dev |grep -w' $adapter "| grep -v '-' | cut -f2 -d""':'" "|awk '{print "\$16"}')" >> speed.sh
echo 'drop_rx1=$(cat /proc/net/dev |grep -w' $adapter "| grep -v '-' | cut -f2 -d""':'" "|awk '{print "\$4"}')" >> speed.sh
echo 'drop_tx1=$(cat /proc/net/dev |grep -w' $adapter "| grep -v '-' | cut -f2 -d""':'" "|awk '{print "\$12"}')" >> speed.sh
echo 'sleep 1'  >> speed.sh
echo 'rx2=$(cat /proc/net/dev |grep -w' $adapter "| grep -v '-' | cut -f2 -d""':'" "|awk '{print "\$1"}')" >> speed.sh
echo 'tx2=$(cat /proc/net/dev |grep -w' $adapter "| grep -v '-' | cut -f2 -d""':'" "|awk '{print "\$9"}')" >> speed.sh
echo 'err_rx2=$(cat /proc/net/dev |grep -w' $adapter "| grep -v '-' | cut -f2 -d""':'" "|awk '{print "\$3"}')" >> speed.sh
echo 'err_tx2=$(cat /proc/net/dev |grep -w' $adapter "| grep -v '-' | cut -f2 -d""':'" "|awk '{print "\$11"}')" >> speed.sh
echo 'mcast_rx2=$(cat /proc/net/dev |grep -w' $adapter "| grep -v '-' | cut -f2 -d""':'" "|awk '{print "\$8"}')" >> speed.sh
echo 'mcast_tx2=$(cat /proc/net/dev |grep -w' $adapter "| grep -v '-' | cut -f2 -d""':'" "|awk '{print "\$16"}')" >> speed.sh
echo 'drop_rx2=$(cat /proc/net/dev |grep -w' $adapter "| grep -v '-' | cut -f2 -d""':'" "|awk '{print "\$4"}')" >> speed.sh
echo 'drop_tx2=$(cat /proc/net/dev |grep -w' $adapter "| grep -v '-' | cut -f2 -d""':'" "|awk '{print "\$12"}')" >> speed.sh
echo 'tx=$(($tx2 - $tx1))' >> speed.sh
echo 'rx=$(($rx2 - $rx1))' >> speed.sh
echo 'err_rx=$(($err_rx2 - $err_rx1))' >> speed.sh
echo 'err_tx=$(($err_tx2 - $err_tx1))' >> speed.sh
echo 'mcast_rx=$(($mcast_rx2 - $mcast_rx1))' >> speed.sh
echo 'mcast_tx=$(($mcast_tx2 - $mcast_tx1))' >> speed.sh
echo 'drop_rx=$(($drop_rx2 - $drop_rx1))' >> speed.sh
echo 'drop_tx=$(($drop_tx2 - $drop_tx1))' >> speed.sh
echo 'echo' $ap_name $adapter 'TX_Bytes_sec $tx Bps TX_Err_packets $err_tx packets TX_Mcast_packets $mcast_tx pps TX_Drops_packets $drop_tx pps RX_Bytes_sec $rx Bps RX_Err_packets $err_rx pps RX_Mcast_packets $mcast_rx pps RX_Drops_packets $drop_rx pps| nc' $server $port >>speed.sh
}
function cpu_monitor() {
echo "adding the commands to monitor the CPU/Memory utilization and temperature"
echo "c=\$""(sar -P ALL 1 1 | grep all | tail -1 | cut -b 75-79)" >> speed.sh
echo "m=\$""(sar -r 1 1 | grep Average | awk '{print \$""2}')" >> speed.sh
echo "m1=\$""((\$""m/1000))" >> speed.sh
echo "t=\$""(cat /sys/devices/virtual/thermal/thermal_zone0/temp)" >> speed.sh
echo 'echo' $ap_name "CPU_free" "\$c" "percent Memory_free ""\$""m1 Mb CPU_temperature ""\$""t Celsius | nc" $server $port >> speed.sh
} 
clear
echo "This script will create 2 scripts, one named speed.sh to measure and monitor the Utilization in Bytes and packets of throughput, multicast, errors and drops and the other one named signal-to-graylog.sh to monitor the signal and throughput quality"
echo "Warning: do not run multiple times this script without remove the crontab jobs and the scripts previously created"
echo "do you understand the warning above?"
read warning
echo ""
echo "----------------------------------------------------------------------------------------"
echo "AP utilization, multicast, errors and drops script questions"
echo "----------------------------------------------------------------------------------------"
echo "Which interface is connecting the AP to the wired network (eth0 or eth1) or if the AP is a Mesh point AP,to the mesh backbone (athsta1)"
read adapter
echo "Give a short name to this AP, do not use special characters on the name:"
read ap_name
echo "Graylog server ip address or domain name:"
read server
echo "Port used in the Graylog server:"
read port
echo ""
port_monitor
cpu_monitor
echo making executable the speed.sh script
chmod +x speed.sh
echo ""
echo "----------------------------------------------------------------------------------------"
echo "Signal quality script questions"
echo "----------------------------------------------------------------------------------------"
echo " Would you like to monitor ath01 and ath11? 1=yes, 2=no"
read answer
if [ $answer -eq 1 ]
then 
	ssid1
elif [ $answer -eq 2 ]
then
	echo "skipping to the next question"
else
	echo "skipping to the next question"
fi
echo " Would you like to monitor ath02 and ath12? 1=yes, 2=no"
read answer
if [ $answer -eq 1 ]
then 
	ssid2
elif [ $answer -eq 2 ]
then
	echo "finishing the script"
else
	echo "finishing the script"
fi
echo " Would you like to monitor ath03 and ath13? 1=yes, 2=no"
read answer
if [ $answer -eq 1 ]
then 
	ssid3
elif [ $answer -eq 2 ]
then
	echo "finishing the script"
else
	echo "finishing the script"
fi
#Creating the signal-to-graylog.sh script
#echo 'cat /tmp/log/lbd.log | grep bandmonCmnDetermineOperatingRegion | tail -2 | sed' "'s/^/"$ap_name "/g' | nc" $server $port >> signal-to-graylog.sh
chmod +x signal-to-graylog.sh

echo adding the speed.sh to the crontab
echo '* * * * * ( /root/speed.sh ; /root/signal-to-graylog.sh )' >> /var/spool/cron/crontabs/root
echo '* * * * * ( sleep 10 ; /root/speed.sh ; /root/signal-to-graylog.sh )' >> /var/spool/cron/crontabs/root
echo '* * * * * ( sleep 20 ; /root/speed.sh ; /root/signal-to-graylog.sh )' >> /var/spool/cron/crontabs/root
echo '* * * * * ( sleep 30 ; /root/speed.sh ; /root/signal-to-graylog.sh )' >> /var/spool/cron/crontabs/root
echo '* * * * * ( sleep 40 ; /root/speed.sh ; /root/signal-to-graylog.sh )' >> /var/spool/cron/crontabs/root
echo '* * * * * ( sleep 50 ; /root/speed.sh ; /root/signal-to-graylog.sh )' >> /var/spool/cron/crontabs/root
echo "speed.sh and signal-to-graylog.sh scripts configured and scheduled"


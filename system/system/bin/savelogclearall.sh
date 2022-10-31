#!/system/bin/sh
asuswlanfwlog_flag=`getprop persist.odm.asus.wlanfwdbg`
chmod -R 777 /data/media/0/Asuslog
chmod -R 777 /data/media/0/save_log
rm -rf /data/media/0/Asuslog
rm -rf /data/media/0/save_log
if [ ".$asuswlanfwlog_flag" == ".0" ];then
rm -r /data/vendor/wifi/wlan_logs/*
rm -r /data/vendor/wifi/wlan_logs
echo " rm -r  /data/vendor/wifi/wlan_logs"
fi

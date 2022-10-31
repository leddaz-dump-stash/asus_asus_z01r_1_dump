#!/system/bin/sh
action_log='/dev/console'
echo "[ASUS] enter init.asus.savelogmtp.sh" > $action_log
# savelog
SAVE_LOG_ROOT=/data/media/0/save_log
CHECK_DUMPSTATE_OK=`getprop init.svc.bugreport`
BUGREPORT_PATH=/data/user_de/0/com.android.shell/files/bugreports
asuswlanfwlog_flag=`getprop persist.odm.asus.wlanfwdbg`

# check mount file
	umask 0;
	sync
############################################################################################	
	# create savelog folder (UTC)
     SAVE_LOG_PATH="$SAVE_LOG_ROOT/`date +%Y_%m_%d_%H_%M_%S`"
     mkdir -p $SAVE_LOG_PATH
     setprop asus.savelogmtp.folder $SAVE_LOG_PATH
     setprop persist.asuslog.procrankdump.enable 1

	chmod -R 777 $SAVE_LOG_PATH
	chmod -R 777 $SAVE_LOG_ROOT
	echo "mkdir -p $SAVE_LOG_PATH"
############################################################################################
# save cpu time stat
echo "cpu time in state" > $SAVE_LOG_PATH/time_in_state.txt
for i in 0 1 2 3 4 5 6 7
do
	#statements
	echo "cpu " $i >> $SAVE_LOG_PATH/time_in_state.txt
	cat /sys/devices/system/cpu/cpu$i/cpufreq/stats/time_in_state >> $SAVE_LOG_PATH/time_in_state.txt
done

############################################################################################
# save memblock memory log
	cat /sys/kernel/debug/memblock/memory > $SAVE_LOG_PATH/sys_kernel_debug__memblock_memory.txt
############################################################################################
############################################################################################
# save top log
	top -H -n 1 > $SAVE_LOG_PATH/top.txt
############################################################################################
	# save cmdline
	cat /proc/cmdline > $SAVE_LOG_PATH/cmdline.txt
	echo "cat /proc/cmdline > $SAVE_LOG_PATH/cmdline.txt"	
############################################################################################
	# save mount table
	cat /proc/mounts > $SAVE_LOG_PATH/mounts.txt
	echo "cat /proc/mounts > $SAVE_LOG_PATH/mounts.txt"
############################################################################################
	getenforce > $SAVE_LOG_PATH/getenforce.txt
	echo "getenforce > $SAVE_LOG_PATH/getenforce.txt"
############################################################################################
	# save property
	getprop > $SAVE_LOG_PATH/getprop.txt
	echo "getprop > $SAVE_LOG_PATH/getprop.txt"
############################################################################################
	# save space used status
	df > $SAVE_LOG_PATH/df.txt
	echo "df > $SAVE_LOG_PATH/df.txt"
############################################################################################
	# save network info
	route -n > $SAVE_LOG_PATH/route.txt
	echo "route -n > $SAVE_LOG_PATH/route.txt"
	ifconfig -a > $SAVE_LOG_PATH/ifconfig.txt
	echo "ifconfig -a > $SAVE_LOG_PATH/ifconfig.txt"
############################################################################################
	# save software version
	echo "AP_VER: `getprop ro.build.display.id`" > $SAVE_LOG_PATH/version.txt
	echo "CP_VER: `getprop gsm.version.baseband`" >> $SAVE_LOG_PATH/version.txt
	echo "BT_VER: `getprop bt.version.driver`" >> $SAVE_LOG_PATH/version.txt
	echo "WIFI_VER: `getprop wifi.version.driver`" >> $SAVE_LOG_PATH/version.txt
	echo "GPS_VER: `getprop gps.version.driver`" >> $SAVE_LOG_PATH/version.txt
	echo "BUILD_DATE: `getprop ro.build.date`" >> $SAVE_LOG_PATH/version.txt
	echo "`cat /proc/bootinfo`" >> $SAVE_LOG_PATH/version.txt
############################################################################################
	# save load kernel modules
	lsmod > $SAVE_LOG_PATH/lsmod.txt
	echo "lsmod > $SAVE_LOG_PATH/lsmod.txt"
############################################################################################
	# save process now
	ps -A > $SAVE_LOG_PATH/ps.txt
	echo "ps > $SAVE_LOG_PATH/ps.txt"
	ps -To user,pid,ppid,vsz,rss,args > $SAVE_LOG_PATH/ps_thread.txt
	echo "ps > $SAVE_LOG_PATH/ps_thread.txt"
############################################################################################
	# save kernel message
	dmesg > $SAVE_LOG_PATH/dmesg.txt
	echo "dmesg > $SAVE_LOG_PATH/dmesg.txt"
############################################################################################
	# copy data/log to data/media
	ls -R -l /data/log/ > $SAVE_LOG_PATH/ls_data_log.txt
	mkdir $SAVE_LOG_PATH/log
	cp -rf /data/log/* $SAVE_LOG_PATH/log/
	echo "mv /data/log $SAVE_LOG_PATH"
	
	ls -R -l /data/Asuslog/dumpsys/ > $SAVE_LOG_PATH/ls_data_asuslog.txt
	mkdir $SAVE_LOG_PATH/Dumpsys
	cp -rf  /data/Asuslog/dumpsys/* $SAVE_LOG_PATH/Dumpsys/

#	chmod -R 777 /sdcard/asus_dump
#	mv /sdcard/asus_dump/* $SAVE_LOG_PATH/Dumpsys/
	echo "mv /data/Asuslog/dumpsys/ $SAVE_LOG_PATH"
	
############################################################################################
	# copy data/tombstones to data/media
	ls -R -l /data/tombstones/ > $SAVE_LOG_PATH/ls_data_tombstones.txt
	mkdir $SAVE_LOG_PATH/tombstones
	cp -r /data/tombstones/* $SAVE_LOG_PATH/tombstones/
	echo "mv /data/tombstones $SAVE_LOG_PATH"	
############################################################################################
	# copy data/tombstones to data/media
	#ls -R -l /tombstones/mdm > $SAVE_LOG_PATH/ls_tombstones_mdm.txt
	mkdir -p /data/tombstones/dsps
	mkdir -p /data/tombstones/lpass
	mkdir -p /data/tombstones/mdm
	mkdir -p /data/tombstones/modem
	mkdir -p /data/tombstones/wcnss
	chown system.system /data/tombstones/*
	chmod 771 /data/tombstones/*
############################################################################################
	# copy Debug Ion information to data/media
	mkdir $SAVE_LOG_PATH/ION_Debug
	cp /d/ion/* $SAVE_LOG_PATH/ION_Debug/
############################################################################################
	# copy data/logcat_log to data/media
	ls -R -l /data/logcat_log/ > $SAVE_LOG_PATH/ls_data_logcat_log.txt
	cp -r /data/logcat_log $SAVE_LOG_PATH
	echo "cp -r /data/logcat_log $SAVE_LOG_PATH"
############################################################################################
	# copy /vendor/asdf/ASUSEvtlog.txt to ASDF
	cp -r /sdcard/asus_log/ASUSEvtlog.txt $SAVE_LOG_PATH #backward compatible
	cp -r /sdcard/asus_log/ASUSEvtlog_old.txt $SAVE_LOG_PATH #backward compatible
	cp -r /vendor/asdf/ASUSEvtlog.txt $SAVE_LOG_PATH
	cp -r /vendor/asdf/ASUSEvtlog_old.txt $SAVE_LOG_PATH
	cp -r /vendor/asdf/ASUS_VBUS_low_impedance.txt $SAVE_LOG_PATH
	cp -r /vendor/asdf/gaugeMappingBackup $SAVE_LOG_PATH
	cp -r /vendor/asdf/ASUS_AICL_suspend.txt $SAVE_LOG_PATH
	cp -rf /vendor/asdf $SAVE_LOG_PATH
	cp -rf /vendor/asdf/recovery $SAVE_LOG_PATH
	rm -r /asdf/ASDF/ASDF.*
	echo " cp -r /vendor/asdf/ASUSEvtlog.txt $SAVE_LOG_PATH"
############################################################################################
	# copy /asdf/ASUS_thermal_alert.txt to ASDF
	mkdir $SAVE_LOG_PATH/Power_Err_log
	cp -r /vendor/asdf/ASUS_thermal_alert.txt $SAVE_LOG_PATH/Power_Err_log
	cp -r /vendor/asdf/ASUS_thermal_alert_old.txt $SAVE_LOG_PATH/Power_Err_log
	cp -r /vendor/asdf/ASUS_JEITA_hard_hot.txt $SAVE_LOG_PATH/Power_Err_log
	cp -r /vendor/asdf/ASUS_JEITA_hard_hot_old.txt $SAVE_LOG_PATH/Power_Err_log
	cp -r /vendor/asdf/ASUS_JEITA_hard_cold.txt $SAVE_LOG_PATH/Power_Err_log
	cp -r /vendor/asdf/ASUS_JEITA_hard_cold_old.txt $SAVE_LOG_PATH/Power_Err_log
	cp -r /vendor/asdf/ASUS_Output_OVP.txt $SAVE_LOG_PATH/Power_Err_log
	cp -r /vendor/asdf/ASUS_Output_OVP_old.txt $SAVE_LOG_PATH/Power_Err_log
	cp -r /vendor/asdf/ASUS_JEITA_soft_hot.txt $SAVE_LOG_PATH/Power_Err_log
	cp -r /vendor/asdf/ASUS_JEITA_soft_hot_old.txt $SAVE_LOG_PATH/Power_Err_log
	cp -r /vendor/asdf/ASUS_BAT_OVP.txt $SAVE_LOG_PATH/Power_Err_log
	cp -r /vendor/asdf/ASUS_BAT_OVP_old.txt $SAVE_LOG_PATH/Power_Err_log
	cp -r /vendor/asdf/ASUS_Water_alert.txt $SAVE_LOG_PATH/Power_Err_log
	cp -r /vendor/asdf/ASUS_Water_alert_old.txt $SAVE_LOG_PATH/Power_Err_log
	echo " cp -r /vendor/asdf/ASUS_thermal_alert.txt $SAVE_LOG_PATH/Power_Err_log"
############################################################################################
	# copy /data/misc/wifi/wpa_supplicant.conf
	# copy /data/misc/wifi/hostapd.conf
	# copy /data/misc/wifi/p2p_supplicant.conf
	ls -R -l /data/misc/wifi/ > $SAVE_LOG_PATH/ls_wifi_asus_log.txt
	cp -r /data/misc/wifi/wpa_supplicant.conf $SAVE_LOG_PATH
	echo "cp -r /data/misc/wifi/wpa_supplicant.conf $SAVE_LOG_PATH"
	cp -r /data/misc/wifi/hostapd.conf $SAVE_LOG_PATH
	echo "cp -r /data/misc/wifi/hostapd.conf $SAVE_LOG_PATH"
    cp -r /data/misc/wifi/p2p_supplicant.conf $SAVE_LOG_PATH
	echo "cp -r /data/misc/wifi/p2p_supplicant.conf $SAVE_LOG_PATH"
############################################################################################
	# mv /data/anr to data/media
	ls -R -l /data/anr > $SAVE_LOG_PATH/ls_data_anr.txt
	mkdir $SAVE_LOG_PATH/anr
	cp -rf  /data/anr/* $SAVE_LOG_PATH/anr/
	echo " mv /data/anr $SAVE_LOG_PATH"
############################################################################################
	# copy /data/vendor/wifi/wlan_logs   data/media
	if [ ".$asuswlanfwlog_flag" == ".1" ];then
	mkdir $SAVE_LOG_PATH/wifi
	cp -r /data/vendor/wifi/wlan_logs/* $SAVE_LOG_PATH/wifi/
	echo " copy  /data/vendor/wifi/wlan_logs $SAVE_LOG_PATH"
	fi
############################################################################################
	# copy asusdbg(reset debug message) to /data/media
#	$ mkdir -p $SAVE_LOG_PATH/resetdbg
#	dd if=/dev/block/platform/msm_sdcc.1/by-name/ramdump of=$SAVE_LOG_PATH/resetdbg/kernelmessage.txt count=512
#	echo "copy asusdbg(reset debug message) to $SAVE_LOG_PATH/resetdbg"
############################################################################################
#is_ramdump_exist=` cat /proc/cmdline |  grep RAMDUMP`
#if  test "$is_ramdump_exist"; then
#	dd if=/dev/block/platform/msm_sdcc.1/by-name/ramdump of=$SAVE_LOG_PATH/IMEM_C.BIN count=8 skip=512
#	dd if=/dev/block/platform/msm_sdcc.1/by-name/ramdump of=$SAVE_LOG_PATH/EBICS0.BIN count=2097152 skip=2048
#	echo "copy RAMDUMP.bin to $SAVE_LOG_PATH"
#fi	
############################################################################################
	# mv /data/media/ap_ramdump  to data/media
	ls -R -l /data/media/ap_ramdump > $SAVE_LOG_PATH/ls_data_media_ap_ramdump.txt
	mkdir $SAVE_LOG_PATH/ap_ramdump
	mv /data/media/ap_ramdump/* $SAVE_LOG_PATH/ap_ramdump/
	echo " mv /data/media/ap_ramdump $SAVE_LOG_PATH"
############################################################################################
	# save system information
	date > $SAVE_LOG_PATH/date.txt
	echo "date > $SAVE_LOG_PATH/date.txt"

#	for x in SurfaceFlinger activity input_method alarm power battery batterystats audio cpuinfo meminfo power wifi diskstats; do
#		dumpsys $x > $SAVE_LOG_PATH/$x.txt
#		echo "dumpsys $x > $SAVE_LOG_PATH/$x.txt"
#	done

#	dumpsys window -a > $SAVE_LOG_PATH/window.txt
############################################################################################	
	# save debug report
#	dumpsys > $SAVE_LOG_PATH/bugreport.txt
#	echo "dumpsys > $SAVE_LOG_PATH/bugreport.txt"
############################################################################################
#	mv /data/media/0/diag_logs/QXDM_logs/ $SAVE_LOG_PATH
#	echo "mv /data/media/0/diag_logs/QXDM_logs $SAVE_LOG_PATH"
############################################################################################
	mkdir $SAVE_LOG_PATH/Modem
	cp -rf /data/media/0/Asuslog/Modem/* $SAVE_LOG_PATH/Modem/
	echo "cp /data/media/0/Asuslog/Modem $SAVE_LOG_PATH"
############################################################################################
	mkdir $SAVE_LOG_PATH/TcpDump
	cp -rf /data/media/0/Asuslog/TcpDump/* $SAVE_LOG_PATH/TcpDump/
	echo "cp /data/media/0/Asuslog/TcpDump $SAVE_LOG_PATH"
	
	mkdir $SAVE_LOG_PATH/QSEE
	cp -rf /data/media/0/Asuslog/QSEE/* $SAVE_LOG_PATH/QSEE/
	echo "cp /data/media/0/Asuslog/QSEE $SAVE_LOG_PATH"
	
	mkdir $SAVE_LOG_PATH/TZ
	cp -rf /data/media/0/Asuslog/TZ/* $SAVE_LOG_PATH/TZ/
	echo "cp /data/media/0/Asuslog/TZ $SAVE_LOG_PATH"
############################################################################################

	cp -rf /data/misc/bluetooth/logs/bt* $SAVE_LOG_PATH/
	echo "cp /data/misc/bluetooth/logs/btsnoop_hci.log $SAVE_LOG_PATH"

	mkdir $SAVE_LOG_PATH/bt_ramdump
	cp -rf /data/vendor/ramdump/bluetooth/* $SAVE_LOG_PATH/bt_ramdump/
	echo "cp /data/vendor/ramdump/bluetooth/*  $SAVE_LOG_PATH/bt_ramdump/"

	mv -r /data/media/0/bt* $SAVE_LOG_PATH/
	echo "cp /data/media/0/btsnoop_hci.log $SAVE_LOG_PATH"
	
	mv -r /data/media/0/Asuslog/v4l2_dump_user.264 $SAVE_LOG_PATH/
	echo "cp /data/media/0/Asuslog/v4l2_dump_user.264 $SAVE_LOG_PATH"
	
	mv -r /data/media/dump.ts $SAVE_LOG_PATH/
	echo "cp /data/media/dump.ts $SAVE_LOG_PATH"
############################################################################################
	mv  /data/media/0/modemcrash.txt $SAVE_LOG_PATH/modemcrash.txt
	echo "cp /data/media/0/modemcrash.txt $SAVE_LOG_PATH"
############################################################################################
	mv -r /data/media/0/Wifi/* $SAVE_LOG_PATH/
	echo "cp /data/Asuslog/ $SAVE_LOG_PATH"
############################################################################################
	# mv /data/vendor/ramdump (modemCrash)
	ls -R -l /data/ramdump > $SAVE_LOG_PATH/ls_data_ramdump.txt
	mkdir $SAVE_LOG_PATH/data_ramdump
	mv /data/vendor/ramdump/* $SAVE_LOG_PATH/data_ramdump/
	chmod -R 777 $SAVE_LOG_PATH/data_ramdump/*
	echo " mv  /data/vendor/ramdump $SAVE_LOG_PATH"
############################################################################################
        micropTest=`cat /sys/class/switch/pfs_pad_ec/state`
	if [ "${micropTest}" = "1" ]; then
	date > $SAVE_LOG_PATH/microp_dump.txt
	cat /d/gpio >> $SAVE_LOG_PATH/microp_dump.txt                   
        echo "cat /d/gpio > $SAVE_LOG_PATH/microp_dump.txt"  
         cat /d/microp >> $SAVE_LOG_PATH/microp_dump.txt
        echo "cat /d/microp > $SAVE_LOG_PATH/microp_dump.txt"
	fi
############################################################################################
    # save pmic reg dump
    pmicRegDump=`getprop persist.asuslog.pmiclog.enable`
    if [ ".$pmicRegDump" == ".1" ]; then
        setprop asus.logtool.pmiclog.capture $SAVE_LOG_PATH
    fi
############################################################################################
generate_bugreport ()
{
	setprop debug.asus.savelogmtp.dumpstate 1
	if [ ".$CHECK_DUMPSTATE_OK" == "." ]; then
		sleep 2
	fi
	
	for i in $(seq 60); do
		CHECK_DUMPSTATE_OK=`getprop init.svc.bugreport`
		loge "bugreport=$CHECK_DUMPSTATE_OK, waiting for it stopped..."
		if [ ".$CHECK_DUMPSTATE_OK" == ".stopped" ]; then
			break
		elif [ ".$CHECK_DUMPSTATE_OK" == "." ]; then
			break
		else
			sleep 2
		fi
	done;
	
	setprop debug.asus.savelogmtp.dumpstate 0
	
	loge "copy bugreport to SAVE_LOG_PATH folder"

	chmod -R  777 $BUGREPORT_PATH/
	
	for filename in $BUGREPORT_PATH/*; do
		name=${filename##*/}
		loge "copy $filename to $GENERAL_LOG"
		cp  $filename $SAVE_LOG_PATH
		rm $filename
	done
	
	loge "Generating bugreport completed"
}
#############################################################################################
     #generate_bugreport to SAVE_LOG_PATH
	generate_bugreport

#############################################################################################
     #procrankdump to SAVE_LOG_PATH
	mkdir $SAVE_LOG_PATH/procrankdump
	cp -rf /data/media/0/memleak_test/* $SAVE_LOG_PATH/procrankdump/
	echo "cp /data/media/0/memleak_test $SAVE_LOG_PATH"

#############################################################################################
     #cp du_ak_data to SAVE_LOG_PATH
	cp -rf $SAVE_LOG_PATH/procrankdump/du_ak_data.txt $SAVE_LOG_PATH/du_ak_data.txt
	echo "cp du _ak _data $SAVE_LOG_PATH"

############################################################################################
	# sync data to disk 
	# 1015 sdcard_rw
	chmod -R 777 $SAVE_LOG_PATH
	chmod -R 777 $SAVE_LOG_ROOT
	sync
#am broadcast -a android.intent.action.MEDIA_MOUNTED --ez read-only false -d file:///storage/emulated/0/

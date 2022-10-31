#!/system/bin/sh

PRELOGCAT_LOG=`getprop persist.asus.prelogcatlog`

if [ ".$PRELOGCAT_LOG" == "." ];then
	setprop persist.asus.prelogcatlog 1
	rm -rf  /data/logcat_log/prelogcat1.txt
	/system/bin/logcat -b kernel -b main -b system -b crash -r 10000 -n 1 -v threadtime  -f /data/logcat_log/prelogcat1.txt
elif [ ".$PRELOGCAT_LOG" == ".1" ]; then
	setprop persist.asus.prelogcatlog 2
	rm -rf  /data/logcat_log/prelogcat1.txt
	/system/bin/logcat -b kernel -b main -b system -b crash -r 10000 -n 1 -v threadtime  -f /data/logcat_log/prelogcat1.txt
elif [ ".$PRELOGCAT_LOG" == ".2" ]; then
	setprop persist.asus.prelogcatlog 3
	rm -rf  /data/logcat_log/prelogcat2.txt
	/system/bin/logcat -b kernel -b main -b system -b crash -r 10000 -n 1 -v threadtime -f /data/logcat_log/prelogcat2.txt
elif [ ".$PRELOGCAT_LOG" == ".3" ]; then
	setprop persist.asus.prelogcatlog 4
	rm -rf  /data/logcat_log/prelogcat3.txt
	/system/bin/logcat -b kernel -b main -b system -b crash -r 10000 -n 1 -v threadtime -f /data/logcat_log/prelogcat3.txt
elif [ ".$PRELOGCAT_LOG" == ".4" ]; then
	setprop persist.asus.prelogcatlog 5
	rm -rf  /data/logcat_log/prelogcat4.txt
	/system/bin/logcat -b kernel -b main -b system -b crash -r 10000 -n 1 -v threadtime -f /data/logcat_log/prelogcat4.txt
elif [ ".$PRELOGCAT_LOG" == ".5" ]; then
	setprop persist.asus.prelogcatlog 1
	rm -rf  /data/logcat_log/prelogcat5.txt
	/system/bin/logcat -b kernel -b main -b system -b crash -r 10000 -n 1 -v threadtime -f /data/logcat_log/prelogcat5.txt
fi

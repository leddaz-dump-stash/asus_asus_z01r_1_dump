#!/system/bin/sh

broadcast_content=`getprop persist.asus.broadcast`

if [ ".$broadcast_content" == "." ];then 
      	echo "do nothing"
elif [ ".$broadcast_content" == ".0" ];then 
      	echo "do nothing"
else
	am broadcast -a  $broadcast_content  -n 'com.asus.loguploader/.logtool.LogtoolReceiver'
	setprop persist.asus.broadcast 0
fi

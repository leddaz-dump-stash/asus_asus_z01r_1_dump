LOG_TAG="AsusTop"
logi ()
{
	/system/bin/log -t $LOG_TAG -p i "$@"
}
top_command=`top -n 1`
logi "$top_command"




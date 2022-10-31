#!/system/bin/sh -x
#This is normal mode

#disable CABC function
echo 1 > /proc/cabc_mode_switch
sleep 1.5
echo 0 > /proc/cabc_mode_switch

setprop persist.asus.power.mode normal

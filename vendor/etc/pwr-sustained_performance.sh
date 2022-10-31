#!/system/bin/sh
#This is sustained performance mode, set cpu to performance mode.

echo 1 > /sys/devices/system/cpu/cpu1/online
echo 1 > /sys/devices/system/cpu/cpu2/online
echo 1 > /sys/devices/system/cpu/cpu3/online
echo 1 > /sys/devices/system/cpu/cpu4/online
echo 1 > /sys/devices/system/cpu/cpu5/online
echo 1 > /sys/devices/system/cpu/cpu6/online
echo 1 > /sys/devices/system/cpu/cpu7/online

# configure governor settings for little cluster
echo "userspace" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 1766400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed

# configure governor settings for big cluster
echo "userspace" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo 2803200 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_setspeed

echo "GPU performance mode"
echo 0 > /sys/class/kgsl/kgsl-3d0/bus_split
echo performance > /sys/class/kgsl/kgsl-3d0/devfreq/governor
echo 1 > /sys/class/kgsl/kgsl-3d0/force_bus_on
echo 1 > /sys/class/kgsl/kgsl-3d0/force_rail_on
echo 1 > /sys/class/kgsl/kgsl-3d0/force_clk_on
echo 1000000 > /sys/class/kgsl/kgsl-3d0/idle_timer

echo "clkscale_enable"
echo 0 > /sys/class/scsi_host/host0/../../../clkscale_enable

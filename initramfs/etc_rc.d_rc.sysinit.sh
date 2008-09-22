#!/bin/sh
# --- SDE-COPYRIGHT-NOTE-BEGIN ---
# This copyright note is auto-generated by ./scripts/Create-CopyPatch.
#
# Filename: target/idunn/initramfs/etc_rc.d_rc.sysinit.sh
# Copyright (C) 2008 The OpenSDE Project
#
# More information can be found in the files COPYING and README.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License. A copy of the
# GNU General Public License can be found in the file COPYING.
# --- SDE-COPYRIGHT-NOTE-END ---

. /etc/rc.d/functions.in

banner "I am Idunn, take an apple and live forever."

# keep the console clean
[ -x /bin/dmesg ] && /bin/dmesg -n 3

title "Mounting special filesystems"
check mount -n -t proc proc /proc
check mount -n -t usbfs none /proc/bus/usb
check mount -n -t sysfs sysfs /sys
check mount -n -t tmpfs tmp /tmp
status

title "Preparing /dev"
check mount -n -t tmpfs udev /dev
check mkdir /dev/pts
check mount -n -t devpts devpts /dev/pts
check cp -a /lib/udev/devices/* /dev
status

title "Starting supervisor"
check start-stop-daemon -S -b -x /usr/bin/runsvdir -- /var/service/
status

# assuming the network module is built-in, start it earlier
for x in $(unet pending); do
	title "Starting network (interface:$x)"
	check unet $x up
	status
done

# wait for udev
while [ ! -d /dev/.udev/ ]; do
	sleep 1;
done

# load/blacklist modules
if [ -x /sbin/modprobe -a -n "$modules" ]; then
	title "Preloading requested kernel modules"
	for x in $(echo "$modules" | tr ':' ' '); do
		if expr "$x" : - > /dev/null; then
			echo "blacklist ${x#-}" >> /etc/modprobe.conf
		else
			check modprobe $(echo "$x" | tr ',' ' ')
		fi
	done
	status
fi

title "Triggering coldplug"
check udevtrigger
check udevsettle
status

# and for those which appeared after udevtrigger
for x in $(unet pending); do
	title "Starting network (interface:$x)"
	check unet $x up
	status
done

#!/bin/sh
# --- SDE-COPYRIGHT-NOTE-BEGIN ---
# This copyright note is auto-generated by ./scripts/Create-CopyPatch.
#
# Filename: target/idunn/initramfs/etc_rc.d_rc.trymount.sh
# Copyright (C) 2008 The OpenSDE Project
#
# More information can be found in the files COPYING and README.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License. A copy of the
# GNU General Public License can be found in the file COPYING.
# --- SDE-COPYRIGHT-NOTE-END ---

. /etc/conf/idunn

if [ "x$1" = "x-v" ]; then
	verbose=yes
else
	verbose=
fi

if grep -q "^[^ ]* $rootfs " /proc/mounts; then
	# alredy mounted
	error=0
elif [ -n "$root" ]; then
	. /etc/rc.d/functions.in

	title "Mouting $root at $rootfs."
	check /lib/udev/vol_id "$root" > /tmp/vol_id.$$
	. /tmp/vol_id.$$
	rm -f /tmp/vol_id.$$

	if [ -n "$ID_FS_TYPE" ]; then
		modprobe -q "$ID_FS_TYPE"
		check mount -t "$ID_FS_TYPE" -o "$root_mode" "$root" "$rootfs"
	else
		check false
	fi

	status	
else
	[ -z "$verbose" ] ||
		cat <<-EOT >&2
		sorry, root device not specified.
		mount it at $rootfs and try again
		EOT
	error=1
fi
exit ${error:-0}
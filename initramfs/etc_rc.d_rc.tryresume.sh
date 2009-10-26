#!/bin/sh
# --- SDE-COPYRIGHT-NOTE-BEGIN ---
# This copyright note is auto-generated by ./scripts/Create-CopyPatch.
#
# Filename: target/idunn/initramfs/etc_rc.d_rc.tryresume.sh
# Copyright (C) 2008 - 2009 The OpenSDE Project
#
# More information can be found in the files COPYING and README.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License. A copy of the
# GNU General Public License can be found in the file COPYING.
# --- SDE-COPYRIGHT-NOTE-END ---

. /etc/rc.d/functions.in
. /etc/conf/idunn

if grep -q "^[^ ]* $rootfs " /proc/mounts; then
	if ! grep -q "^[^ ]* $rootfs [^ ]* $root_mode[, ]" /proc/mounts; then
		title "Remouting $rootfs as $root_mode"
		check mount -o remount,$root_mode "$rootfs"
		status
	fi

	title "Checking for init ($init)"
	if [ -n "$init" -a -x "$rootfs$init" ]; then
		check touch /var/run/.idunn-resume
	else
		check false
	fi
	status
else
	error=1
fi

exit $error
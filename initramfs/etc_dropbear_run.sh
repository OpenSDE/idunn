#!/bin/sh
# --- SDE-COPYRIGHT-NOTE-BEGIN ---
# This copyright note is auto-generated by ./scripts/Create-CopyPatch.
#
# Filename: target/idunn/initramfs/etc_dropbear_run.sh
# Copyright (C) 2008 The OpenSDE Project
#
# More information can be found in the files COPYING and README.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License. A copy of the
# GNU General Public License can be found in the file COPYING.
# --- SDE-COPYRIGHT-NOTE-END ---

exec 2>&1

[ -e /dev/urandom ] || exit 111

for t in rsa dss; do
	dbkey=/etc/dropbear/dropbear_${t}_host_key

	[ -s "$dbkey" ] || dropbearkey -t $t -f $dbkey
done

exec dropbear -F -E

#!/bin/sh
# --- SDE-COPYRIGHT-NOTE-BEGIN ---
# This copyright note is auto-generated by ./scripts/Create-CopyPatch.
#
# Filename: target/idunn/initramfs/sbin_resume.sh
# Copyright (C) 2008 - 2009 The OpenSDE Project
#
# More information can be found in the files COPYING and README.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License. A copy of the
# GNU General Public License can be found in the file COPYING.
# --- SDE-COPYRIGHT-NOTE-END ---

# just once!
LOCK=/var/run/init.lock
ln -s / $LOCK 2> /dev/null || return

if /etc/rc.d/rc.trymount -v; then
	/etc/rc.d/rc.tryresume
	error=$?
else
	error=1
fi

rm -f $LOCK
exit $error

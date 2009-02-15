#!/bin/sh
# --- SDE-COPYRIGHT-NOTE-BEGIN ---
# This copyright note is auto-generated by ./scripts/Create-CopyPatch.
#
# Filename: target/idunn/initramfs/etc_rc.d_rc.shutdown.sh
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

title "Stopping services"
check sv -v force-stop /var/service/*
check sv d /var/service/*/log
status

title "Stopping supervisor"
check start-stop-daemon -K -s HUP -x /usr/bin/runsvdir
status

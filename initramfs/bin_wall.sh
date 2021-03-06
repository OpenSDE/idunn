#!/bin/sh
# --- SDE-COPYRIGHT-NOTE-BEGIN ---
# This copyright note is auto-generated by ./scripts/Create-CopyPatch.
#
# Filename: target/idunn/initramfs/bin_wall.sh
# Copyright (C) 2008 - 2009 The OpenSDE Project
#
# More information can be found in the files COPYING and README.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License. A copy of the
# GNU General Public License can be found in the file COPYING.
# --- SDE-COPYRIGHT-NOTE-END ---

tmpfile=/tmp/wall.$$

trap "rm -f $tmpfile" INT

cat <<EOT > $tmpfile
Broadcast Message from ${USER:-root}@$(hostname)
	($(tty)) at $(date) ...
EOT
cat >> $tmpfile

for x in /dev/pts/* /dev/console; do
	if [ -w "$x" ]; then
		cat "$tmpfile" > "$x"
	fi
done

rm -rf $tmpfile

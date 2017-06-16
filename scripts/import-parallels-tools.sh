#!/bin/bash

CDROM_MOUNTPOINT=/mnt/cdrom
DISTDIR=/usr/portage/distfiles

#SRC_URI="prl_mod.tar.gz mount.prl_fs.8 parallels-cpu-hotplug.rules parallels-memory-hotplug.rules blacklist-parallels.conf"
FILES_KMOD="prl_mod.tar.gz"
FILES_TOOLS="mount.prl_fs.8 *.rules prlmouse.conf"
FILES_INSTALLER="prlfsmountd.sh xserver-config.py"

if test -d $CDROM_MOUNTPOINT
then
	for file in $FILES_KMOD
	do
		rsync -a $CDROM_MOUNTPOINT/kmods/$file $DISTDIR/
	done
	for file in $FILES_TOOLS
	do
		rsync -a --progress $CDROM_MOUNTPOINT/tools/$files $DISTDIR/
	done
	for file in $FILES_INSTALLER
	do
		rsync -a $CDROM_MOUNTPOINT/installer/$files $DISTDIR/
	done
fi

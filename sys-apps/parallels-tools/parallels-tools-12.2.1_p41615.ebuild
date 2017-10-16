# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit versionator

DESCRIPTION=""
HOMEPAGE="http://www.parallels.com"
SRC_URI="amd64? ( prltools.x64.tar.gz )
x86? ( prltools.tar.gz )
prlmouse.conf xorg-prlmouse.rules prlfsmountd.sh 99prltoolsd-hibernate prltoolsd.sh
"
RESTRICT="fetch"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-portage/gentoolkit
dev-lang/perl"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	dobin "${S}"/bin/*
	dosbin "${S}"/sbin/*

	XORG_FULLVER=$(equery list -F '$version' xorg-server)
	einfo Xorg is ${XORG_FULLVER}
	XORG_VER=$(get_version_component_range 1-2 $XORG_FULLVER)
	einfo Xorg version component of interest is ${XORG_VER}

	# ./xorg.1.19/usr/lib/libglx.so.1.0.0
	#dolib "${S}"/xorg.${XORG_VER}/usr/lib/libglx.so*

	insinto /usr/lib64/xorg/modules/drivers
	doins "${S}"/xorg.${XORG_VER}/x-server/modules/drivers/prlvideo_drv.so
	insinto /usr/lib64/xorg/modules/input
	doins "${S}"/xorg.${XORG_VER}/x-server/modules/input/prlmouse_drv.so
	insinto /etc/X11/xorg.conf.d
	newins "${DISTDIR}"/prlmouse.conf 50-prlmouse.conf
	insinto /lib/udev/rules.d
	newins "${DISTDIR}"/xorg-prlmouse.rules 69-xorg-prlmouse.rules

	# Install tools' service
	mkdir ${ED}/etc/init.d
	perl ${FILESDIR}/convert-runscript.pl < ${DISTDIR}/prltoolsd.sh > ${ED}/etc/init.d/prltoolsd
	chmod a+x ${ED}/etc/init.d/prltoolsd

	# Install Parallels Shared Folders automount daemon
	newsbin ${DISTDIR}/prlfsmountd.sh prlfsmountd

	# Install 

	# Install prl-x11 service

	# Install prl_updater service for sysV or systemd or upstart

	# Install hibernate file
	insinto /etc/pm/sleep.d
	doins ${DISTDIR}/99prltoolsd-hibernate

	# Generate an Xorg config
	#$DISTDIR/
}

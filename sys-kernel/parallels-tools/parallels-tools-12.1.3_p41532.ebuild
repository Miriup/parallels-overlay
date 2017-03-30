# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-mod

DESCRIPTION="Parallels kernel modules"
HOMEPAGE="http://www.parallels.com"
SRC_URI="prl_mod.tar.gz mount.prl_fs.8 parallels-cpu-hotplug.rules parallels-memory-hotplug.rules blacklist-parallels.conf"

S="${WORKDIR}"

# Kernel module compilation config
MODULE_NAMES="prl_eth(extra:${S}/prl_eth/pvmnet)
prl_tg(extra:${S}/prl_tg/Toolgate/Guest/Linux/prl_tg)
prl_fs(extra:${S}/prl_fs/SharedFolders/Guest/Linux/prl_fs)
prl_fs_freeze(extra:${S}/prl_fs_freeze/Snapshot/Guest/Linux/prl_freeze)
"
BUILD_TARGETS=" "
#

# Parallels tools have to come from the local Hypervisor
RESTRICT="fetch"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	default

	doman ${DISTDIR}/mount.prl_fs.8
	insinto /etc/udev/rules.d
	newins ${DISTDIR}/parallels-cpu-hotplug.rules 99-parallels-cpu-hotplug.rules
	newins ${DISTDIR}/parallels-memory-hotplug.rules 99-parallels-memory-hotplug.rules
	insinto /etc/modprobe.d
	doins ${DISTDIR}/blacklist-parallels.conf
}

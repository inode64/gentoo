# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools optfeature

DESCRIPTION="Tool to generate multiple filesystem and flash images from a tree"
HOMEPAGE="https://github.com/pengutronix/genimage"
SRC_URI="https://github.com/pengutronix/genimage/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="dev-libs/confuse:="
RDEPEND="${DEPEND}"
BDEPEND="test? ( sys-apps/fakeroot )"

src_prepare() {
	default
	eautoreconf
}

pkg_postinst() {
	optfeature "cpio support" app-arch/cpio
	optfeature "tar support" app-arch/tar
	optfeature "qemu support" app-emulation/qemu
	optfeature "dosfstools support" sys-fs/dosfstools
	optfeature "cramfs support" sys-fs/cramfs
	optfeature "genext2fs support" sys-fs/genext2fs
	optfeature "jffs, ubifs and ubinize support" sys-fs/mtd-utils
	optfeature "squashfs support" sys-fs/squashfs-tools
}

# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

XORG_DRI="always"
inherit xorg-3

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://anongit.freedesktop.org/git/nouveau/xf86-video-nouveau.git"
	SRC_URI=""
fi

DESCRIPTION="Accelerated Open Source driver for nVidia cards"
HOMEPAGE="
	https://nouveau.freedesktop.org/wiki/
	https://cgit.freedesktop.org/nouveau/xf86-video-nouveau"

KEYWORDS="amd64 ~arm64 ~loong ppc ppc64 ~riscv x86"

RDEPEND=">=x11-libs/libdrm-2.4.60[video_cards_nouveau]
	>=x11-libs/libpciaccess-0.10
	virtual/libudev:="
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-xorg-server-API-rename.patch
)

# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit savedconfig toolchain-funcs

MY_P="${PN}-v${PV}"
WLROOTS_SLOT="0/16"
if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/djpohly/dwl"
	inherit git-r3

	# 9999-r0: main (latest stable wlroots release)
	# 9999-r1: wlroots-next (wlroots-9999)
	case ${PVR} in
		9999)
			EGIT_BRANCH=main
			;;
		9999-r1)
			EGIT_BRANCH=wlroots-next
			WLROOTS_SLOT="0/9999"
			;;
	esac
else
	SRC_URI="https://github.com/djpohly/${PN}/releases/download/v${PV}/${MY_P}.tar.gz -> ${P}.gh.tar.gz"
	S="${WORKDIR}/${MY_P}"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="dwm for Wayland"
HOMEPAGE="https://github.com/djpohly/dwl"

LICENSE="CC0-1.0 GPL-3+ MIT"
SLOT="0"
IUSE="X"

PATCHES=( "${FILESDIR}/${P}-do-not-use-libX11.patch" )

RDEPEND="
	dev-libs/libinput:=
	dev-libs/wayland
	gui-libs/wlroots:${WLROOTS_SLOT}[libinput(+),X?]
	x11-libs/libxkbcommon
	X? (
		x11-libs/libxcb:=
		x11-libs/xcb-util-wm
	)
"

# uses <linux/input-event-codes.h>
DEPEND="
	${RDEPEND}
	sys-kernel/linux-headers
"
BDEPEND="
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_prepare() {
	restore_config config.h

	default
}

src_compile() {
	emake PKG_CONFIG="$(tc-getPKG_CONFIG)" CC="$(tc-getCC)" \
		XWAYLAND="$(usev X -DXWAYLAND)" XLIBS="$(usev X "xcb xcb-icccm")" dwl
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	dodoc README.md

	insinto /usr/share/wayland-session
	doins "${FILESDIR}/dwl.desktop"

	save_config config.h
}

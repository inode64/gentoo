# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Style neutral scalable cursor theme (black version)"
HOMEPAGE="https://jimmac.eu/"
SRC_URI="mirror://debian/pool/main/d/dmz-cursor-theme/dmz-cursor-theme_${PV}.tar.xz"
S="${WORKDIR}/dmz-cursor-theme-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ppc ppc64 ~s390 sparc x86"

DEPEND="x11-apps/xcursorgen"
RDEPEND="x11-libs/libXcursor"

src_compile() {
	pushd "${S}/DMZ-White/pngs"
		./make.sh || die
	popd
}

src_install() {
	insinto /usr/share/cursors/xorg-x11/DMZ-White
	doins DMZ-White/index.theme

	insinto /usr/share/cursors/xorg-x11/DMZ-White/cursors
	doins -r DMZ-White/xcursors/.
}

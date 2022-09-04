# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WX_GTK_VER="3.0-gtk3"
MY_PN="PrusaSlicer"
MY_PV="${PV//_/-}"

inherit cmake wxwidgets xdg

DESCRIPTION="A mesh slicer to generate G-code for fused-filament-fabrication (3D printers)"
HOMEPAGE="https://www.prusa3d.com/prusaslicer/"
SRC_URI="https://github.com/prusa3d/PrusaSlicer/archive/refs/tags/version_2.5.0-alpha2.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3 Boost-1.0 GPL-2 LGPL-3 MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="test"

RESTRICT="test"

RDEPEND="
	dev-cpp/eigen:3
	dev-cpp/tbb:=
	>=dev-libs/boost-1.73.0:=[nls]
	dev-libs/cereal
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/gmp:=
	dev-libs/mpfr:=
	dev-libs/imath:=
	>=media-gfx/openvdb-8.2:=
	net-misc/curl[adns]
	media-libs/glew:0=
	media-libs/libpng:0=
	media-libs/qhull:=
	sci-libs/libigl
	sci-libs/nlopt
	>=sci-mathematics/cgal-5.0:=
	sys-apps/dbus
	sys-libs/zlib:=
	virtual/glu
	virtual/opengl
	x11-libs/gtk+:3
	x11-libs/wxGTK:${WX_GTK_VER}[X,opengl]
"
DEPEND="${RDEPEND}
	media-libs/qhull[static-libs]
"

PATCHES=(
	"${FILESDIR}/${PN}-2.4.0-fix-build-with-cereal-1.3.1.patch"
	"${FILESDIR}/${PN}-2.5.0_alpha2-boost-fixes.patch"
)

S="${WORKDIR}/${MY_PN}-version_${MY_PV}"

src_prepare() {
	sed -i -e 's/PrusaSlicer-${SLIC3R_VERSION}+UNKNOWN/PrusaSlicer-${SLIC3R_VERSION}+Gentoo/g' version.inc || die
	cmake_src_prepare
}

src_configure() {
	CMAKE_BUILD_TYPE="Release"

	setup-wxwidgets

	local mycmakeargs=(
		-DOPENVDB_FIND_MODULE_PATH="/usr/$(get_libdir)/cmake/OpenVDB"

		-DSLIC3R_BUILD_TESTS=$(usex test)
		-DSLIC3R_FHS=ON
		-DSLIC3R_GTK=3
		-DSLIC3R_GUI=ON
		-DSLIC3R_PCH=OFF
		-DSLIC3R_STATIC=OFF
		-DSLIC3R_WX_STABLE=ON
		-Wno-dev
	)

	cmake_src_configure
}

# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11,12} )

inherit cmake python-single-r1 xdg-utils

DESCRIPTION="A fast and flexible keyboard launcher"
HOMEPAGE="https://albertlauncher.github.io/"

PLUGINS_HASH="1cff4d010745e7cb34fdab0f1459175099e3359a"
PYTHON_EXTENSIONS_COMMIT="f1e3cf96b263df519b9d30984eb99b4850fc1976"

SRC_URI="
	https://github.com/albertlauncher/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/albertlauncher/plugins/archive/${PLUGINS_HASH}.tar.gz -> ${PN}-plugins-${PLUGINS_HASH}.tar.gz
	python-extensions? ( https://github.com/albertlauncher/python/archive/${PYTHON_EXTENSIONS_COMMIT}.tar.gz -> ${PN}-python-extensions-${PYTHON_EXTENSIONS_COMMIT}.tar.gz )
"

LICENSE="all-rights-reserved"	# unclear licensing #766129
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug +python +python-extensions"

REQUIRED_USE="
	python-extensions? ( python )
	python? ( ${PYTHON_REQUIRED_USE} )
"
RESTRICT="mirror"

RDEPEND="
	app-arch/libarchive:=
	dev-cpp/muParser
	dev-libs/qhotkey[qt6]
	dev-qt/qt5compat:6
	dev-qt/qtbase:6[concurrent,dbus,gui,network,sql,sqlite,widgets]
	dev-qt/qtscxml:6
	dev-qt/qtsvg:6
	sci-libs/libqalculate:=
	python? (
		$(python_gen_cond_dep 'dev-python/urllib3[${PYTHON_USEDEP}]')
		${PYTHON_DEPS}
	)
"
DEPEND="${RDEPEND}
	dev-qt/qtdeclarative:6
	python? ( $(python_gen_cond_dep 'dev-python/pybind11[${PYTHON_USEDEP}]') )
	x11-base/xorg-proto"

PATCHES=("${FILESDIR}/${PN}-0.22.4-use-system-qhotkey-libraries-and-headers.patch")

src_prepare() {
	mv "${WORKDIR}"/plugins-${PLUGINS_HASH}/* "${S}"/plugins || die
	if use python-extensions; then
		mv "${WORKDIR}"/python-${PYTHON_EXTENSIONS_COMMIT}/* "${S}"/plugins/python/plugins
	fi

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_DEBUG=$(usex debug)
		-DBUILD_PYTHON=$(usex python)
	)

	cmake_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
}

# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1

DESCRIPTION="Backend part of Paperwork (Python API, no UI)"
HOMEPAGE="https://gitlab.gnome.org/World/OpenPaperwork"
SRC_URI="https://gitlab.gnome.org/World/OpenPaperwork/paperwork/-/archive/${PV}/paperwork-${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	app-text/openpaperwork-core[${PYTHON_USEDEP}]
	app-text/openpaperwork-gtk[${PYTHON_USEDEP}]
	app-text/poppler[introspection]
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pycountry[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/whoosh[${PYTHON_USEDEP}]
	sci-libs/scikit-learn[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-python/libpillowfight[${PYTHON_USEDEP}]
		media-libs/libinsane
	)
"
S=${WORKDIR}/paperwork-${PV}/${PN}

distutils_enable_tests unittest

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

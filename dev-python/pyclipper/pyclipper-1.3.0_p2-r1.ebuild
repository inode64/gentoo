# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Cython wrapper for the C++ translation of the Angus Johnson's Clipper library"
HOMEPAGE="https://github.com/fonttools/pyclipper"
SRC_URI="https://github.com/fonttools/pyclipper/archive/${PV/_p/.post}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P/_p/.post}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE=""

BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV/_p/.post}"
}

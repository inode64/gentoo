# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="A stdlib like feel, and extra batteries. Hashing, Caching, Timing, Progress"
HOMEPAGE="https://github.com/Erotemic/ubelt"
SRC_URI="https://github.com/Erotemic/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"

DEPEND="test? ( dev-python/xdoctest[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# relies on passwd home being equal to ${HOME}
	ubelt/util_path.py::userhome:0
)

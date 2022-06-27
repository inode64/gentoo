# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Helping users and developers to get information about the environment"
HOMEPAGE="https://gitlab.com/dpizetta/helpdev"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="
	$(python_gen_cond_dep 'dev-python/importlib_metadata[${PYTHON_USEDEP}]' python3_{7..8} )
	dev-python/psutil[${PYTHON_USEDEP}]
"

BDEPEND="test? ( dev-python/pip[${PYTHON_USEDEP}] )"

distutils_enable_sphinx docs dev-python/sphinx_rtd_theme
distutils_enable_tests pytest

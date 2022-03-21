# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Compatibility layer for multiple asynchronous event loop implementations"
HOMEPAGE="
	https://github.com/agronholm/anyio
	https://pypi.org/project/anyio/
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 hppa ~ia64 ppc ppc64 ~riscv ~s390 sparc x86"

RDEPEND="
	>=dev-python/idna-2.8[${PYTHON_USEDEP}]
	>=dev-python/sniffio-1.1[${PYTHON_USEDEP}]
"
# On amd64, let's get more test coverage by dragging in uvloop, but let's
# not bother on other arches where uvloop may not be supported.
BDEPEND="
	test? (
		>=dev-python/hypothesis-4.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-6.2[${PYTHON_USEDEP}]
		>=dev-python/pytest-mock-3.6.1[${PYTHON_USEDEP}]
		dev-python/trustme[${PYTHON_USEDEP}]
		amd64? ( >=dev-python/uvloop-0.15[${PYTHON_USEDEP}] )
	)
"

distutils_enable_tests --install pytest
distutils_enable_sphinx docs \
	dev-python/sphinx_rtd_theme \
	dev-python/sphinx-autodoc-typehints

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	distutils_install_for_testing --via-venv
	epytest -m 'not network'
}

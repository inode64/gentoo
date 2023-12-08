# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1

MY_P=MyST-Parser-${PV}
DESCRIPTION="Extended commonmark compliant parser, with bridges to Sphinx"
HOMEPAGE="
	https://github.com/executablebooks/MyST-Parser/
	https://pypi.org/project/myst-parser/
"
SRC_URI="
	https://github.com/executablebooks/MyST-Parser/archive/v${PV}.tar.gz
		-> ${MY_P}.gh.tar.gz
"
S=${WORKDIR}/${MY_P}

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86"

RDEPEND="
	<dev-python/docutils-0.21[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	<dev-python/markdown-it-py-4[${PYTHON_USEDEP}]
	>=dev-python/markdown-it-py-3.0[${PYTHON_USEDEP}]
	<dev-python/mdit-py-plugins-0.5[${PYTHON_USEDEP}]
	>=dev-python/mdit-py-plugins-0.4[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	<dev-python/sphinx-8[${PYTHON_USEDEP}]
	>=dev-python/sphinx-6[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		<dev-python/linkify-it-py-3[${PYTHON_USEDEP}]
		>=dev-python/linkify-it-py-2.0.0[${PYTHON_USEDEP}]
		dev-python/pytest-regressions[${PYTHON_USEDEP}]
		dev-python/pytest-param-files[${PYTHON_USEDEP}]
		dev-python/sphinx-pytest[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=()

	false && [[ ${EPYTHON} == pypy3 ]] && EPYTEST_DESELECT+=(
		# bad test relying on exact exception messages
		"tests/test_renderers/test_include_directive.py::test_errors[9-Non-existent path:]"
	)

	epytest
}

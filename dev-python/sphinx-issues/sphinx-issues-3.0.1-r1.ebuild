# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Sphinx extension for linking to your project's issue tracker"
HOMEPAGE="
	https://github.com/sloria/sphinx-issues/
	https://pypi.org/project/sphinx-issues/
"
SRC_URI="
	https://github.com/sloria/sphinx-issues/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~x64-macos ~x64-solaris"

RDEPEND="
	dev-python/sphinx[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# doesn't work in our pep517 install
	tests/test_sphinx_issues.py::test_sphinx_build_integration
)

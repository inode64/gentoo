# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1

DESCRIPTION="Module for decorators, wrappers and monkey patching"
HOMEPAGE="
	https://github.com/GrahamDumpleton/wrapt/
	https://pypi.org/project/wrapt/
"
SRC_URI="
	https://github.com/GrahamDumpleton/wrapt/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~x64-macos"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-rtd-theme

src_prepare() {
	# pypy3.9+ change, upstream commented this out
	# in 59680c8bb998defa3be522fef6e49fd276bebe58
	sed -i -e 's:if is_pypy:if False:' tests/test_object_proxy.py || die
	distutils-r1_src_prepare
}

python_compile() {
	local -x WRAPT_INSTALL_EXTENSIONS=true
	distutils-r1_python_compile
}

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest
}

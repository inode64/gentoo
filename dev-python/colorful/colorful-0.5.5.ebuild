# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1

DESCRIPTION="Terminal string styling done right, in Python"
HOMEPAGE="
	https://pypi.org/project/colorful/
	https://github.com/timofurrer/colorful/
"
SRC_URI="
	https://github.com/timofurrer/colorful/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_tests pytest

src_prepare() {
	# Fix QA_issue python package discovery
	# https://github.com/timofurrer/colorful/pull/53
	sed -i \
		-e "s/find_packages/find_namespace_packages/" \
		-e "s/(exclude=\['\*tests\*'\])/(exclude=\['\*tests\*'\, '\*examples\*'\])/" \
		setup.py || die "Error fixing setup.py for >=PEP420"

	distutils-r1_src_prepare
}

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest -s
}

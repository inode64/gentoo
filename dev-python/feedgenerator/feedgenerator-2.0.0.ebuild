# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 python3_{8..11} )
inherit distutils-r1

DESCRIPTION="Standalone version of django.utils.feedgenerator"
HOMEPAGE="https://pypi.org/project/feedgenerator/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~riscv x86"

RDEPEND="
	dev-python/pytz[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_test() {
	epytest -o addopts=
}

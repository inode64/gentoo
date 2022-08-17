# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Simple generic functions for Python"
HOMEPAGE="https://pypi.org/project/simplegeneric/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm arm64 ~hppa ~ia64 ~mips ppc ppc64 ~s390 sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos"

BDEPEND="app-arch/unzip"

distutils_enable_tests setup.py

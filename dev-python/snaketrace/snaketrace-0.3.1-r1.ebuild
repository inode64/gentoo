# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="An strace-like tool for Python audit events"
HOMEPAGE="
	https://github.com/dcoles/snaketrace/
	https://pypi.org/project/snaketrace/
"
SRC_URI="
	https://github.com/dcoles/snaketrace/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_tests unittest

# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="A Python Slugify application that handles Unicode"
HOMEPAGE="
	https://github.com/un33k/python-slugify/
	https://pypi.org/project/python-slugify/
"
SRC_URI="
	https://github.com/un33k/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ppc64 x86"

RDEPEND="dev-python/text-unidecode[${PYTHON_USEDEP}]"

distutils_enable_tests unittest

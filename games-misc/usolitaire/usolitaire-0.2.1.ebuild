# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="solitaire in your terminal"
HOMEPAGE="https://github.com/eliasdorneles/usolitaire"
SRC_URI="https://github.com/eliasdorneles/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="dev-python/urwid[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

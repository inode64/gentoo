# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ASPELL_LANG="Galician"
ASPELL_VERSION=6
MY_PV="$(ver_cut 1-2)a-$(ver_cut 3)"
MY_P="${PN/aspell/aspell${ASPELL_VERSION}}-${MY_PV}"

inherit aspell-dict-r1

SRC_URI="mirror://gnu/${PN%-*}/dict/${PN/aspell-/}/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86"

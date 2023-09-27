# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=DANKOGAI
DIST_VERSION=3.19
inherit perl-module

DESCRIPTION="Character encodings in Perl"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm arm64 ~hppa ~ia64 ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x64-solaris"

PATCHES=(
	"${FILESDIR}"/gentoo_enc2xs.diff
)

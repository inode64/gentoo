# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=EXODIST
DIST_VERSION=0.002
inherit perl-module

DESCRIPTION="Tool for inspecting subroutines"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

RDEPEND="
	virtual/perl-Carp
	>=dev-perl/Importer-0.24.0
"
BDEPEND="${RDEPEND}
	test? (
		>=virtual/perl-Test-Simple-1.302.72
	)
"

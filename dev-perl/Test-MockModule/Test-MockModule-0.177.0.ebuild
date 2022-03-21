# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_VERSION=v${PV}
DIST_AUTHOR=GFRANKS
inherit perl-module

DESCRIPTION="Override subroutines in a module for unit testing"

SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

RDEPEND="
	virtual/perl-Carp
	>=dev-perl/SUPER-1.200.0
	virtual/perl-Scalar-List-Utils
"
BDEPEND="${RDEPEND}
	>=dev-perl/Module-Build-0.380.0
	test? (
		>=virtual/perl-Test-Simple-0.880.0
		dev-perl/Test-Warnings
	)
"

PERL_RM_FILES=( "t/pod_coverage.t" "t/pod.t" )

# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.2.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Parser for reStructuredText-style grid tables"
HOMEPAGE="https://github.com/tarleb/gridtables"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

RDEPEND="dev-haskell/doclayout:=[profile?]
	>=dev-haskell/parsec-3.1:=[profile?] <dev-haskell/parsec-3.2:=[profile?]
	>=dev-lang/ghc-8.8.1:=
	>=dev-haskell/text-1.1.1.0:=[profile?] <dev-haskell/text-2.1:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.0.0.0
	test? ( >=dev-haskell/tasty-0.11
		>=dev-haskell/tasty-hunit-0.9 )
"

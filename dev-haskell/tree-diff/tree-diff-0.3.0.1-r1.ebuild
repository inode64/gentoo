# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0.9999

CABAL_HACKAGE_REVISION=3

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Diffing of (expression) trees"
HOMEPAGE="https://github.com/phadej/tree-diff"

LICENSE="GPL-2+"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

RDEPEND=">=dev-haskell/bytestring-builder-0.10.8.2.0:=[profile?] <dev-haskell/bytestring-builder-0.11:=[profile?]
	>=dev-haskell/data-array-byte-0.1.0.1:=[profile?] <dev-haskell/data-array-byte-0.2:=[profile?]
	>=dev-haskell/parsec-3.1.13.0:=[profile?] <dev-haskell/parsec-3.2:=[profile?]
	>=dev-haskell/parsers-0.12.10:=[profile?] <dev-haskell/parsers-0.13:=[profile?]
	>=dev-haskell/quickcheck-2.14.2:2=[profile?] <dev-haskell/quickcheck-2.15:2=[profile?]
	>=dev-haskell/scientific-0.3.6.2:=[profile?] <dev-haskell/scientific-0.4:=[profile?]
	>=dev-haskell/tagged-0.8.6:=[profile?] <dev-haskell/tagged-0.9:=[profile?]
	>=dev-haskell/unordered-containers-0.2.8.0:=[profile?] <dev-haskell/unordered-containers-0.3:=[profile?]
	>=dev-haskell/uuid-types-1.0.3:=[profile?] <dev-haskell/uuid-types-1.1:=[profile?]
	>=dev-lang/ghc-8.8.1:=
	>=dev-haskell/aeson-1.4.6.0:=[profile?] <dev-haskell/aeson-2.3:=[profile?]
	>=dev-haskell/ansi-terminal-0.10:=[profile?] <dev-haskell/ansi-terminal-1.1:=[profile?]
	>=dev-haskell/ansi-wl-pprint-0.6.8.2:=[profile?] <dev-haskell/ansi-wl-pprint-1.1:=[profile?]
	<dev-haskell/base-compat-0.14:=[profile?]
	>=dev-haskell/hashable-1.2.7.0:=[profile?] <dev-haskell/hashable-1.5:=[profile?]
	>=dev-haskell/primitive-0.7.1.0:=[profile?] <dev-haskell/primitive-0.9:=[profile?]
	>=dev-haskell/semialign-1.2.0.1:=[profile?] <dev-haskell/semialign-1.4:=[profile?]
	>=dev-haskell/strict-0.4.0.1:=[profile?] <dev-haskell/strict-0.6:=[profile?]
	>=dev-haskell/text-1.2.3.0:=[profile?] <dev-haskell/text-2.1:=[profile?]
	>=dev-haskell/these-1.1.1.1:=[profile?] <dev-haskell/these-1.3:=[profile?]
	>=dev-haskell/vector-0.12.0.0:=[profile?] <dev-haskell/vector-0.14:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.0.0.0
	test? ( dev-haskell/ansi-terminal
		dev-haskell/ansi-wl-pprint
		dev-haskell/base-compat
		dev-haskell/primitive
		>=dev-haskell/tasty-golden-2.3.1.1 <dev-haskell/tasty-golden-2.4
		>=dev-haskell/tasty-quickcheck-0.10.1 <dev-haskell/tasty-quickcheck-0.11
		>=dev-haskell/trifecta-2 <dev-haskell/trifecta-2.2
		|| ( ( >=dev-haskell/tasty-1.2 <dev-haskell/tasty-1.3 )
			|| ( ( >=dev-haskell/tasty-1.3.1 <dev-haskell/tasty-1.4 )
				( >=dev-haskell/tasty-1.4.2 <dev-haskell/tasty-1.5 ) ) ) )
"

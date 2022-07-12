# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Create command line interfaces with ease"
HOMEPAGE="https://github.com/soenkehahn/getopt-generics#readme"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/base-compat-0.8:=[profile?]
	dev-haskell/base-orphans:=[profile?]
	>=dev-haskell/generics-sop-0.2.3:=[profile?] <dev-haskell/generics-sop-0.6:=[profile?]
	dev-haskell/tagged:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.12
	test? ( >=dev-haskell/hspec-2.1.8
		dev-haskell/quickcheck
		dev-haskell/safe
		dev-haskell/silently )
"

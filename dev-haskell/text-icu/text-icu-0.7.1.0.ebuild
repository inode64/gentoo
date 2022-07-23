# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour" # test-suite"
inherit haskell-cabal

DESCRIPTION="Bindings to the ICU library"
HOMEPAGE="https://github.com/haskell/text-icu"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc64 ~x86"

RESTRICT=test # QuickCheck occasionally finds counterexamples
# and fails to build: Duplicate instance declarations: instance NFData Ordering

RDEPEND=">=dev-haskell/text-0.9.1.0:=[profile?]
	>=dev-lang/ghc-8.4.3:=
	dev-libs/icu
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
"
# test? ( >=dev-haskell/hunit-1.2
# 		>=dev-haskell/quickcheck-2.4
# 		dev-haskell/random
# 		>=dev-haskell/test-framework-0.4
# 		>=dev-haskell/test-framework-hunit-0.2
# 		>=dev-haskell/test-framework-quickcheck2-0.2 )
# "

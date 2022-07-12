# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.1.1.9999
#hackport: flags: -debug

CABAL_FEATURES="lib profile haddock hoogle hscolour" # test-suite
inherit haskell-cabal
RESTRICT="test" # Circular dependencies

DESCRIPTION="Efficient hashing-based container types"
HOMEPAGE="https://github.com/haskell-unordered-containers/unordered-containers"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND=">=dev-haskell/hashable-1.2.5:=[profile?] <dev-haskell/hashable-1.5:=[profile?]
	>=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1"
#	test? ( dev-haskell/chasingbottoms
#		dev-haskell/hunit
#		>=dev-haskell/quickcheck-2.4.0.1
#		dev-haskell/random
#		>=dev-haskell/tasty-1.4.0.3
#		>=dev-haskell/tasty-hunit-0.10.0.3
#		>=dev-haskell/tasty-quickcheck-0.10.1.2 )

src_configure() {
	haskell-cabal_src_configure \
		--flag=-debug
}

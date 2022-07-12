# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.1.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Haskell implementation of the Unicode Collation Algorithm"
HOMEPAGE="https://github.com/jgm/unicode-collation"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="doctests executable"

RDEPEND="dev-haskell/parsec:=[profile?]
	>=dev-haskell/text-1.2:=[profile?] <dev-haskell/text-2.1:=[profile?]
	dev-haskell/th-lift-instances:=[profile?]
	>=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	test? ( dev-haskell/tasty
		dev-haskell/tasty-hunit
		dev-haskell/tasty-quickcheck
		>=dev-haskell/unicode-transforms-0.3.7.1
		doctests? ( >=dev-haskell/doctest-0.8 ) )
"

src_prepare() {
	default
	cabal_chdeps \
		'text >= 1.2 && < 1.3' 'text >= 1.2 && < 2.1'
}

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag doctests doctests) \
		$(cabal_flag executable executable)
}

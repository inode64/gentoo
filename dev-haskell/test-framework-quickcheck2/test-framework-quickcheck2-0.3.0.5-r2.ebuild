# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.5.6.9999
#hackport: flags: +base4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="QuickCheck2 support for the test-framework package"
HOMEPAGE="http://haskell.github.io/test-framework/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/extensible-exceptions-0.1.1:=[profile?] <dev-haskell/extensible-exceptions-0.2.0:=[profile?]
	>=dev-haskell/quickcheck-2.4:2=[profile?]
	>=dev-haskell/random-1:=[profile?] <dev-haskell/random-1.3:=[profile?]
	>=dev-haskell/test-framework-0.8:=[profile?] <dev-haskell/test-framework-0.9:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
"

src_prepare() {
	default

	cabal_chdeps \
		'QuickCheck            >= 2.4    && < 2.13' 'QuickCheck            >= 2.4' \
		'random                >= 1      && < 1.2' 'random                >= 1'
}

src_configure() {
	haskell-cabal_src_configure \
		--flag=base4
}

# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.1.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="LPeg - Parsing Expression Grammars For Lua"
HOMEPAGE="https://hslua.org/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="rely-on-shared-lpeg-library"

RDEPEND=">=dev-haskell/lua-2.1:=[profile?] <dev-haskell/lua-2.3:=[profile?]
	>=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	test? ( >=dev-haskell/tasty-0.11
		>=dev-haskell/tasty-hunit-0.9 )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag rely-on-shared-lpeg-library rely-on-shared-lpeg-library)
}

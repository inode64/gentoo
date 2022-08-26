# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Bridge between commonmark and pandoc AST"
HOMEPAGE="https://github.com/jgm/commonmark-hs"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"

RDEPEND=">=dev-haskell/commonmark-0.2:=[profile?] <dev-haskell/commonmark-0.3:=[profile?]
	>=dev-haskell/commonmark-extensions-0.2.1:=[profile?] <dev-haskell/commonmark-extensions-0.3:=[profile?]
	>=dev-haskell/pandoc-types-1.21:=[profile?] <dev-haskell/pandoc-types-1.23:=[profile?]
	dev-haskell/text:=[profile?]
	>=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
"

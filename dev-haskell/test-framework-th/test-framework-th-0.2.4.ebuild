# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Automagically generate the HUnit and Quickcheck using Template Haskell"
HOMEPAGE="https://github.com/finnsson/test-generator"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"
IUSE=""

RDEPEND="dev-haskell/haskell-src-exts:=[profile?]
	>=dev-haskell/language-haskell-extract-0.2:=[profile?]
	dev-haskell/regex-posix:=[profile?]
	dev-haskell/test-framework:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6
"

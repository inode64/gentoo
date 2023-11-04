# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.6.4.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A platform independent entropy source"
HOMEPAGE="https://github.com/TomMD/entropy"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 ~arm64 ~ppc64 ~riscv ~x86"
IUSE="halvm"

RDEPEND=">=dev-lang/ghc-7.10.1:= <dev-lang/ghc-9.1
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.22.2.0
"

CABAL_CHDEPS=(
	'Cabal >= 1.10 && < 3.3' 'Cabal >= 1.10'
)

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag halvm halvm)
}

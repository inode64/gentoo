# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0.9999

CABAL_HACKAGE_REVISION=1

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A platform independent entropy source"
HOMEPAGE="https://github.com/TomMD/entropy"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"
IUSE="donotgetentropy"

RDEPEND=">=dev-lang/ghc-8.10.6:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.2.1.0 <dev-haskell/cabal-3.11
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag donotgetentropy donotgetentropy)
}

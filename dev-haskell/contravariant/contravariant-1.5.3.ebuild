# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.6.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Contravariant functors"
HOMEPAGE="https://github.com/ekmett/contravariant/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 ~arm64 ~ppc64 ~riscv ~x86"
IUSE="+semigroups +statevar +tagged"

RDEPEND=">=dev-haskell/transformers-compat-0.5:=[profile?] <dev-haskell/transformers-compat-1:=[profile?]
	>=dev-haskell/void-0.6.1:=[profile?] <dev-haskell/void-1:=[profile?]
	>=dev-lang/ghc-7.8.2:=
	semigroups? ( >=dev-haskell/semigroups-0.18.5:=[profile?] <dev-haskell/semigroups-1:=[profile?] )
	statevar? ( >=dev-haskell/statevar-1.2.1:=[profile?] <dev-haskell/statevar-1.3:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag semigroups semigroups) \
		$(cabal_flag statevar statevar) \
		$(cabal_flag tagged tagged)
}

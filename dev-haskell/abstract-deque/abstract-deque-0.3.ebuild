# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Abstract, parameterized interface to mutable Deques"
HOMEPAGE="https://github.com/rrnewton/haskell-lockfree/wiki"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"
IUSE="usecas"

RDEPEND="dev-haskell/random:=[profile?]
	>=dev-lang/ghc-7.4.1:=
	usecas? ( >=dev-haskell/atomic-primops-0.5.0.2:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
"

PATCHES=("${FILESDIR}"/${P}-atomic-primops.patch)

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag usecas usecas)
}

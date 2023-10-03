# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Cross platform library for the sendfile system call"
HOMEPAGE="https://hackage.haskell.org/package/simple-sendfile"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 ~arm64 ~ppc64 ~riscv ~x86"
IUSE="+allow-bsd"

RDEPEND="dev-haskell/network:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( dev-haskell/conduit
		dev-haskell/conduit-extra
		>=dev-haskell/hspec-1.3
		dev-haskell/hunit
		dev-haskell/resourcet )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag allow-bsd allow-bsd)
}

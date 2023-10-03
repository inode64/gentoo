# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.6.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A test framework and KATs for cryptographic operations"
HOMEPAGE="http://trac.haskell.org/crypto-api/wiki"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 ~arm64 ~ppc64 ~riscv ~x86"
IUSE=""

RDEPEND="dev-haskell/cereal:=[profile?]
	>=dev-haskell/crypto-api-0.13:=[profile?]
	dev-haskell/hunit:=[profile?]
	>=dev-haskell/quickcheck-2.4:2=[profile?]
	>=dev-haskell/test-framework-0.4:=[profile?]
	>=dev-haskell/test-framework-hunit-0.2:=[profile?]
	>=dev-haskell/test-framework-quickcheck2-0.3:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6
"

# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Email address validation"
HOMEPAGE="https://github.com/Porges/email-validate-hs"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 ~arm64 ~ppc64 ~riscv ~x86"

PATCHES=( "${FILESDIR}/${PN}-2.3.2.15-fix-doctest.patch" )

RDEPEND=">=dev-haskell/attoparsec-0.10.0:=[profile?] <dev-haskell/attoparsec-0.15:=[profile?]
	>=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	test? ( >=dev-haskell/doctest-0.8
		>=dev-haskell/hspec-2.2.3
		>=dev-haskell/quickcheck-2.4 <dev-haskell/quickcheck-2.15 )
"

CABAL_CHDEPS=(
	'hspec >= 2.2.3 && < 2.9' 'hspec >= 2.2.3'
	'doctest >= 0.8 && < 0.19' 'doctest >=0.8'
	'template-haskell >= 2.10.0.0 && < 2.18' 'template-haskell >=2.10'
)

# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Email address validation"
HOMEPAGE="https://github.com/Porges/email-validate-hs"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

RDEPEND="
	>=dev-haskell/attoparsec-0.10.0:=[profile?] <dev-haskell/attoparsec-0.15:=[profile?]
	>=dev-lang/ghc-8.10.6:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.2.1.0
	test? (
		>=dev-haskell/hspec-2.2.3 <dev-haskell/hspec-2.12
		>=dev-haskell/quickcheck-2.4 <dev-haskell/quickcheck-2.15
	)
"

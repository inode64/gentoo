# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.3.0

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Haskell bindings to the PCG random number generator"
HOMEPAGE="https://github.com/cchalmers/pcg-random"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

GHC_BOOTSTRAP_PACKAGES=(
	cabal-doctest
)

RDEPEND="dev-haskell/entropy:=[profile?]
	>=dev-haskell/primitive-0.4:=[profile?] <dev-haskell/primitive-0.8:=[profile?]
	>=dev-haskell/random-1.0:=[profile?] <dev-haskell/random-2.0:=[profile?]
	>=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	>=dev-haskell/cabal-doctest-1 <dev-haskell/cabal-doctest-1.1
	test? ( dev-haskell/doctest )
"

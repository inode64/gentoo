# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0.9999

CABAL_HACKAGE_REVISION=4
CABAL_PN="HsYAML"

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Pure Haskell YAML 1.2 processor"
HOMEPAGE="https://github.com/hvr/HsYAML"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="amd64 ~arm64 ~ppc64 ~riscv ~x86"

RDEPEND=">=dev-haskell/fail-4.9.0.0:=[profile?] <dev-haskell/fail-4.10:=[profile?]
	>=dev-haskell/mtl-2.2.1:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	>=dev-haskell/nats-1.1.2:=[profile?] <dev-haskell/nats-1.2:=[profile?]
	>=dev-haskell/parsec-3.1.13.0:=[profile?] <dev-haskell/parsec-3.2:=[profile?]
	>=dev-haskell/text-1.2.3:=[profile?] <dev-haskell/text-1.3:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.14
	test? ( >=dev-haskell/quickcheck-2.13:=
		>=dev-haskell/tasty-1.2:=
		>=dev-haskell/tasty-quickcheck-0.10:= )
"

src_configure() {
	haskell-cabal_src_configure --flag=-exe
}

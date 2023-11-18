# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.3.0
#hackport: flags: -dev

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Test utilities and the test suite of Megaparsec"
HOMEPAGE="https://github.com/mrkkrp/megaparsec"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

RDEPEND=">=dev-haskell/hspec-2.0:=[profile?] <dev-haskell/hspec-3.0:=[profile?]
	>=dev-haskell/hspec-expectations-0.8:=[profile?] <dev-haskell/hspec-expectations-0.9:=[profile?]
	>=dev-haskell/hspec-megaparsec-2.0:=[profile?] <dev-haskell/hspec-megaparsec-3.0:=[profile?]
	~dev-haskell/megaparsec-9.2.2:=[profile?]
	>=dev-haskell/quickcheck-2.10:=[profile?] <dev-haskell/quickcheck-2.15:=[profile?]
	>=dev-lang/ghc-9.0.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
	test? ( >=dev-haskell/case-insensitive-1.2 <dev-haskell/case-insensitive-1.3
		>=dev-haskell/parser-combinators-1.0 <dev-haskell/parser-combinators-2.0
		>=dev-haskell/scientific-0.3.1 <dev-haskell/scientific-0.4 )
"

src_configure() {
	haskell-cabal_src_configure \
		--flag=-dev
}

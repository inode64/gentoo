# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.0.0.9999
#hackport: flags: -parsec-struct-diff

CABAL_HACKAGE_REVISION=1
CABAL_PN="Cabal"

# drop tests due to circular deps
CABAL_FEATURES="lib profile haddock hoogle hscolour" # test-suite
CABAL_FEATURES+=" nocabaldep" # in case installed Cabal is broken
inherit haskell-cabal

DESCRIPTION="A framework for packaging Haskell software"
HOMEPAGE="https://www.haskell.org/cabal/"

LICENSE="BSD"
SLOT="0/${PV}"
# Keep in sync with relevant ghc versions (CABAL_CORE_LIB_GHC_PV)
KEYWORDS="amd64 ~arm64 ~ppc64 ~riscv ~x86 ~amd64-linux ~x86-linux"

RESTRICT=test # circular deps: cabal -> quickcheck -> cabal

RDEPEND="
	>=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
"
#	test? (
#		>=dev-haskell/async-2.2.2 <dev-haskell/async-2.3
#		>=dev-haskell/base-compat-0.11.0 <dev-haskell/base-compat-0.12
#		>=dev-haskell/base-orphans-0.6 <dev-haskell/base-orphans-0.9
#		>=dev-haskell/clock-0.8 <dev-haskell/clock-0.9
#		>=dev-haskell/diff-0.4 <dev-haskell/diff-0.5
#		>=dev-haskell/integer-logarithms-1.0.2 <dev-haskell/integer-logarithms-1.1
#		>=dev-haskell/optparse-applicative-0.13.2.0 <dev-haskell/optparse-applicative-0.17
#		>=dev-haskell/quickcheck-2.14 <dev-haskell/quickcheck-2.15
#		>=dev-haskell/rere-0.1 <dev-haskell/rere-0.3
#		>=dev-haskell/stm-2.4.5.0 <dev-haskell/stm-2.6
#		dev-haskell/tagged
#		>=dev-haskell/tar-0.5.0.3 <dev-haskell/tar-0.6
#		>=dev-haskell/tasty-1.2.3 <dev-haskell/tasty-1.4
#		>=dev-haskell/tasty-golden-2.3.1.1 <dev-haskell/tasty-golden-2.4
#		dev-haskell/tasty-hunit
#		dev-haskell/tasty-quickcheck
#		dev-haskell/temporary
#		>=dev-haskell/tree-diff-0.1 <dev-haskell/tree-diff-0.2
#	)

src_prepare() {
	haskell-cabal_src_prepare

	# Cabal bootstraps with 'ghc --make' without package cleanup in environment.
	# That causes module collisions at build:
	# - pulseaudio: Distribution/Utils/Structured.hs:98:1: error: Ambiguous module name ‘Data.Time’: it was found in multiple packages: pulseaudio-0.0.2.1 time-1.9.3
	# - kinds: Distribution/Utils/Structured.hs:106:1: error: Ambiguous module name ‘Data.Kind’: it was found in multiple packages: base-4.14.1.0 kinds-0.0.1.5
	HCFLAGS="${HCFLAGS} -ignore-package=pulseaudio"
	HCFLAGS="${HCFLAGS} -ignore-package=kinds"
}

src_configure() {
	haskell-cabal_src_configure \
		--flag=-parsec-struct-diff
}

CABAL_CORE_LIB_GHC_PV="9.0.2"

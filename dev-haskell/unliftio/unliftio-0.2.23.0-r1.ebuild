# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.0.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="The MonadUnliftIO typeclass for unlifting monads to IO (batteries included)"
HOMEPAGE="https://github.com/fpco/unliftio/tree/master/unliftio#readme"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

RDEPEND="
	>dev-haskell/async-2.1.1:=[profile?]
	dev-haskell/safe-exceptions:=[profile?]
	>=dev-haskell/stm-2.5:=[profile?]
	>=dev-haskell/unliftio-core-0.1.1.0:=[profile?]
	>=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	test? (
		dev-haskell/hspec
		dev-haskell/quickcheck
	)
"

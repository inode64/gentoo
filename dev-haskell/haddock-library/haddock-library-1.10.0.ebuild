# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.1.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
CABAL_HACKAGE_REVISION="3"
inherit haskell-cabal

CABAL_FILE="${S}/${PN}.cabal"
CABAL_DISTFILE="${P}-rev${CABAL_HACKAGE_REVISION}.cabal"

DESCRIPTION="Library exposing some functionality of Haddock"
HOMEPAGE="https://www.haskell.org/haddock/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz
	https://hackage.haskell.org/package/${P}/revision/${CABAL_HACKAGE_REVISION}.cabal
		-> ${CABAL_DISTFILE}"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86 ~amd64-linux ~x86-linux"

RDEPEND=">=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	test? ( >=dev-haskell/hspec-2.4.4
		>=dev-haskell/hspec-discover-2.4.4
		>=dev-haskell/optparse-applicative-0.15
		>=dev-haskell/tree-diff-0.1
		>=dev-haskell/base-compat-0.11.0
		>=dev-haskell/quickcheck-2.13.2 <dev-haskell/quickcheck-2.15 )
"
BDEPEND="app-text/dos2unix"

src_prepare() {
	# pull revised cabal from upstream
	cp "${DISTDIR}/${CABAL_DISTFILE}" "${CABAL_FILE}" || die

	# Convert to unix line endings
	dos2unix "${CABAL_FILE}" || die

	# Apply patches *after* pulling the revised cabal
	default

	cabal_chdeps \
		'hspec                          >= 2.4.4    && < 2.8' 'hspec >=2.4.4' \
		'hspec-discover:hspec-discover  >= 2.4.4    && < 2.8' 'hspec-discover:hspec-discover >=2.4.4' \
		'optparse-applicative  ^>= 0.15' 'optparse-applicative >=0.15' \
		'tree-diff             ^>= 0.1' 'tree-diff >=0.1' \
		'base-compat  ^>= 0.9.3 || ^>= 0.11.0' 'base-compat >=0.11.0' \
		'base-compat           ^>= 0.9.3 || ^>= 0.11.0' 'base-compat >=0.11.0'
}

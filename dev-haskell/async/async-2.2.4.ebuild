# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.1.1.9999
#hackport: flags: -bench

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
CABAL_HACKAGE_REVISION="1"
inherit haskell-cabal

DESCRIPTION="Run IO operations asynchronously and wait for their results"
HOMEPAGE="https://github.com/simonmar/async"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz
	https://hackage.haskell.org/package/${P}/revision/${CABAL_HACKAGE_REVISION}.cabal -> ${PF}.cabal"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"

RDEPEND=">=dev-haskell/hashable-1.1.2.0:=[profile?] <dev-haskell/hashable-1.5:=[profile?]
	>=dev-haskell/stm-2.2:=[profile?] <dev-haskell/stm-2.6:=[profile?]
	>=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	test? ( dev-haskell/hunit
		dev-haskell/test-framework
		dev-haskell/test-framework-hunit )
"
BDEPEND="app-text/dos2unix"

src_prepare() {
	# pull revised cabal from upstream
	cp "${DISTDIR}/${PF}.cabal" "${S}/${PN}.cabal" || die

	# Convert to unix line endings
	dos2unix "${S}/${PN}.cabal" || die

	# Apply patches *after* pulling the revised cabal
	default
}

src_configure() {
	haskell-cabal_src_configure \
		--flag=-bench
}

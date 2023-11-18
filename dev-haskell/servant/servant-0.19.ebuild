# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.1.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
CABAL_HACKAGE_REVISION="4"
inherit haskell-cabal

CABAL_FILE="${S}/${PN}.cabal"
CABAL_DISTFILE="${P}-rev${CABAL_HACKAGE_REVISION}.cabal"

DESCRIPTION="A family of combinators for defining webservices APIs"
HOMEPAGE="https://docs.servant.dev/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz
	https://hackage.haskell.org/package/${P}/revision/${CABAL_HACKAGE_REVISION}.cabal
		-> ${CABAL_DISTFILE}"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 ~arm64 ~ppc64 ~riscv ~x86"

RDEPEND=">=dev-haskell/aeson-1.4.1.0:=[profile?] <dev-haskell/aeson-3:=[profile?]
	>=dev-haskell/attoparsec-0.13.2.2:=[profile?] <dev-haskell/attoparsec-0.15:=[profile?]
	>=dev-haskell/base-compat-0.10.5:=[profile?] <dev-haskell/base-compat-0.13:=[profile?]
	>=dev-haskell/bifunctors-5.5.3:=[profile?] <dev-haskell/bifunctors-5.6:=[profile?]
	>=dev-haskell/case-insensitive-1.2.0.11:=[profile?] <dev-haskell/case-insensitive-1.3:=[profile?]
	>=dev-haskell/constraints-0.2:=[profile?]
	>=dev-haskell/http-api-data-0.4.1:=[profile?] <dev-haskell/http-api-data-0.4.4:=[profile?]
	>=dev-haskell/http-media-0.7.1.3:=[profile?] <dev-haskell/http-media-0.9:=[profile?]
	>=dev-haskell/http-types-0.12.2:=[profile?] <dev-haskell/http-types-0.13:=[profile?]
	>=dev-haskell/mmorph-1.1.2:=[profile?] <dev-haskell/mmorph-1.3:=[profile?]
	>=dev-haskell/network-uri-2.6.1.0:=[profile?] <dev-haskell/network-uri-2.7:=[profile?]
	>=dev-haskell/quickcheck-2.12.6.1:=[profile?] <dev-haskell/quickcheck-2.15:=[profile?]
	>=dev-haskell/singleton-bool-0.1.4:=[profile?] <dev-haskell/singleton-bool-0.1.7:=[profile?]
	>=dev-haskell/sop-core-0.4.0.0:=[profile?] <dev-haskell/sop-core-0.6:=[profile?]
	>=dev-haskell/string-conversions-0.4.0.1:=[profile?] <dev-haskell/string-conversions-0.5:=[profile?]
	>=dev-haskell/tagged-0.8.6:=[profile?] <dev-haskell/tagged-0.9:=[profile?]
	>=dev-haskell/vault-0.3.1.2:=[profile?] <dev-haskell/vault-0.4:=[profile?]
	>=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	test? ( >=dev-haskell/hspec-2.6.0 <dev-haskell/hspec-2.10
		>=dev-haskell/quickcheck-instances-0.3.19 <dev-haskell/quickcheck-instances-0.4 )
"
BDEPEND="app-text/dos2unix"

src_prepare() {
	# pull revised cabal from upstream
	cp "${DISTDIR}/${CABAL_DISTFILE}" "${CABAL_FILE}" || die

	# Convert to unix line endings
	dos2unix "${CABAL_FILE}" || die

	# Apply patches *after* pulling the revised cabal
	default
}

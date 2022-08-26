# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="JSON pretty-printing library and command-line tool"
HOMEPAGE="https://github.com/informatikr/aeson-pretty"
HACKAGE_REV="1"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz
	https://hackage.haskell.org/package/${P}/revision/${HACKAGE_REV}.cabal -> ${PF}.cabal"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"
IUSE="lib-only"

RDEPEND=">=dev-haskell/base-compat-0.9:=[profile?]
	>=dev-haskell/scientific-0.3:=[profile?]
	>=dev-haskell/text-0.11:=[profile?]
	>=dev-haskell/unordered-containers-0.2.14.0:=[profile?]
	>=dev-haskell/vector-0.9:=[profile?]
	>=dev-lang/ghc-8.4.3:=
	>=dev-haskell/aeson-1.0:=[profile?] <dev-haskell/aeson-2.1:=[profile?]
	!lib-only? ( >=dev-haskell/aeson-0.6:=[profile?]
			>=dev-haskell/attoparsec-0.10:=[profile?]
			>=dev-haskell/cmdargs-0.7:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag lib-only lib-only)
}

src_prepare() {
	# pull revised cabal from upstream
	cp "${DISTDIR}/${PF}.cabal" "${S}/${PN}.cabal" || die

	# Apply patches *after* pulling the revised cabal
	default
}

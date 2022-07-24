# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.1.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Interfacing with RSS (v 0.9x, 2.x, 1.0) + Atom feeds"
HOMEPAGE="https://github.com/haskell-party/feed"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc64 ~x86"

PATCHES=( "${FILESDIR}/${PN}-1.3.2.1-disable-doctest.patch" )

RDEPEND=">=dev-haskell/base-compat-0.9:=[profile?] <dev-haskell/base-compat-0.13:=[profile?]
	>=dev-haskell/old-locale-1.0:=[profile?] <dev-haskell/old-locale-1.1:=[profile?]
	>=dev-haskell/old-time-1:=[profile?] <dev-haskell/old-time-1.2:=[profile?]
	>=dev-haskell/safe-0.3:=[profile?] <dev-haskell/safe-0.4:=[profile?]
	>=dev-haskell/time-locale-compat-0.1:=[profile?] <dev-haskell/time-locale-compat-0.2:=[profile?]
	<dev-haskell/utf8-string-1.1:=[profile?]
	>=dev-haskell/xml-conduit-1.3:=[profile?] <dev-haskell/xml-conduit-1.10:=[profile?]
	>=dev-haskell/xml-types-0.3.6:=[profile?] <dev-haskell/xml-types-0.4:=[profile?]
	>=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	test? ( dev-haskell/doctest
		>=dev-haskell/hunit-1.2 <dev-haskell/hunit-1.7
		>=dev-haskell/markdown-unlit-0.4 <dev-haskell/markdown-unlit-0.6
		dev-haskell/syb
		>=dev-haskell/test-framework-0.8 <dev-haskell/test-framework-0.9
		>=dev-haskell/test-framework-hunit-0.3 <dev-haskell/test-framework-hunit-0.4 )
"

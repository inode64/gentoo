# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.1.2.9999
#hackport: flags: -warp-tests,-mtl1,-warn-as-error,-old-base,-network23,+network-uri,-conduit10

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

MY_PN="HTTP"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A library for client-side HTTP"
HOMEPAGE="https://github.com/haskell/HTTP"
SRC_URI="https://hackage.haskell.org/package/${MY_P}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND=">=dev-haskell/network-2.6:=[profile?] <dev-haskell/network-3.2:=[profile?]
	>=dev-haskell/network-uri-2.6:=[profile?] <dev-haskell/network-uri-2.7:=[profile?]
	>=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	test? ( >=dev-haskell/httpd-shed-0.4 <dev-haskell/httpd-shed-0.5
		>=dev-haskell/hunit-1.2.0.1 <dev-haskell/hunit-1.7
		>=dev-haskell/puremd5-0.2.4 <dev-haskell/puremd5-2.2
		>=dev-haskell/split-0.1.3 <dev-haskell/split-0.3
		>=dev-haskell/test-framework-0.2.0 <dev-haskell/test-framework-0.9
		>=dev-haskell/test-framework-hunit-0.3.0 <dev-haskell/test-framework-hunit-0.4 )
"

src_configure() {
	haskell-cabal_src_configure \
		--flag=-conduit10 \
		--flag=-mtl1 \
		--flag=network-uri \
		--flag=-network23 \
		--flag=-old-base \
		--flag=-warn-as-error \
		--flag=-warp-tests
}

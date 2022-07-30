# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.9999
#hackport: flags: +network-uri
CABAL_FEATURES="lib profile haddock hoogle hscolour" # test-suite circular depends
inherit haskell-cabal

DESCRIPTION="An HTTP client using io-streams"
HOMEPAGE="https://github.com/aesiniath/http-streams/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc64 ~x86"

RESTRICT=test #circular test depend: http-streams -> snap-server -> http-streams

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/attoparsec:=[profile?]
	dev-haskell/base64-bytestring:=[profile?]
	>=dev-haskell/blaze-builder-0.4:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	>=dev-haskell/hsopenssl-0.11.2:=[profile?]
	>=dev-haskell/http-common-0.8.3.4:=[profile?]
	>=dev-haskell/io-streams-1.3:=[zlib,profile?] <dev-haskell/io-streams-1.6:=[zlib,profile?]
	dev-haskell/mtl:=[profile?]
	>=dev-haskell/openssl-streams-1.1:=[profile?] <dev-haskell/openssl-streams-1.4:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	>=dev-lang/ghc-8.4.3:=
	>=dev-haskell/network-2.6:=[profile?]
	>=dev-haskell/network-uri-2.6:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1"
# 	test? ( dev-haskell/aeson-pretty
# 		dev-haskell/hspec
# 		dev-haskell/hspec-expectations
# 		dev-haskell/hunit
# 		dev-haskell/lifted-base
# 		dev-haskell/random
# 		>=dev-haskell/snap-core-1.0 <dev-haskell/snap-core-1.2
# 		>=dev-haskell/snap-server-1.1 <dev-haskell/snap-server-1.2
# 		>=dev-haskell/system-fileio-0.3.10 <dev-haskell/system-fileio-0.4
# 		>=dev-haskell/system-filepath-0.4.1 <dev-haskell/system-filepath-0.5
# 		!network-uri? ( >=dev-haskell/network-2.6
# 				>=dev-haskell/network-uri-2.6 ) )
# "

src_configure() {
	haskell-cabal_src_configure \
		--flag=network-uri
}

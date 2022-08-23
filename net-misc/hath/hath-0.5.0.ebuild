# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6

CABAL_FEATURES="test-suite"
inherit haskell-cabal

DESCRIPTION="Hath manipulates network blocks in CIDR notation"
HOMEPAGE="http://michael.orlitzky.com/code/hath.xhtml"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/cmdargs-0.10:=
	>=dev-haskell/split-0.2:=
	>=dev-haskell/tasty-0.8:=
	>=dev-haskell/tasty-hunit-0.8:=
	>=dev-haskell/tasty-quickcheck-0.8.1:=
	>=dev-lang/ghc-8.0.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.24.0.0
	test? ( dev-util/shelltestrunner )
"

src_prepare() {
	sed -i -e '/-optc-O3/d' -e '/-optc-march=native/d' "${PN}.cabal" || die
	default
}

src_install() {
	cabal_src_install
	doman "${S}/doc/man1/${PN}.1"
}

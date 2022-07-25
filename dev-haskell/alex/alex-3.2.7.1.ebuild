# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.9999
#hackport: flags: +small_base

CABAL_FEATURES="test-suite"
inherit autotools haskell-cabal

DESCRIPTION="Alex is a tool for generating lexical analysers in Haskell"
HOMEPAGE="https://www.haskell.org/alex/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="doc"

RDEPEND=">=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	doc? ( ~app-text/docbook-xml-dtd-4.2
		app-text/docbook-xsl-stylesheets
		>=dev-libs/libxslt-1.1.2 )
"

src_prepare() {
	default

	if use doc; then
		cd "${S}/doc/"
		eautoreconf
	fi
}

src_configure() {
	# make sure we don't accidentally use those
	# installed in system
	haskell-cabal_src_configure \
		--with-alex=false \
		--with-happy=false \
		--flag=small_base

	if use doc; then
		cd "${S}/doc/"
		econf
	fi
}

src_compile() {
	haskell-cabal_src_compile

	if use doc; then
		emake -C "${S}/doc/" -j1
	fi
}

src_test() {
	# 1. workaround Setup.hs deadlock: https://github.com/haskell/cabal/issues/2398
	# 2. use freshly built ALEX= binary and datadir path
	alex_datadir="${S}"/data \
	emake -k -C tests all ALEX="${S}"/dist/build/alex/alex
}

src_install() {
	haskell-cabal_src_install

	if use doc; then
		doman "${S}/doc/alex.1"
		docinto html
		dodoc -r "${S}/doc/alex/"
	fi
}

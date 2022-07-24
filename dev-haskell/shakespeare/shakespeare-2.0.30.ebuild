# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.1.2.9999
#hackport: flags: test_coffee:test,test_export:test,test_roy:test

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="A toolkit for making compile-time interpolated templates"
HOMEPAGE="https://www.yesodweb.com/book/shakespearean-templates"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND="<dev-haskell/aeson-3:=[profile?]
	dev-haskell/blaze-html:=[profile?]
	dev-haskell/blaze-markup:=[profile?]
	>=dev-haskell/file-embed-0.0.1:=[profile?] <dev-haskell/file-embed-0.1:=[profile?]
	>=dev-haskell/scientific-0.3.0.0:=[profile?]
	dev-haskell/th-lift:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-haskell/vector:=[profile?]
	>=dev-lang/ghc-8.10.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.2.0.0
	test? ( >=dev-haskell/hspec-2 <dev-haskell/hspec-3
		dev-haskell/hunit )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag test test_coffee) \
		$(cabal_flag test test_export) \
		$(cabal_flag test test_roy)
}

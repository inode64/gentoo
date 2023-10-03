# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.2.0.9999
#hackport: flags: +cairo_pdf,+cairo_ps,cairo_svg:svg

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Binding to the Cairo library"
HOMEPAGE="https://projects.haskell.org/gtk2hs/"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"
IUSE="+svg"

RDEPEND=">=dev-haskell/text-1.0.0.0:=[profile?] <dev-haskell/text-2.1:=[profile?]
	>=dev-haskell/utf8-string-0.2:=[profile?] <dev-haskell/utf8-string-1.1:=[profile?]
	>=dev-lang/ghc-8.8.1:=
	x11-libs/cairo
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.0.0.0 <dev-haskell/cabal-3.11
"
BDEPEND=">=dev-haskell/gtk2hs-buildtools-0.13.2.0 <dev-haskell/gtk2hs-buildtools-0.14
	virtual/pkgconfig
"

src_configure() {
	haskell-cabal_src_configure \
		--flag=cairo_pdf \
		--flag=cairo_ps \
		$(cabal_flag svg cairo_svg)
}

GHC_BOOTSTRAP_PACKAGES=( gtk2hs-buildtools )

# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0.9999
#hackport: flags: testprog:examples

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Command line argument processing"
HOMEPAGE="https://github.com/ndmitchell/cmdargs#readme"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"
IUSE="examples +quotation"
REQUIRED_USE="examples? ( quotation )"

CABAL_CHDEPS=(
	'executable cmdargs' 'executable cmdargs-demo'
)

RDEPEND="
	>=dev-lang/ghc-8.8.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.0.0.0
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag quotation quotation) \
		$(cabal_flag examples testprog)
}

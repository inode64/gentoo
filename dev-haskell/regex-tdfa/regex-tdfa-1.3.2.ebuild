# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.1.2.9999
#hackport: flags: +base4,-devel,+force-o2

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Pure Haskell Tagged DFA Backend for \"Text.Regex\" (regex-base)"
HOMEPAGE="https://wiki.haskell.org/Regular_expressions"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc64 ~x86"

PATCHES=(
	"${FILESDIR}/${PN}-1.3.2-disable-doctests.patch"
)

RDEPEND=">=dev-haskell/regex-base-0.94:=[profile?] <dev-haskell/regex-base-0.95:=[profile?]
	>=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	test? (
		>=dev-haskell/utf8-string-1.0.1 <dev-haskell/utf8-string-1.1
	)
"

src_configure() {
	haskell-cabal_src_configure \
		--flag=base4 \
		--flag=-devel \
		--flag=force-o2
}

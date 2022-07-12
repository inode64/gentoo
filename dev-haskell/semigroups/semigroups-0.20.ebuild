# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.1.1.9999
#hackport: flags: +bytestring,+containers,+deepseq,+hashable,+tagged,+text,+unordered-containers,+binary,-bytestring-builder,+template-haskell,+transformers

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Anything that associates"
HOMEPAGE="https://github.com/ekmett/semigroups/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND=">=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
"

src_configure() {
	haskell-cabal_src_configure \
		--flag=binary \
		--flag=bytestring \
		--flag=-bytestring-builder \
		--flag=containers \
		--flag=deepseq \
		--flag=hashable \
		--flag=tagged \
		--flag=template-haskell \
		--flag=text \
		--flag=transformers \
		--flag=unordered-containers
}

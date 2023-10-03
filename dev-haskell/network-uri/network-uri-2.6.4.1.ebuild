# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.6.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour" # test-suite
inherit haskell-cabal

DESCRIPTION="URI manipulation"
HOMEPAGE="https://github.com/haskell/network-uri"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 ~arm64 ~ppc64 ~riscv ~x86 ~amd64-linux ~x86-linux"

RESTRICT=test # circular depend: network-uri[test]->criterion->js-flot->http->network-uri

RDEPEND=">=dev-haskell/parsec-3.1.12.0:=[profile?] <dev-haskell/parsec-3.2:=[profile?]
	>=dev-haskell/th-compat-0.1.1:=[profile?] <dev-haskell/th-compat-1.0:=[profile?]
	>=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1"
# 	test? ( dev-haskell/hunit
# 		dev-haskell/quickcheck
# 		dev-haskell/tasty
# 		dev-haskell/tasty-hunit
# 		dev-haskell/tasty-quickcheck )
# "

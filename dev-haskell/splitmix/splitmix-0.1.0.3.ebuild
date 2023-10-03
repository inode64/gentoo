# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.6.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour" # test-suite"
inherit haskell-cabal

DESCRIPTION="Fast Splittable PRNG"
HOMEPAGE="https://hackage.haskell.org/package/splitmix"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 ~arm64 ~ppc64 ~riscv ~x86"
IUSE="optimised-mixer"

RESTRICT=test # circular deps: dev-haskell/splitmix[test]->dev-haskell/base-compat-batteries->dev-haskell/quickcheck->dev-haskell/splitmix

RDEPEND=">=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10"
	# test? ( >=dev-haskell/async-2.2.1 <dev-haskell/async-2.3
	# 	>=dev-haskell/base-compat-0.11.1 <dev-haskell/base-compat-0.12
	# 	>=dev-haskell/base-compat-batteries-0.10.5 <dev-haskell/base-compat-batteries-0.12
	# 	dev-haskell/random
	# 	>=dev-haskell/test-framework-0.8.2.0 <dev-haskell/test-framework-0.9
	# 	>=dev-haskell/test-framework-hunit-0.3.0.2 <dev-haskell/test-framework-hunit-0.4
	# 	>=dev-haskell/tf-random-0.5 <dev-haskell/tf-random-0.6
	# 	>=dev-haskell/vector-0.11.0.0 <dev-haskell/vector-0.13
	# 	|| ( ( >=dev-haskell/hunit-1.6.0.0 <dev-haskell/hunit-1.7 )
	# 		~dev-haskell/hunit-1.3.1.2 )
	# 	|| ( ( >=dev-haskell/math-functions-0.3.3.0 <dev-haskell/math-functions-0.4 )
	# 		~dev-haskell/math-functions-0.1.7.0 ) )
#"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag optimised-mixer optimised-mixer)
}

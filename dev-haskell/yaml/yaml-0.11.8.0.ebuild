# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.1.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Support for parsing and rendering YAML documents"
HOMEPAGE="https://github.com/snoyberg/yaml#readme"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"
IUSE="examples executable"

RDEPEND=">=dev-haskell/aeson-0.11:=[profile?]
	>=dev-haskell/attoparsec-0.11.3.0:=[profile?]
	>=dev-haskell/conduit-1.2.8:=[profile?] <dev-haskell/conduit-1.4:=[profile?]
	>=dev-haskell/libyaml-0.1:=[profile?] <dev-haskell/libyaml-0.2:=[profile?]
	>=dev-haskell/resourcet-0.3:=[profile?] <dev-haskell/resourcet-1.3:=[profile?]
	>=dev-haskell/scientific-0.3:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-haskell/vector:=[profile?]
	>=dev-lang/ghc-8.4.3:=
	examples? ( dev-haskell/raw-strings-qq:=[profile?] )
	executable? ( dev-haskell/optparse-applicative:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	test? ( dev-haskell/base-compat
		>=dev-haskell/hspec-1.3
		dev-haskell/hunit
		dev-haskell/mockery
		dev-haskell/temporary
		!examples? ( dev-haskell/raw-strings-qq ) )
"

src_prepare() {
	default

	cabal_chdeps \
		'executable examples' 'executable haskell-yaml-examples'
}

src_configure() {
	local examples_flag="no-examples"
	use examples && examples_flag="-no-examples"

	local exe_flag="no-exe"
	use executable && exe_flag="-no-exe"

	haskell-cabal_src_configure \
		--flag="${examples_flag}" \
		--flag="${exe_flag}"
}

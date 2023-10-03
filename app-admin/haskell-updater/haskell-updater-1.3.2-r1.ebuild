# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.0.0.9999

CABAL_FEATURES="nocabaldep"
inherit haskell-cabal

DESCRIPTION="Rebuild Haskell dependencies in Gentoo"
HOMEPAGE="https://github.com/gentoo-haskell/haskell-updater#readme"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~ppc64 ~riscv ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos"

DEPEND=">=dev-lang/ghc-6.12.1:="

# Need a lower version for portage to get --keep-going
RDEPEND="|| ( >=sys-apps/portage-2.1.6
		sys-apps/pkgcore )"

src_prepare() {
	default

	if use prefix; then
		sed -i -e "s,/var/db/pkg,${EPREFIX}&,g" \
			"${S}/Distribution/Gentoo/Packages.hs" || die

		sed -i -e 's,"/","'"${EPREFIX}"'/",g' \
			"${S}/Distribution/Gentoo/GHC.hs" || die
	fi
}

src_configure() {
	cabal_src_configure \
		--bindir="${EPREFIX}/usr/sbin" \
		--constraint="Cabal == $(cabal-version)"
}

src_install() {
	cabal_src_install

	dodoc TODO
}

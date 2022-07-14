# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Tools and library to manipulate EFI variables"
HOMEPAGE="https://github.com/rhinstaller/efivar"
SRC_URI="https://github.com/rhinstaller/efivar/releases/download/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm arm64 ~ia64 ~ppc64 ~riscv x86"

RDEPEND="dev-libs/popt"
DEPEND="${RDEPEND}
	>=sys-kernel/linux-headers-3.18
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/${PN}-37-ia64-relro.patch
)

src_prepare() {
	default
	sed -i -e 's/-Werror //' gcc.specs || die
}

src_configure() {
	tc-export CC
	export CC_FOR_BUILD=$(tc-getBUILD_CC)
	tc-ld-disable-gold
	export libdir="/usr/$(get_libdir)"
	unset LIBS # Bug 562004

	if [[ -n ${GCC_SPECS} ]]; then
		# The environment overrides the command line.
		GCC_SPECS+=":${S}/gcc.specs"
	fi
}

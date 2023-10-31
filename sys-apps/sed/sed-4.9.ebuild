# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VERIFY_SIG_OPENPGP_KEY_PATH=/usr/share/openpgp-keys/sed.asc
inherit flag-o-matic verify-sig

DESCRIPTION="Super-useful stream editor"
HOMEPAGE="https://www.gnu.org/software/sed/"
SRC_URI="mirror://gnu/sed/${P}.tar.xz"
SRC_URI+=" verify-sig? ( mirror://gnu/sed/${P}.tar.xz.sig )"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~arm64-macos"
IUSE="acl nls selinux static"

RDEPEND="
	!static? (
		acl? ( virtual/acl )
		nls? ( virtual/libintl )
		selinux? ( sys-libs/libselinux )
	)
"
DEPEND="${RDEPEND}
	static? (
		acl? ( virtual/acl[static-libs(+)] )
		nls? ( virtual/libintl[static-libs(+)] )
		selinux? ( sys-libs/libselinux[static-libs(+)] )
	)
"
BDEPEND="nls? ( sys-devel/gettext )
	verify-sig? ( sec-keys/openpgp-keys-sed )"

src_configure() {
	use static && append-ldflags -static

	local myconf=(
		--exec-prefix="${EPREFIX}"
		$(use_enable acl)
		$(use_enable nls)
		$(use_with selinux)
		# rename to gsed for better BSD compatibility
		--program-prefix=g
	)
	econf "${myconf[@]}"
}

src_test() {
	# We don't want to automagically use Valgrind for tests.
	sed -i -e 's:valgrind --error-exitcode=1:false:' init.cfg || die

	emake VERBOSE=yes check
}

src_install() {
	default

	# symlink to the standard name
	dosym gsed /bin/sed
	dosym gsed.1 /usr/share/man/man1/sed.1
}

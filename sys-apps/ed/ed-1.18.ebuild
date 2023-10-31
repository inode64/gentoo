# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

VERIFY_SIG_OPENPGP_KEY_PATH=/usr/share/openpgp-keys/antoniodiazdiaz.asc
inherit toolchain-funcs unpacker verify-sig

MY_P="${PN}-${PV/_/-}"

DESCRIPTION="Your basic line editor"
HOMEPAGE="https://www.gnu.org/software/ed/"
SRC_URI="mirror://gnu/ed/${P}.tar.lz"
SRC_URI+=" verify-sig? ( mirror://gnu/ed/${P}.tar.lz.sig )"
S="${WORKDIR}"/${MY_P}

LICENSE="GPL-2+"
SLOT="0"
if [[ ${PV} != *_rc* ]] ; then
	KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x64-solaris"
fi

BDEPEND="sys-apps/texinfo
	$(unpacker_src_uri_depends)
	verify-sig? ( sec-keys/openpgp-keys-antoniodiazdiaz )"

src_unpack() {
	use verify-sig && verify-sig_verify_detached "${DISTDIR}"/${P}.tar.lz{,.sig}
	unpacker "${DISTDIR}"/${P}.tar.lz
}

src_configure() {
	./configure \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		CPPFLAGS="${CPPFLAGS}" \
		--bindir="${EPREFIX}/bin" \
		--prefix="${EPREFIX}/usr" || die
}

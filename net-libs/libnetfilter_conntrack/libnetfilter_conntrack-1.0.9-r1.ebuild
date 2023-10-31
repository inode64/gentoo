# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools linux-info verify-sig

DESCRIPTION="Programming interface (API) to the in-kernel connection tracking state table"
HOMEPAGE="https://www.netfilter.org/projects/libnetfilter_conntrack/"
SRC_URI="https://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2
	verify-sig? ( https://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2.sig )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86"
VERIFY_SIG_OPENPGP_KEY_PATH=/usr/share/openpgp-keys/netfilter.org.asc

RDEPEND=">=net-libs/libmnl-1.0.3
	>=net-libs/libnfnetlink-1.0.0"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	verify-sig? ( sec-keys/openpgp-keys-netfilter )"

DOCS=( README )

PATCHES=(
	"${FILESDIR}"/${P}-musl.patch
	"${FILESDIR}"/${PN}-1.0.9-configure-clang16.patch
)

pkg_setup() {
	linux-info_pkg_setup

	if kernel_is lt 2 6 18 ; then
		die "${PN} requires at least 2.6.18 kernel version"
	fi

	# netfilter core team has changed some option names with kernel 2.6.20
	if kernel_is lt 2 6 20 ; then
		CONFIG_CHECK="~IP_NF_CONNTRACK_NETLINK"
	else
		CONFIG_CHECK="~NF_CT_NETLINK"
	fi

	check_extra_config
}

src_prepare() {
	default

	# autoreconf only for clang 16 configure patch
	eautoreconf
}

src_install() {
	default

	find "${ED}" -name '*.la' -delete || die
}

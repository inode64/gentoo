# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Generate access-lists for various routers, maintained fork of bgpq3"
HOMEPAGE="https://github.com/bgp/bgpq4/"
SRC_URI="https://github.com/bgp/bgpq4/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"

src_prepare() {
	eapply_user
	eautoreconf
}

src_install() {
	dobin bgpq4
	doman bgpq4.8
	dodoc CHANGES COPYRIGHT README.md
}

# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="${PV//_/-}"
MY_PV="${MY_PV/p/r}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A SQL Server injection & takeover tool"
HOMEPAGE="http://sqlninja.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/${PN}/${MY_P}.tgz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
RESTRICT="mirror"

RDEPEND="
	dev-lang/perl
	dev-perl/IO-Socket-SSL
	dev-perl/List-MoreUtils
	dev-perl/Net-DNS
	dev-perl/Net-Pcap
	dev-perl/Net-RawIP
	dev-perl/NetPacket
"

src_install() {
	dodoc sqlninja-howto.html ChangeLog README

	if use doc; then
		dodoc -r sources
		docompress -x /usr/share/doc/${P}/sources
	fi

	insinto /etc/${PN}
	doins sqlninja.conf.example

	rm -r sources sqlninja-howto.html ChangeLog README LICENSE || die
	rm -r apps || die
	rm sqlninja.conf.example || die

	insinto /usr/lib/${PN}
	exeinto /usr/lib/${PN}
	doins -r *

	doexe sqlninja
	dosbin "${FILESDIR}"/${PN}
}

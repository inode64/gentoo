# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Transitional package for net-p2p/bitcoin-core[qt5]"
HOMEPAGE="https://bitcoincore.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~mips ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+asm +berkdb dbus +external-signer kde nat-pmp +qrcode +sqlite systemtap test upnp +wallet zeromq"
RESTRICT="!test? ( test )"

RDEPEND="
	~net-p2p/bitcoin-core-${PV}[gui,asm=,berkdb=,dbus=,external-signer=,kde=,nat-pmp=,qrcode=,sqlite=,systemtap=,test=,upnp=,zeromq=]
	wallet? ( || ( ~net-p2p/bitcoin-core-${PV}[berkdb] ~net-p2p/bitcoin-core-${PV}[sqlite] ) )
"

# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GNOME_ORG_MODULE="NetworkManager-${PN##*-}"

inherit gnome2

DESCRIPTION="NetworkManager libreswan plugin"
HOMEPAGE="https://wiki.gnome.org/Projects/NetworkManager/VPN"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

RDEPEND="
	>=dev-libs/glib-2.32:2
	>=dev-libs/libnl-3.2.8:3
	>=net-misc/networkmanager-1.2.0:=
	net-vpn/libreswan
	gtk? (
		app-crypt/libsecret
		>=gnome-extra/nm-applet-1.2.0
		>=x11-libs/gtk+-3.4:3
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/gettext
	dev-util/intltool
	virtual/pkgconfig
"

src_prepare() {
	sed -i 's|/appdata|/metainfo|g' Makefile.{in,am} || die

	gnome2_src_prepare
}

src_configure() {
	local myconf=(
		--disable-more-warnings
		--disable-static
		--with-dist-version=Gentoo
		--without-libnm-glib
		$(use_with gtk gnome)
	)
	gnome2_src_configure "${myconf[@]}"
}

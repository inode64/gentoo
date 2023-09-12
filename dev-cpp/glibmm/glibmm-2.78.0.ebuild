# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{9..11} )
inherit gnome.org meson-multilib python-any-r1

DESCRIPTION="C++ interface for glib2"
HOMEPAGE="https://www.gtkmm.org https://gitlab.gnome.org/GNOME/glibmm"

LICENSE="LGPL-2.1+"
SLOT="2.68"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~loong ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="gtk-doc debug test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-libs/glib-2.77.0:2[${MULTILIB_USEDEP}]
	dev-libs/libsigc++:3[gtk-doc?,${MULTILIB_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	${PYTHON_DEPS}
	virtual/pkgconfig
	gtk-doc? (
		app-doc/doxygen[dot]
		dev-lang/perl
		dev-libs/libxslt
	)
"

src_prepare() {
	default

	# giomm_tls_client requires FEATURES=-network-sandbox and glib-networking rdep
	sed -i -e '/giomm_tls_client/d' tests/meson.build || die

	if ! use test; then
		sed -i -e "/^subdir('tests')/d" meson.build || die
	fi
}

multilib_src_configure() {
	local emesonargs=(
		-Dwarnings=min
		-Dbuild-deprecated-api=true
		$(meson_native_use_bool gtk-doc build-documentation)
		$(meson_use debug debug-refcounting)
		-Dbuild-examples=false
	)
	meson_src_configure
}

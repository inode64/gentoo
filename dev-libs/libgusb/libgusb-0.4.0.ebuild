# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
PYTHON_REQ_USE="xml(+)"

inherit meson-multilib python-any-r1 vala

DESCRIPTION="GObject wrapper for libusb"
HOMEPAGE="https://github.com/hughsie/libgusb"
SRC_URI="https://people.freedesktop.org/~hughsient/releases/${P}.tar.xz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~loong ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86"

IUSE="gtk-doc +introspection test +vala"
REQUIRED_USE="vala? ( introspection )"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-libs/glib-2.44.0:2[${MULTILIB_USEDEP}]
	virtual/libusb:1[udev,${MULTILIB_USEDEP}]
	>=dev-libs/json-glib-1.1.1[${MULTILIB_USEDEP}]
	introspection? ( >=dev-libs/gobject-introspection-1.54:= )
	sys-apps/hwdata
"
DEPEND="${RDEPEND}
	test? ( >=dev-util/umockdev-0.17.7[${MULTILIB_USEDEP}] )"
BDEPEND="
	$(python_gen_any_dep 'dev-python/setuptools[${PYTHON_USEDEP}]')
	gtk-doc? (
		app-text/docbook-xml-dtd:4.1.2
		app-text/docbook-xml-dtd:4.4
		dev-util/gtk-doc
	)
	vala? ( $(vala_depend) )
	virtual/pkgconfig
"

python_check_deps() {
	python_has_version "dev-python/setuptools[${PYTHON_USEDEP}]"
}

src_prepare() {
	default
	use vala && vala_setup
}

multilib_src_configure() {
	local emesonargs=(
		-Ddefault_library=shared
		$(meson_use test tests)
		$(meson_native_use_bool vala vapi)
		-Dusb_ids="${EPREFIX}"/usr/share/hwdata/usb.ids
		$(meson_native_use_bool gtk-doc docs)
		$(meson_native_use_bool introspection)
		$(meson_feature test umockdev)

	)
	meson_src_configure
}

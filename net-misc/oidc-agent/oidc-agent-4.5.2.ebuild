# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils

DESCRIPTION="Agent and tools for managing OpenID Connect tokens on the command line"
HOMEPAGE="https://github.com/indigo-dc/oidc-agent"
SRC_URI="https://github.com/indigo-dc/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~riscv"
IUSE="test"

DEPEND="app-crypt/libsecret
	dev-libs/cJSON:=
	dev-libs/libsodium:=
	media-gfx/qrencode
	net-libs/libmicrohttpd:=
	net-libs/webkit-gtk:4.1=
	net-misc/curl
	elibc_musl? ( sys-libs/argp-standalone )"
RDEPEND="${DEPEND}"
BDEPEND="test? ( dev-libs/check )"

RESTRICT="!test? ( test )"

PATCHES=(
	"${FILESDIR}"/${PN}-4.5.0_webkit41.patch
	"${FILESDIR}"/${PN}-4.5.2_install-perms.patch
)

src_prepare() {
	xdg_environment_reset
	default
	sed -i -e 's|^\(\s\+\)@|\1|' Makefile || die "Failed to increase verbosity in Makefile"
}

oidc_emake() {
	local mymakeargs=(
		USE_CJSON_SO=1
		USE_LIST_SO=0
		USE_MUSTACHE_SO=0
		USE_ARGP_SO=$(usex elibc_musl 1 0)
	)

	emake "${mymakeargs[@]}" $@
}

src_compile() {
	oidc_emake -j1 create_obj_dir_structure create_picobj_dir_structure # Bug #880157
	oidc_emake
}

src_install() {
	oidc_emake \
		PREFIX="${ED}" \
		BIN_AFTER_INST_PATH="/usr" \
		INCLUDE_PATH="${ED}"/usr/include \
		LIB_PATH="${ED}"/usr/$(get_libdir) \
		install

	# This file is not compatible with Gentoo and in any case, we generally
	# let the users load such agents themselves.
	rm -f "${ED}"/etc/X11/Xsession.d/91${PN}
}

pkg_postinst() {
	xdg_desktop_database_update

	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		elog
		elog "You should use oidc-gen to initially generate your account configuration"
		elog "before it can be loaded into oidc-agent using oidc-add. For details, please"
		elog "consult the man page of oidc-gen, or full documentation at"
		elog "    https://indigo-dc.gitbooks.io/oidc-agent/"
		elog
	else
		local new_major_ver old_ver
		new_major_ver=$(ver_cut 1)
		for old_ver in ${REPLACING_VERSIONS}; do
			if [[ $(ver_cut 1 ${old_ver}) != ${new_major_ver} ]]; then
				ewarn
				ewarn "You are upgrading from a different major version. Please restart any running instances of ${PN}"
				ewarn "to make sure they are compatible with the updated clients."
				ewarn
				break
			fi
		done
	fi
}

pkg_postrm() {
	xdg_desktop_database_update
}

# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_OPTIONAL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
VERIFY_SIG_OPENPGP_KEY_PATH="${BROOT}"/usr/share/openpgp-keys/netfilter.org.asc
inherit edo linux-info distutils-r1 systemd verify-sig

DESCRIPTION="Linux kernel firewall, NAT and packet mangling tools"
HOMEPAGE="https://netfilter.org/projects/nftables/"

if [[ ${PV} =~ ^[9]{4,}$ ]]; then
	inherit autotools git-r3
	EGIT_REPO_URI="https://git.netfilter.org/${PN}"
	BDEPEND="sys-devel/bison"
else
	SRC_URI="
		https://netfilter.org/projects/nftables/files/${P}.tar.xz
		verify-sig? ( https://netfilter.org/projects/nftables/files/${P}.tar.xz.sig )
	"
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ia64 ~loong ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86"
	BDEPEND="verify-sig? ( sec-keys/openpgp-keys-netfilter )"
fi

# See COPYING: new code is GPL-2+, existing code is GPL-2
LICENSE="GPL-2 GPL-2+"
SLOT="0/1"
IUSE="debug doc +gmp json libedit python +readline static-libs test xtables"
RESTRICT="!test? ( test )"

RDEPEND="
	>=net-libs/libmnl-1.0.4:=
	>=net-libs/libnftnl-1.2.6:=
	gmp? ( dev-libs/gmp:= )
	json? ( dev-libs/jansson:= )
	python? ( ${PYTHON_DEPS} )
	readline? ( sys-libs/readline:= )
	xtables? ( >=net-firewall/iptables-1.6.1:= )
"
DEPEND="${RDEPEND}"
BDEPEND+="
	sys-devel/flex
	virtual/pkgconfig
	doc? (
		app-text/asciidoc
		>=app-text/docbook2X-0.8.8-r4
	)
	python? ( ${DISTUTILS_DEPS} )
"

REQUIRED_USE="
	python? ( ${PYTHON_REQUIRED_USE} )
	libedit? ( !readline )
"

src_prepare() {
	default

	if [[ ${PV} =~ ^[9]{4,}$ ]] ; then
		eautoreconf
	fi

	if use python; then
		pushd py >/dev/null || die
		distutils-r1_src_prepare
		popd >/dev/null || die
	fi
}

src_configure() {
	local myeconfargs=(
		--sbindir="${EPREFIX}"/sbin
		$(use_enable debug)
		$(use_enable doc man-doc)
		$(use_with !gmp mini_gmp)
		$(use_with json)
		$(use_with libedit cli editline)
		$(use_with readline cli readline)
		$(use_enable static-libs static)
		$(use_with xtables)
	)

	econf "${myeconfargs[@]}"

	if use python; then
		pushd py >/dev/null || die
		distutils-r1_src_configure
		popd >/dev/null || die
	fi
}

src_compile() {
	default

	if use python; then
		pushd py >/dev/null || die
		distutils-r1_src_compile
		popd >/dev/null || die
	fi
}

src_test() {
	emake check

	if [[ ${EUID} == 0 ]]; then
		edo tests/shell/run-tests.sh -v
	else
		ewarn "Skipping shell tests (requires root)"
	fi

	if use python; then
		pushd tests/py >/dev/null || die
		distutils-r1_src_test
		popd >/dev/null || die
	fi
}

python_test() {
	if [[ ${EUID} == 0 ]]; then
		edo "${EPYTHON}" nft-test.py
	else
		ewarn "Skipping Python tests (requires root)"
	fi
}

src_install() {
	default

	if ! use doc && [[ ! ${PV} =~ ^[9]{4,}$ ]]; then
		pushd doc >/dev/null || die
		doman *.?
		popd >/dev/null || die
	fi

	# Do it here instead of in src_prepare to avoid eautoreconf
	# rmdir lets us catch if more files end up installed in /etc/nftables
	dodir /usr/share/doc/${PF}/skels/
	mv "${ED}"/etc/nftables/osf "${ED}"/usr/share/doc/${PF}/skels/osf || die
	rmdir "${ED}"/etc/nftables || die

	exeinto /usr/libexec/${PN}
	newexe "${FILESDIR}"/libexec/${PN}-mk.sh ${PN}.sh
	newconfd "${FILESDIR}"/${PN}-mk.confd ${PN}
	newinitd "${FILESDIR}"/${PN}-mk.init-r1 ${PN}
	keepdir /var/lib/nftables

	systemd_dounit "${FILESDIR}"/systemd/${PN}-restore.service

	if use python ; then
		pushd py >/dev/null || die
		distutils-r1_src_install
		popd >/dev/null || die
	fi

	find "${ED}" -type f -name "*.la" -delete || die
}

pkg_preinst() {
	local stderr

	# There's a history of regressions with nftables upgrades. Perform a
	# safety check to help us spot them earlier. For the check to pass, the
	# currently loaded ruleset, if any, must be successfully evaluated by
	# the newly built instance of nft(8).
	if [[ -n ${ROOT} ]] || [[ ! -d /sys/module/nftables ]] || [[ ! -x /sbin/nft ]]; then
		# Either nftables isn't yet in use or nft(8) cannot be executed.
		return
	elif ! stderr=$(umask 177; /sbin/nft -t list ruleset 2>&1 >"${T}"/ruleset.nft); then
		# Report errors induced by trying to list the ruleset but don't
		# treat them as being fatal.
		printf '%s\n' "${stderr}" >&2
	elif [[ ${stderr} == *"is managed by iptables-nft"* ]]; then
		# Rulesets generated by iptables-nft are special in nature and
		# will not always be printed in a way that constitutes a valid
		# syntax for ntf(8). Ignore them.
		return
	elif set -- "${ED}"/usr/lib*/libnftables.so; ! LD_LIBRARY_PATH=${1%/*} "${ED}"/sbin/nft -c -f -- "${T}"/ruleset.nft; then
		eerror "Your currently loaded ruleset cannot be parsed by the newly built instance of"
		eerror "nft. This probably means that there is a regression introduced by v${PV}."
		eerror "(To make the ebuild fail instead of warning, set NFTABLES_ABORT_ON_RELOAD_FAILURE=1.)"
		if [[ -n ${NFTABLES_ABORT_ON_RELOAD_FAILURE} ]] ; then
			die "Aborting because of failed nft reload!"
		fi
	fi
}

pkg_postinst() {
	local save_file
	save_file="${EROOT}"/var/lib/nftables/rules-save

	# In order for the nftables-restore systemd service to start
	# the save_file must exist.
	if [[ ! -f "${save_file}" ]]; then
		( umask 177; touch "${save_file}" )
	elif [[ $(( "$( stat --printf '%05a' "${save_file}" )" & 07177 )) -ne 0 ]]; then
		ewarn "Your system has dangerous permissions for ${save_file}"
		ewarn "It is probably affected by bug #691326."
		ewarn "You may need to fix the permissions of the file. To do so,"
		ewarn "you can run the command in the line below as root."
		ewarn "    'chmod 600 \"${save_file}\"'"
	fi

	if has_version 'sys-apps/systemd'; then
		elog "If you wish to enable the firewall rules on boot (on systemd) you"
		elog "will need to enable the nftables-restore service."
		elog "    'systemctl enable ${PN}-restore.service'"
		elog
		elog "If you are creating firewall rules before the next system restart"
		elog "the nftables-restore service must be manually started in order to"
		elog "save those rules on shutdown."
	fi

	if has_version 'sys-apps/openrc'; then
		elog "If you wish to enable the firewall rules on boot (on openrc) you"
		elog "will need to enable the nftables service."
		elog "    'rc-update add ${PN} default'"
		elog
		elog "If you are creating or updating the firewall rules and wish to save"
		elog "them to be loaded on the next restart, use the \"save\" functionality"
		elog "in the init script."
		elog "    'rc-service ${PN} save'"
	fi
}

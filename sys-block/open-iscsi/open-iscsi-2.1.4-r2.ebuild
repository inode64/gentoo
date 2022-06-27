# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools linux-info flag-o-matic toolchain-funcs udev systemd

DESCRIPTION="A performant, transport independent, multi-platform implementation of RFC3720"
HOMEPAGE="https://www.open-iscsi.com/"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/0.2"
KEYWORDS="~alpha amd64 arm arm64 ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="debug infiniband +tcp rdma systemd"

DEPEND="
	sys-apps/kmod
	sys-block/open-isns:=
	sys-kernel/linux-headers
	infiniband? ( sys-cluster/rdma-core )
	dev-libs/openssl:0=
	systemd? ( sys-apps/systemd )
"
RDEPEND="${DEPEND}
	sys-fs/lsscsi
	sys-apps/util-linux"
BDEPEND="virtual/pkgconfig"

REQUIRED_USE="infiniband? ( rdma ) || ( rdma tcp )"

PATCHES=(
	"${FILESDIR}/${PN}-2.1.1-Makefiles.patch"
)

pkg_setup() {
	linux-info_pkg_setup

	if kernel_is -lt 2 6 16; then
		die "Sorry, your kernel must be 2.6.16-rc5 or newer!"
	fi

	# Needs to be done, as iscsid currently only starts, when having the iSCSI
	# support loaded as module. Kernel builtin options don't work. See this for
	# more information:
	# https://groups.google.com/group/open-iscsi/browse_thread/thread/cc10498655b40507/fd6a4ba0c8e91966
	# If there's a new release, check whether this is still valid!
	TCP_MODULES="SCSI_ISCSI_ATTRS ISCSI_TCP"
	RDMA_MODULES="INFINIBAND_ISER"
	INFINIBAND_MODULES="INFINIBAND_IPOIB INIBAND_USER_MAD INFINIBAND_USER_ACCESS"
	CONFIG_CHECK_MODULES="tcp? ( ${TCP_MODULES} ) rdma? ( ${RDMA_MODULES} ) infiniband? ( ${INFINIBAND_MODULES} )"
	if linux_config_exists; then
		if use tcp; then
			for module in ${TCP_MODULES}; do
				linux_chkconfig_module ${module} || ewarn "${module} needs to be built as module (builtin doesn't work)"
		done
		fi
		if use infiniband; then
			for module in ${INFINIBAND_MODULES}; do
				linux_chkconfig_module ${module} || ewarn "${module} needs to be built as module (builtin doesn't work)"
		done
		fi
		if use rdma; then
			for module in ${RDMA_MODULES}; do
				linux_chkconfig_module ${module} || ewarn "${module} needs to be built as module (builtin doesn't work)"$
			done
		fi
	fi
}

src_prepare() {
	sed -e 's:^\(iscsid.startup\)\s*=.*:\1 = /usr/sbin/iscsid:' \
		-i etc/iscsid.conf || die
	sed -e '/[^usr]\/sbin/s@\(/sbin/\)@/usr\1@' \
		-i etc/systemd/iscsi* || die
	default

	pushd iscsiuio >/dev/null || die
	eautoreconf
	popd >/dev/null || die
}

src_configure() {
	use debug && append-cppflags -DDEBUG_TCP -DDEBUG_SCSI
	append-lfs-flags
}

src_compile() {
	# Stuffing CPPFLAGS into CFLAGS isn't entirely correct, but the build
	# is messed up already here, so it's not making it that much worse.
	KSRC="${KV_DIR}" CFLAGS="" \
	emake \
		OPTFLAGS="${CFLAGS} ${CPPFLAGS} $(usex systemd '' -DNO_SYSTEMD)" \
		AR="$(tc-getAR)" CC="$(tc-getCC)" \
		$(usex systemd '' NO_SYSTEMD=1) \
		user
}

src_install() {
	emake DESTDIR="${ED}" sbindir="/usr/sbin" install
	# Upstream make is not deterministic, per bug #601514
	rm -f "${ED}"/etc/initiatorname.iscsi

	dodoc README THANKS

	docinto test/
	dodoc $(find test -maxdepth 1 -type f ! -name ".*")

	insinto /etc/iscsi
	newins "${FILESDIR}"/initiatorname.iscsi initiatorname.iscsi.example

	newconfd "${FILESDIR}"/iscsid-conf.d iscsid
	newinitd "${FILESDIR}"/iscsid-init.d iscsid

	local unit
	local units=(
		iscsi{,-init}.service
		iscsid.{service,socket}
		iscsiuio.{service,socket}
	)
	for unit in ${units[@]} ; do
		systemd_dounit etc/systemd/${unit}
	done

	keepdir /var/db/iscsi
	fperms 700 /var/db/iscsi
	fperms 600 /etc/iscsi/iscsid.conf
}

pkg_postinst() {
	in='/etc/iscsi/initiatorname.iscsi'
	if [[ ! -f "${EROOT}${in}" ]] && [[ -f "${EROOT}${in}.example" ]] ; then
		{
		  cat "${EROOT}${in}.example"
		  echo "# InitiatorName generated by ${CATEGORY}/${PF} at $(date -uR)"
		  echo "InitiatorName=$(${ROOT}/usr/sbin/iscsi-iname)"
		} >> "${EROOT}${in}.tmp" && mv -f "${EROOT}${in}.tmp" "${EROOT}${in}"
	fi
}

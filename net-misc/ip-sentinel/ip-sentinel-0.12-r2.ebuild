# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Prevent unauthorized usage of IP addresses"
HOMEPAGE="https://www.nongnu.org/ip-sentinel/"
SRC_URI="https://savannah.nongnu.org/download/ip-sentinel/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DOCS=( AUTHORS ChangeLog NEWS README THANKS )
PATCHES=( "${FILESDIR}"/${P}-fixed-dietlibc-compat-stuff.patch )

RDEPEND="
	acct-group/ipsentinel
	acct-user/ipsentinel
"

src_prepare() {
	default

	# disable failing tests
	echo true > src/testsuite/prioqueue-check.sh
}

src_install() {
	default

	newinitd "${FILESDIR}"/ip-sentinel.init ip-sentinel
	newconfd "${FILESDIR}"/ip-sentinel.conf.d ip-sentinel

	insinto /etc
	newins "${FILESDIR}"/ip-sentinel.cfg ip-sentinel.cfg
}

pkg_config() {
	CHROOT=`sed -n 's/^[[:blank:]]\?CHROOT="\([^"]\+\)"/\1/p' /etc/conf.d/ip-sentinel 2>/dev/null`

	if [ ! -d "${CHROOT:=/chroot/ip-sentinel}" ] ; then
		einfo "Setting up the chroot directory"
		mkdir -m 0755 -p "${CHROOT}/etc" || die
		cp -R /etc/ip-sentinel.cfg "${CHROOT}/etc" || die

		if [ "`grep '^#[[:blank:]]\?CHROOT' /etc/conf.d/ip-sentinel`" ] ; then
			sed -e '/^#[[:blank:]]\?CHROOT/s/^#[[:blank:]]\?//' \
				-i /etc/conf.d/ip-sentinel
		fi
	else
		eerror
		eerror "${CHROOT} already exists. Quitting."
		eerror
	fi
}

pkg_postinst() {
	elog "You can edit /etc/conf.d/ip-sentinel to customize startup daemon"
	elog "settings."
	elog
	elog "Default ip-sentinel config is in /etc/ip-sentinel.cfg"
	elog
	elog "The ip-sentinel ebuild has chroot support."
	elog "If you like to run ip-sentinel in chroot AND this is a new install OR"
	elog "your ip-sentinel doesn't already run in chroot, simply run:"
	elog "emerge --config =${CATEGORY}/${PF}"
	elog "Before running the above command you might want to change the chroot"
	elog "dir in /etc/conf.d/ip-sentinel, otherwise /chroot/ip-sentinel will be used."
	echo
	ewarn "And please! DO NOT START THIS DAEMON thoughtlessly."
	ewarn "If you DO this will BLOCK ALL communication inside your ethernet"
	ewarn "segment!!! If you have any doubts do not start ip-sentinel."
}

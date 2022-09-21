# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GENTOO_PATCH=2

DESCRIPTION="A somewhat comprehensive collection of Linux man pages"
HOMEPAGE="https://www.kernel.org/doc/man-pages/"
if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git"
	inherit git-r3
elif [[ ${PV} == *_rc* ]] ; then
	MY_P=${PN}-${PV/_/-}

	SRC_URI="https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/snapshot/${MY_P}.tar.gz"
	S="${WORKDIR}"/${MY_P}
else
	SRC_URI="
		https://www.kernel.org/pub/linux/docs/man-pages/Archive/${P}.tar.xz
		https://www.kernel.org/pub/linux/docs/man-pages/${P}.tar.xz
	"

	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux"
fi

SRC_URI+="
	mirror://gentoo/man-pages-gentoo-${GENTOO_PATCH}.tar.bz2
	https://dev.gentoo.org/~cardoe/files/man-pages-gentoo-${GENTOO_PATCH}.tar.bz2
"

LICENSE="man-pages GPL-2+ BSD"
SLOT="0"
IUSE_L10N=" de es fr it ja nl pl pt-BR ro ru zh-CN"
IUSE="${IUSE_L10N// / l10n_}"
RESTRICT="binchecks"

# Block packages that used to install colliding man pages:
# bug #341953, bug #548900, bug #612640, bug #617462
RDEPEND="
	virtual/man
	!<sys-apps/keyutils-1.5.9-r4
	!<dev-libs/libbsd-0.8.3-r1
"
PDEPEND="
	l10n_de? ( app-i18n/man-pages-l10n[l10n_de(-)] )
	l10n_es? ( app-i18n/man-pages-l10n[l10n_es(-)] )
	l10n_fr? ( app-i18n/man-pages-l10n[l10n_fr(-)] )
	l10n_it? ( app-i18n/man-pages-l10n[l10n_it(-)] )
	l10n_ja? ( app-i18n/man-pages-ja )
	l10n_nl? ( app-i18n/man-pages-l10n[l10n_nl(-)] )
	l10n_pl? ( app-i18n/man-pages-l10n[l10n_pl(-)] )
	l10n_pt-BR? ( app-i18n/man-pages-l10n[l10n_pt-BR(-)] )
	l10n_ro? ( app-i18n/man-pages-l10n[l10n_ro(-)] )
	l10n_ru? ( app-i18n/man-pages-ru )
	l10n_zh-CN? ( app-i18n/man-pages-zh_CN )
"

src_unpack() {
	default

	[[ ${PV} == 9999 ]] && git-r3_src_unpack
}

src_prepare() {
	default

	# passwd.5 installed by sys-apps/shadow, bug #776787
	rm man5/passwd.5 || die
}

src_compile() { :; }

src_install() {
	emake install prefix="${EPREFIX}"/usr DESTDIR="${D}"
	dodoc man-pages-*.Announce README Changes*

	# Override with Gentoo specific or additional Gentoo pages
	cd "${WORKDIR}"/man-pages-gentoo || die
	doman */*
	dodoc README.Gentoo
}

pkg_postinst() {
	for ver in ${REPLACING_VERSIONS} ; do
		if ver_test ${ver} -lt 5.13-r2 ; then
			# Avoid ACCEPT_LICENSE issues for users by default
			# bug #871636
			ewarn "This version of ${PN} no longer depends on sys-apps/man-pages-posix!"
			ewarn "Please install sys-apps/man-pages-posix yourself if needed."
			break
		fi
	done
}

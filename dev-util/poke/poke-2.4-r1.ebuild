# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit elisp-common flag-o-matic

DESCRIPTION="Extensible editor for structured binary data"
HOMEPAGE="https://www.jemarch.net/poke"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.savannah.gnu.org/git/poke.git"
	REGEN_BDEPEND="
		>=sys-devel/autoconf-2.62
		>=sys-devel/automake-2.16
		sys-apps/gawk
		sys-apps/help2man
		sys-apps/texinfo
		sys-devel/bison
		sys-devel/flex
	"
else
	SRC_URI="mirror://gnu/poke/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	REGEN_BDEPEND=""
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE="emacs pvm-profiling nbd nls test"

RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/boehm-gc:=
	dev-libs/libatomic_ops
	sys-devel/gettext
	sys-libs/readline:=
	emacs? ( >=app-editors/emacs-23.1:* )
	nbd? ( sys-libs/libnbd )
"
DEPEND="
	${RDEPEND}
	test? ( nbd? ( sys-libs/libnbd[uri-support(+)] ) )
"
BDEPEND="
	${REGEN_BDEPEND}
	virtual/pkgconfig
	emacs? ( >=app-editors/emacs-23.1:* )
	test? (
		dev-util/dejagnu
		nbd? ( sys-block/nbdkit )
	)
"

SITEFILE="50${PN}-gentoo.el"

pkg_setup() {
	use emacs && elisp-check-emacs-version
}

src_prepare() {
	default

	if [[ ${PV} == 9999 ]]; then
		./bootstrap || die
	fi
}

src_configure() {
	# See bug 858461.
	# Upstream support might happen one day.  For context, only one file needs
	# LTO to be disabled (since it's an autogenerated bytecode interpreter),
	# others do not.  The build system will handle this at some point in the
	# future.  Until then, just filter out LTO.
	filter-lto

	# NB --disable-{gui,mi}:
	# These (AFAICT) have no consumers in Gentoo, and should not get any,
	# preferably. They are slated for removal with Poke 3 (should happen
	# towards the end of the year, possibly), so they should not be relied
	# upon.
	local myconf=(
		--with-lispdir="${EPREFIX}/${SITELISP}/${PN}"
		--enable-hserver
		--disable-gui
		--disable-mi
		$(use_enable nbd libnbd)
		$(use_enable pvm-profiling)
		$(use_enable nls)
	)

	econf "${myconf[@]}"
}

src_compile() {
	default

	if use emacs; then
		cd etc || die
		elisp-compile *.el
	fi
}

src_install() {
	default

	if use emacs; then
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
		cd etc || die
		elisp-install "${PN}" *.el *.elc
	fi
	find "${ED}" -name '*.la' -delete || die
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}

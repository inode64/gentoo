# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic font optfeature pam strip-linguas

DESCRIPTION="Modular screen saver and locker for the X Window System"
HOMEPAGE="https://www.jwz.org/xscreensaver/"
SRC_URI="https://www.jwz.org/xscreensaver/${P}.tar.gz"

# Font license mapping for folder ./hacks/fonts/ as following:
#   clacon.ttf       -- MIT
#   gallant12x22.ttf -- unclear, hence dropped
#   luximr.ttf       -- bh-luxi (package media-fonts/font-bh-ttf)
#   OCRAStd.otf      -- unclear, hence dropped
#   SpecialElite.ttf -- Apache-2.0
LICENSE="BSD fonts? ( MIT Apache-2.0 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="elogind fonts +gdk-pixbuf gdm gles glx +gtk jpeg +locking new-login offensive opengl pam +perl +png selinux suid systemd +xft xinerama"
REQUIRED_USE="
	gdk-pixbuf? ( gtk )
	gles? ( !glx opengl )
	glx? ( opengl )
	gtk? ( png )
	opengl? ( png )
	?? ( elogind systemd )
"

COMMON_DEPEND="
	dev-libs/libxml2
	x11-apps/appres
	x11-apps/xwininfo
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXt
	x11-libs/libXxf86vm
	elogind? ( sys-auth/elogind )
	gdk-pixbuf? (
		x11-libs/gdk-pixbuf-xlib
		>=x11-libs/gdk-pixbuf-2.42.0:2
	)
	gtk? ( x11-libs/gtk+:2 )
	jpeg? ( media-libs/libjpeg-turbo:= )
	locking? ( virtual/libcrypt:= )
	new-login? (
		gdm? ( gnome-base/gdm )
		!gdm? ( || ( x11-misc/lightdm lxde-base/lxdm ) )
	)
	opengl? (
		virtual/glu
		virtual/opengl
	)
	pam? ( sys-libs/pam )
	png? ( media-libs/libpng:= )
	systemd? ( >=sys-apps/systemd-221 )
	xft? ( x11-libs/libXft )
	xinerama? ( x11-libs/libXinerama )
"
# For USE="perl" see output of `qlist xscreensaver | grep bin | xargs grep '::'`
RDEPEND="
	${COMMON_DEPEND}
	media-gfx/fbida
	perl? (
		dev-lang/perl
		dev-perl/libwww-perl
		virtual/perl-Digest-MD5
	)
	selinux? ( sec-policy/selinux-xscreensaver )
"
DEPEND="
	${COMMON_DEPEND}
	x11-base/xorg-proto
"
BDEPEND="
	dev-util/intltool
	sys-devel/bc
	sys-devel/gettext
	virtual/pkgconfig
"
PATCHES=(
	"${FILESDIR}"/${PN}-6.01-interix.patch
	"${FILESDIR}"/${PN}-5.31-pragma.patch
	"${FILESDIR}"/${PN}-6.01-gentoo.patch
	"${FILESDIR}"/${PN}-5.45-gcc.patch
	"${FILESDIR}"/${PN}-6.01-configure.ac-sandbox.patch
	"${FILESDIR}"/${PN}-6.01-without-gl-makefile.patch
	"${FILESDIR}"/${PN}-6.01-non-gtk-install.patch
	"${FILESDIR}"/${PN}-6.01-gtk-detection.patch
	"${FILESDIR}"/${PN}-6.01-configure-install_sh.patch
	"${FILESDIR}"/${PN}-6.03-without-gl-configure.patch
)

DOCS=( README{,.hacking} )

src_prepare() {
	default

	sed -i configure.ac -e '/^ALL_LINGUAS=/d' || die
	strip-linguas -i po/
	export ALL_LINGUAS="${LINGUAS}"

	if use new-login && ! use gdm; then #392967
		sed -i \
			-e "/default_l.*1/s:gdmflexiserver -ls:${EPREFIX}/usr/libexec/lightdm/&:" \
			configure{,.ac} || die
	fi

	# We are patching driver/XScreenSaver.ad.in, so let's delete the
	# header generated from it so that it gets back in sync during build:
	rm driver/XScreenSaver_ad.h || die

	if ! use offensive; then
		sed -i \
			-e '/boobies/d;/boobs/d;/cock/d;/pussy/d;/viagra/d;/vibrator/d' \
			hacks/barcode.c || die
		sed -i \
			-e 's|erect penis|shuffle board|g' \
			-e 's|flaccid penis|flaccid anchor|g' \
			-e 's|vagina|engagement ring|g' \
			-e 's|Penis|Shuttle|g' \
			hacks/glx/glsnake.c || die
		sed -i \
			's| Stay.*fucking mask\.$||' \
			hacks/glx/covid19.man \
			hacks/config/covid19.xml || die
	fi

	config_rpath_update "${S}"/config.rpath

	# Must be eauto*re*conf, to force the rebuild
	eautoreconf
}

src_configure() {
	if use ppc || use ppc64; then
		filter-flags -maltivec -mabi=altivec
		append-flags -U__VEC__
	fi

	unset BC_ENV_ARGS #24568

	# Works similarly to -Werror,
	# https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wimplicit-function-declaration
	filter-flags -pedantic-errors

	# /proc/interrupts won't always have the keyboard bits needed
	# Not clear this does anything in 6.03+(?) but let's keep it for now in case.
	# (See also: configure argument)
	export ac_cv_have_proc_interrupts=yes

	# WARNING: This is NOT a normal autoconf script
	# Some of the --with options are NOT standard, and expect "--with-X=no" rather than "--without-X"
	ECONF_OPTS=(
		$(use_enable locking)
		$(use_with elogind)
		$(use_with gdk-pixbuf pixbuf)
		$(use_with gles)
		$(use_with glx)
		$(use_with gtk)
		$(use_with new-login login-manager)
		$(use_with opengl gl)
		$(use_with pam)
		$(use_with suid setuid-hacks)
		$(use_with systemd)
		$(use_with xinerama xinerama-ext)
		--with-jpeg=$(usex jpeg yes no)
		--with-png=$(usex png yes no)
		--with-xft=$(usex xft yes no)
		--with-app-defaults="${EPREFIX}"/usr/share/X11/app-defaults
		--with-configdir="${EPREFIX}"/usr/share/${PN}/config
		--with-dpms-ext
		--with-hackdir="${EPREFIX}"/usr/$(get_libdir)/misc/${PN}
		--with-proc-interrupts
		--with-randr-ext
		--with-text-file="${EPREFIX}"/etc/gentoo-release
		--with-xdbe-ext
		--with-xf86gamma-ext
		--with-xf86vmode-ext
		--with-xinput-ext
		--with-xkb-ext
		--with-xshm-ext
		--without-gle
		--without-kerberos
		--without-motif
		--with-proc-oom
		--x-includes="${EPREFIX}"/usr/include
		--x-libraries="${EPREFIX}"/usr/$(get_libdir)
	)
	# WARNING: This is NOT a normal autoconf script
	econf "${ECONF_OPTS[@]}"
}

src_compile() {
	# stock target is "default", which is broken in some releases.
	emake all
}

src_install() {
	use pam && dodir /etc/pam.d/
	emake install_prefix="${D}" DESTDIR="${D}" install

	if use fonts; then
		# Do not install fonts with unclear licensing
		rm -v "${ED}${FONTDIR}"/{gallant12x22.ttf,OCRAStd.otf} || die

		# Do not duplicate font Luxi Mono (of package media-fonts/font-bh-ttf)
		rm -v "${ED}${FONTDIR}"/luximr.ttf || die

		font_xfont_config
	else
		rm -v "${ED}${FONTDIR}"/*.{ttf,otf} || die
		rmdir -v "${ED}${FONTDIR}" || die #812473
	fi

	einstalldocs

	if use pam; then
		fperms 755 /usr/bin/${PN}
		pamd_mimic_system ${PN} auth
	fi

	# bugs #809599, #828869
	if ! use gtk; then
		rm "${ED}/usr/bin/xscreensaver-demo" || die
	fi
}

pkg_postinst() {
	use fonts && font_pkg_postinst

	# bug #811885
	if ! use glx && use opengl; then
		elog "Enable USE='glx' if OpenGL screensavers are crashing."
	fi

	optfeature 'Bitmap fonts 75dpi' media-fonts/font-adobe-75dpi
	optfeature 'Bitmap fonts 100dpi' media-fonts/font-adobe-100dpi
	optfeature 'Truetype font Luxi Mono' media-fonts/font-bh-ttf
}

pkg_postrm() {
	use fonts && font_pkg_postrm
}

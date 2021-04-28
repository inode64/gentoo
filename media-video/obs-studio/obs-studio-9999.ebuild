# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_REMOVE_MODULES_LIST=( FindFreetype )
LUA_COMPAT=( luajit )
PYTHON_COMPAT=( python3_{7..9} )

inherit cmake lua-single python-single-r1 xdg-utils

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/obsproject/obs-studio.git"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/obsproject/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~ppc64 ~x86"
fi

DESCRIPTION="Software for Recording and Streaming Live Video Content"
HOMEPAGE="https://obsproject.com"

LICENSE="GPL-2"
SLOT="0"
IUSE="+alsa decklink fdk imagemagick jack lua nvenc pipewire pulseaudio python speex +ssl truetype v4l vlc wayland"
REQUIRED_USE="
	lua? ( ${LUA_REQUIRED_USE} )
	python? ( ${PYTHON_REQUIRED_USE} )
"

BDEPEND="
	lua? ( dev-lang/swig )
	python? ( dev-lang/swig )
"
DEPEND="
	>=dev-libs/jansson-2.5
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5[wayland?]
	dev-qt/qtmultimedia:5
	dev-qt/qtnetwork:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	dev-qt/qtxml:5
	media-libs/x264:=
	media-video/ffmpeg:=[x264]
	net-misc/curl
	sys-apps/dbus
	sys-libs/zlib
	virtual/udev
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXfixes
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libxcb
	alsa? ( media-libs/alsa-lib )
	fdk? ( media-libs/fdk-aac:= )
	imagemagick? ( media-gfx/imagemagick:= )
	jack? ( virtual/jack )
	lua? ( ${LUA_DEPS} )
	nvenc? ( >=media-video/ffmpeg-4[video_cards_nvidia] )
	pipewire? ( media-video/pipewire )
	pulseaudio? ( media-sound/pulseaudio )
	python? ( ${PYTHON_DEPS} )
	speex? ( media-libs/speexdsp )
	ssl? ( net-libs/mbedtls:= )
	truetype? (
		media-libs/fontconfig
		media-libs/freetype
	)
	v4l? ( media-libs/libv4l )
	vlc? ( media-video/vlc:= )
	wayland? ( dev-libs/wayland )
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-26.1.2-python-3.8.patch" ) # https://github.com/obsproject/obs-studio/pull/3335

pkg_setup() {
	use lua && lua-single_pkg_setup
	use python && python-single-r1_pkg_setup
}

src_configure() {
	local libdir=$(get_libdir)
	local mycmakeargs=(
		-DBUILD_BROWSER=no
		-DBUILD_VST=no
		-DENABLE_WAYLAND=$(usex wayland)
		-DDISABLE_ALSA=$(usex !alsa)
		-DDISABLE_DECKLINK=$(usex !decklink)
		-DDISABLE_FREETYPE=$(usex !truetype)
		-DDISABLE_JACK=$(usex !jack)
		-DDISABLE_LIBFDK=$(usex !fdk)
		-DENABLE_PIPEWIRE=$(usex pipewire)
		-DDISABLE_PULSEAUDIO=$(usex !pulseaudio)
		-DDISABLE_SPEEXDSP=$(usex !speex)
		-DDISABLE_V4L2=$(usex !v4l)
		-DDISABLE_VLC=$(usex !vlc)
		-DLIBOBS_PREFER_IMAGEMAGICK=$(usex imagemagick)
		-DOBS_MULTIARCH_SUFFIX=${libdir#lib}
		-DUNIX_STRUCTURE=1
		-DWITH_RTMPS=$(usex ssl)
	)

	if [[ ${PV} != *9999 ]]; then
		mycmakeargs+=(
			-DOBS_VERSION_OVERRIDE=${PV}
		)
	fi

	if use lua || use python; then
		mycmakeargs+=(
			-DDISABLE_LUA=$(usex !lua)
			-DDISABLE_PYTHON=$(usex !python)
			-DENABLE_SCRIPTING=yes
		)
	else
		mycmakeargs+=( -DENABLE_SCRIPTING=no )
	fi

	cmake_src_configure
}

src_install() {
	cmake_src_install
	#external plugins may need some things not installed by default, install them here
	insinto /usr/include/obs/UI/obs-frontend-api
	doins UI/obs-frontend-api/obs-frontend-api.h
}

pkg_postinst() {
	xdg_icon_cache_update

	if ! use alsa && ! use pulseaudio; then
		elog
		elog "For the audio capture features to be available,"
		elog "either the 'alsa' or the 'pulseaudio' USE-flag needs to"
		elog "be enabled."
		elog
	fi

	if ! has_version "sys-apps/dbus"; then
		elog
		elog "The 'sys-apps/dbus' package is not installed, but"
		elog "could be used for disabling hibernating, screensaving,"
		elog "and sleeping.  Where it is not installed,"
		elog "'xdg-screensaver reset' is used instead"
		elog "(if 'x11-misc/xdg-utils' is installed)."
		elog
	fi
}

pkg_postinst() {
	if use python; then
		ewarn "This ebuild applies a patch that is not yet accepted upstream,"
		ewarn "and while it fixes Python support at least to some extent, it"
		ewarn "may cause other issues."
		ewarn ""
		ewarn "Please report any such issues to the Gentoo maintainer."
	fi
}

pkg_postrm() {
	xdg_icon_cache_update
}

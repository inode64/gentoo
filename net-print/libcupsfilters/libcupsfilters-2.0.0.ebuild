# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="library for developing printing features, split out of cups-filters"
HOMEPAGE="https://github.com/OpenPrinting/libcupsfilters"
SRC_URI="https://github.com/OpenPrinting/libcupsfilters/releases/download/${PV}/${P}.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="dbus exif jpeg pdf +poppler +postscript png test tiff"
KEYWORDS="~amd64"

RESTRICT="!test? ( test )"

RDEPEND="
	>=app-text/qpdf-8.3.0:=
	media-libs/fontconfig
	media-libs/lcms:2
	>=net-print/cups-2
	!<net-print/cups-filters-2.0.0

	exif? ( media-libs/libexif )
	dbus? ( sys-apps/dbus )
	jpeg? ( media-libs/libjpeg-turbo:= )
	poppler? ( >=app-text/poppler-0.32[cxx] )
	png? ( media-libs/libpng:= )
	tiff? ( media-libs/tiff:= )
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=sys-devel/gettext-0.18.3
	virtual/pkgconfig
	test? ( media-fonts/dejavu )
"

src_configure() {
	local myeconfargs=(
		--enable-imagefilters
		--localstatedir="${EPREFIX}"/var
		--with-cups-rundir="${EPREFIX}"/run/cups

		$(use_enable exif)
		$(use_enable dbus)
		$(use_enable poppler)
		$(use_enable postscript)
		$(use_enable pdf mutool)
		$(use_with jpeg)
		$(use_with png)
		$(use_with tiff)
	)

	econf "${myeconfargs[@]}"
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}

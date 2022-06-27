# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Perl script for renaming and tagging mp3s"
HOMEPAGE="http://freshmeat.net/projects/smartagger/"
SRC_URI="http://freshmeat.net/redir/smartagger/9680/url_tgz/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

RDEPEND="
	dev-lang/perl
	dev-perl/MP3-Info"

PATCHES=( "${FILESDIR}"/${P}-gentoo.patch )

src_install() {
	dobin SmarTagger
	dosym SmarTagger /usr/bin/smartagger
	dodoc changelog README TODO
	newdoc album.id3 example.id3
}

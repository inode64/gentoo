# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit elisp

DESCRIPTION="Complaint generator for GNU Emacs"
HOMEPAGE="https://www.emacswiki.org/emacs/Whine"
SRC_URI="https://dev.gentoo.org/~ulm/distfiles/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

SITEFILE="50${PN}-gentoo.el"
DOCS="README.orig"

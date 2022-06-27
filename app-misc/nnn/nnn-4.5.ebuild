# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 flag-o-matic toolchain-funcs xdg-utils

DESCRIPTION="The missing terminal file browser for X"
HOMEPAGE="https://github.com/jarun/nnn"
SRC_URI="https://github.com/jarun/nnn/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

DEPEND="sys-libs/ncurses:=
	sys-libs/readline:=
	elibc_musl? ( sys-libs/fts-standalone )"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	tc-export CC
	use elibc_musl && append-flags "-lfts"
	sed -i -e '/install: all/install:/' Makefile || die "sed failed"
}

src_install() {
	emake PREFIX="${EPREFIX}/usr" DESTDIR="${D}" install

	emake PREFIX="${EPREFIX}/usr" DESTDIR="${D}" install-desktop

	newbashcomp misc/auto-completion/bash/nnn-completion.bash nnn

	insinto /usr/share/fish/vendor_completions.d
	doins misc/auto-completion/fish/nnn.fish

	insinto /usr/share/zsh/site-functions
	doins misc/auto-completion/zsh/_nnn

	einstalldocs
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}

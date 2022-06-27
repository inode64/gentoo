# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
USE_RUBY="ruby26 ruby27 ruby30 ruby31"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_BINWRAP=""
RUBY_FAKEGEM_GEMSPEC="tty-cursor.gemspec"

inherit ruby-fakegem

DESCRIPTION="Move the terminal cursor around and manipulate text using intuitive method calls"
HOMEPAGE="https://github.com/piotrmurach/tty-cursor"
SRC_URI="https://github.com/piotrmurach/tty-cursor/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~arm64 ~hppa ~loong ~ppc ~ppc64 ~riscv ~sparc ~x86"
IUSE=""

all_ruby_prepare() {
	echo '-rspec_helper' > .rspec || die

	sed -i -e 's:require_relative ":require "./:' ${RUBY_FAKEGEM_GEMSPEC} || die
}

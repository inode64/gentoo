# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby30 ruby31 ruby32"

RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_BINWRAP=""

RUBY_FAKEGEM_GEMSPEC="rqrcode.gemspec"

inherit ruby-fakegem

DESCRIPTION="Library for encoding QR Codes"
HOMEPAGE="https://whomwah.com/rqrcode/"
SRC_URI="https://github.com/whomwah/rqrcode/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "
	dev-ruby/chunky_png:0
	dev-ruby/rqrcode_core:1
"

all_ruby_prepare() {
	sed -i -e 's/git ls-files -z/find * -print0/' ${RUBY_FAKEGEM_GEMSPEC} || die
	sed -i -e '/bundler/ s:^:#:' spec/spec_helper.rb || die

	sed -i -e "s:/tmp:${TMPDIR}:" spec/rqrcode/export_png_spec.rb || die
}

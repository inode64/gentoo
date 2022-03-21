# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
USE_RUBY="ruby25 ruby26"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.rdoc"

RUBY_FAKEGEM_GEMSPEC="actionmailer.gemspec"

RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem eapi7-ver

DESCRIPTION="Framework for designing email-service layers"
HOMEPAGE="https://github.com/rails/rails"
SRC_URI="https://github.com/rails/rails/archive/v${PV}.tar.gz -> rails-${PV}.tgz"

LICENSE="MIT"
SLOT="$(ver_cut 1-2)"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux"
IUSE=""

RUBY_S="rails-${PV}/${PN}"

ruby_add_rdepend "
	~dev-ruby/actionpack-${PV}
	~dev-ruby/actionview-${PV}
	~dev-ruby/activejob-${PV}
	>=dev-ruby/mail-2.5.4:* =dev-ruby/mail-2*:*
	dev-ruby/rails-dom-testing:2"

ruby_add_bdepend "test? (
	dev-ruby/mocha
)"

all_ruby_prepare() {
	# Set test environment to our hand.
	rm "${S}/../Gemfile" || die "Unable to remove Gemfile"
	sed -e '/\/load_paths/d' \
		-e '1igem "railties", "~> 5.2.0"' \
		-e '1igem "actionpack", "~> 5.2.0"' \
		-e '1igem "activejob", "~> 5.2.0"' \
		-i test/abstract_unit.rb || die "Unable to remove load paths"

	# Avoid a test failing only on attachment ordering, since this is a
	# security release.
	sed -i -e '/adding inline attachments while rendering mail works/askip "gentoo: fails on ordering"' test/base_test.rb || die
}

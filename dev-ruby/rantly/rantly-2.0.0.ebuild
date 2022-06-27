# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
USE_RUBY="ruby26 ruby27 ruby30 ruby31"

RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Ruby Imperative Random Data Generator and Quickcheck"
HOMEPAGE="https://github.com/rantly-rb/rantly"

LICENSE="MIT"
SLOT="$(ver_cut 1)"
KEYWORDS="~amd64"
IUSE=""

all_ruby_prepare() {
	sed -i -e '/simplecov/,/^end/ s:^:#:' test/test_helper.rb || die
}

each_ruby_test() {
	${RUBY} -Ilib:test:. -e 'Dir["test/**/*_test.rb"].each{|f| require f}' || die
}

# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby31 ruby32"

RUBY_FAKEGEM_BINWRAP=""
RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_EXTRAINSTALL="assets"

inherit ruby-fakegem

DESCRIPTION="HTML formatter for Cucumber"
HOMEPAGE="https://cucumber.io/"
LICENSE="Ruby"

KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~loong ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
SLOT="$(ver_cut 1)"
IUSE="test"

ruby_add_rdepend "
	>=dev-util/cucumber-messages-18.0.0:18
	!<dev-util/cucumber-html-formatter-17.0.0-r1
"

ruby_add_bdepend "
	test? ( >=dev-util/cucumber-compatibility-kit-9.2.0:9 )
"

all_ruby_prepare() {
	sed -i -e '1igem "cucumber-messages", "~>18.0"' spec/html_formatter_spec.rb || die
}

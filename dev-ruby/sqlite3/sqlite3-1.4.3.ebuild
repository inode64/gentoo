# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby26 ruby27 ruby30 ruby31"

RUBY_FAKEGEM_TASK_DOC="faq"
RUBY_FAKEGEM_DOCDIR="doc faq"
RUBY_FAKEGEM_EXTRADOC="API_CHANGES.rdoc README.rdoc ChangeLog.cvs CHANGELOG.rdoc"

RUBY_FAKEGEM_EXTENSIONS=(ext/sqlite3/extconf.rb)
RUBY_FAKEGEM_EXTENSION_LIBDIR=lib/sqlite3

inherit ruby-fakegem

DESCRIPTION="An extension library to access a SQLite database from Ruby"
HOMEPAGE="https://github.com/sparklemotion/sqlite3-ruby"
LICENSE="BSD"

KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~riscv ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
SLOT="0"
IUSE=""

RDEPEND+=" >=dev-db/sqlite-3.6.16:3"
DEPEND+=" >=dev-db/sqlite-3.6.16:3"

ruby_add_bdepend "
	dev-ruby/rake-compiler
	doc? ( dev-ruby/rdoc dev-ruby/redcloth )
	test? ( dev-ruby/minitest:5 )"

all_ruby_prepare() {
	# We remove the vendor_sqlite3 rake task because it's used to
	# bundle SQlite3 which we definitely don't want.
	rm -f rakelib/vendor_sqlite3.rake || die

	# Remove gem tasks since we don't need them and they require hoe.
	rm -f rakelib/gem.rake || die

	sed -i -e 's:, HOE.spec::' -e '/task :test/d' rakelib/native.rake || die
}

all_ruby_compile() {
	all_fakegem_compile

	if use doc; then
		rdoc --title "${P} Dcoumentation" -o doc --main README.rdoc lib *.rdoc ext/*/*.c || die
	fi
}

each_ruby_test() {
	${RUBY} -Ilib:test:. -e 'Dir["test/test_*.rb"].each{|f| require f}' || die
}

each_ruby_install() {
	each_fakegem_install

	# sqlite3 was called sqlite3-ruby before, so add a spec file that
	# simply loads sqlite3 to make sure that old projects load correctly
	# we don't even need to create a file to load this: the `require
	# sqlite3` was already part of sqlite3-ruby requirements.
	cat - <<EOF > "${T}/sqlite3-ruby.gemspec"
# generated by ebuild
# ${CATEGORY}/${PF}
Gem::Specification.new do |s|
	s.name = "sqlite3-ruby"
	s.version = "${RUBY_FAKEGEM_VERSION}"
	s.summary = "Fake gem to load sqlite3"
	s.homepage = "${HOMEPAGE}"
	s.specification_version = 3
	s.add_runtime_dependency("${RUBY_FAKEGEM_NAME}", ["= ${RUBY_FAKEGEM_VERSION}"])
end
EOF
	RUBY_FAKEGEM_NAME=sqlite3-ruby \
		RUBY_FAKEGEM_GEMSPEC="${T}/sqlite3-ruby.gemspec" \
		ruby_fakegem_install_gemspec
}

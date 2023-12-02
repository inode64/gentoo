# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 python3_{10..12} )

inherit distutils-r1

DESCRIPTION="PostgreSQL database adapter for Python"
HOMEPAGE="
	https://www.psycopg.org/psycopg3/
	https://github.com/psycopg/psycopg/
	https://pypi.org/project/psycopg/
"
SRC_URI="
	https://github.com/psycopg/psycopg/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"
S=${WORKDIR}/${P}/psycopg

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos"

DEPEND="
	>=dev-db/postgresql-8.1:*
"
RDEPEND="
	${DEPEND}
	>=dev-python/typing-extensions-4.1[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-db/postgresql-8.1[server]
		<dev-python/anyio-4[${PYTHON_USEDEP}]
		dev-python/dnspython[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_test() {
	# tests are lurking in top-level directory
	cd .. || die

	initdb -D "${T}"/pgsql || die
	# TODO: random port
	pg_ctl -w -D "${T}"/pgsql start \
		-o "-h '' -k '${T}'" || die
	createdb -h "${T}" test || die

	local -x PSYCOPG_TEST_DSN="host=${T} dbname=test"
	distutils-r1_src_test

	pg_ctl -w -D "${T}"/pgsql stop || die
}

python_test() {
	local EPYTEST_DESELECT=(
		# tests for the psycopg_pool package
		tests/pool
		# some broken mypy magic
		tests/test_module.py::test_version
		tests/test_module.py::test_version_c
		tests/test_typing.py
		tests/crdb/test_typing.py
		# TODO, relying on undefined ordering in Python?
		tests/test_dns_srv.py::test_srv
	)

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	# leak and timing tests are fragile whereas slow tests are slow
	epytest -p anyio -k "not leak" -m "not timing and not slow"
}

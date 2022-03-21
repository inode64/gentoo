# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# please keep this ebuild at EAPI 7 -- sys-apps/portage dep
EAPI=7

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( pypy3 python3_{8..10} )

inherit distutils-r1

MY_P=${P/-/.}
DESCRIPTION="Additional functions used by other projects by developer jaraco"
HOMEPAGE="https://github.com/jaraco/jaraco.functools"
SRC_URI="mirror://pypi/${PN:0:1}/${PN/-/.}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ~mips ppc ppc64 ~riscv sparc x86 ~x64-macos"

RDEPEND="
	>=dev-python/more-itertools-0.12.0-r1[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/jaraco-classes[${PYTHON_USEDEP}]
	)
"

distutils_enable_sphinx docs \
	">=dev-python/jaraco-packaging-3.2" \
	">=dev-python/rst-linker-1.9"
distutils_enable_tests pytest

src_configure() {
	grep -q 'build-backend = "setuptools' pyproject.toml ||
		die "Upstream changed build-backend, recheck"
	# write a custom pyproject.toml to ease setuptools bootstrap
	cat > pyproject.toml <<-EOF || die
		[build-system]
		requires = ["flit_core >=3.2,<4"]
		build-backend = "flit_core.buildapi"

		[project]
		name = "jaraco.functools"
		version = "${PV}"
		description = "Functools like those found in stdlib"
	EOF
}

python_install() {
	distutils-r1_python_install
	# rename to workaround a bug in pkg_resources
	# https://bugs.gentoo.org/834522
	mv "${D}$(python_get_sitedir)"/jaraco{_,.}functools-${PV}.dist-info || die
}

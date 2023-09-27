# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1

# XXX: drop .retag on next version
MY_P=python-versioneer-${PV}
DESCRIPTION="Easy VCS-based management of project version strings"
HOMEPAGE="
	https://pypi.org/project/versioneer/
	https://github.com/python-versioneer/python-versioneer/
"
SRC_URI="
	https://github.com/python-versioneer/python-versioneer/archive/${PV}.tar.gz
		-> ${MY_P}.retag.gh.tar.gz
"
S=${WORKDIR}/${MY_P}

SLOT="0"
LICENSE="Unlicense"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~arm64-macos ~x64-macos"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	$(python_gen_cond_dep '
		dev-python/tomli[${PYTHON_USEDEP}]
	' 3.10)
"
BDEPEND="
	test? (
		dev-python/build[${PYTHON_USEDEP}]
		dev-python/packaging[${PYTHON_USEDEP}]
		dev-vcs/git
		!!dev-python/nose[${PYTHON_USEDEP}]
	)
"

python_test() {
	esetup.py make_versioneer

	git config --global user.email "you@example.com" || die
	git config --global user.name "Your Name" || die
	git config --global init.defaultBranch whatever || die

	"${EPYTHON}" test/git/test_git.py -v || die
}

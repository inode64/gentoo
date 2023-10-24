# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_TESTED=( python3_{9..11} )
PYTHON_COMPAT=( "${PYTHON_TESTED[@]}" )

inherit distutils-r1 multiprocessing

MY_P=${P/_p/.post}
DESCRIPTION="Ahead of Time compiler for numeric kernels"
HOMEPAGE="
	https://pypi.org/project/pythran/
	https://github.com/serge-sans-paille/pythran/
"
SRC_URI="
	https://github.com/serge-sans-paille/pythran/archive/${PV/_p/.post}.tar.gz
		-> ${MY_P}.gh.tar.gz
"
S=${WORKDIR}/${MY_P}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~ia64 ~loong ppc ppc64 ~riscv ~s390 ~sparc x86 ~arm64-macos ~x64-macos"

RDEPEND="
	dev-libs/boost
	=dev-python/beniget-0.4*[${PYTHON_USEDEP}]
	=dev-python/gast-0.5*[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	>=dev-python/ply-3.4[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		$(python_gen_cond_dep '
			dev-python/ipython[${PYTHON_USEDEP}]
		' "${PYTHON_TESTED[@]}")
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
		virtual/cblas
		!!dev-python/setuptools-declarative-requirements
	)
"

distutils_enable_tests pytest

src_configure() {
	# TODO: package xsimd then set no_xsimd = True
	cat >> setup.cfg <<-EOF
		[build_py]
		no_boost = True
	EOF
}

python_test() {
	local EPYTEST_DESELECT=(
		# TODO
		pythran/tests/test_xdoc.py::TestDoctest::test_cli
		pythran/tests/test_xdoc.py::TestDoctest::test_toolchain
		# Tries to invoke pip
		pythran/tests/test_distutils.py::TestDistutils::test_setup_build
		pythran/tests/test_distutils.py::TestDistutils::test_setup_build2
	)

	local -x COLUMNS=80
	epytest -n "$(makeopts_jobs)"
}

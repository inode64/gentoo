# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..12} pypy3 )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

DESCRIPTION="Python documentation generator"
HOMEPAGE="
	https://www.sphinx-doc.org/
	https://github.com/sphinx-doc/sphinx/
	https://pypi.org/project/Sphinx/
"
SRC_URI="
	https://github.com/sphinx-doc/sphinx/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x64-solaris"
IUSE="doc latex"

RDEPEND="
	<dev-python/alabaster-0.8[${PYTHON_USEDEP}]
	>=dev-python/Babel-2.9[${PYTHON_USEDEP}]
	<dev-python/docutils-0.21[${PYTHON_USEDEP}]
	>=dev-python/docutils-0.18.1[${PYTHON_USEDEP}]
	>=dev-python/imagesize-1.3[${PYTHON_USEDEP}]
	>=dev-python/jinja-3.0[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.14[${PYTHON_USEDEP}]
	>=dev-python/requests-2.25.0[${PYTHON_USEDEP}]
	>=dev-python/snowballstemmer-2.0[${PYTHON_USEDEP}]
	dev-python/sphinxcontrib-applehelp[${PYTHON_USEDEP}]
	dev-python/sphinxcontrib-devhelp[${PYTHON_USEDEP}]
	dev-python/sphinxcontrib-jsmath[${PYTHON_USEDEP}]
	>=dev-python/sphinxcontrib-htmlhelp-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/sphinxcontrib-serializinghtml-1.1.9[${PYTHON_USEDEP}]
	dev-python/sphinxcontrib-qthelp[${PYTHON_USEDEP}]
	>=dev-python/packaging-21.0[${PYTHON_USEDEP}]
	latex? (
		dev-texlive/texlive-latexextra
		dev-texlive/texlive-luatex
		app-text/dvipng
	)
	!dev-python/namespace-sphinxcontrib
"
BDEPEND="
	doc? (
		dev-python/sphinxcontrib-websupport[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? (
		app-text/dvipng
		>=dev-python/cython-3.0.0[${PYTHON_USEDEP}]
		dev-python/filelock[${PYTHON_USEDEP}]
		dev-python/html5lib[${PYTHON_USEDEP}]
		>=dev-python/setuptools-67.0[${PYTHON_USEDEP}]
		dev-texlive/texlive-fontsextra
		dev-texlive/texlive-latexextra
		dev-texlive/texlive-luatex
		virtual/imagemagick-tools[jpeg,png,svg]
	)
"

PATCHES=(
	"${FILESDIR}/sphinx-3.2.1-doc-link.patch"
	"${FILESDIR}/sphinx-4.3.2-doc-link.patch"
)

distutils_enable_tests pytest

python_prepare_all() {
	# disable internet access
	sed -i -e 's:^intersphinx_mapping:disabled_&:' \
		doc/conf.py || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
	# we can't use distutils_enable_sphinx because it would
	# introduce a dep on itself
	use doc && build_sphinx doc
}

python_test() {
	mkdir -p "${BUILD_DIR}/sphinx_tempdir" || die
	local -x SPHINX_TEST_TEMPDIR="${BUILD_DIR}/sphinx_tempdir"

	local EPYTEST_DESELECT=(
		# these tests require Internet access
		tests/test_build_latex.py::test_latex_images
		# TODO
		tests/test_ext_autodoc.py::test_cython
		tests/test_ext_autodoc_autoclass.py::test_classes
		tests/test_ext_autodoc_autofunction.py::test_classes
		# looks like a bug in lualatex
		"tests/test_build_latex.py::test_build_latex_doc[lualatex-howto-None]"
		"tests/test_build_latex.py::test_build_latex_doc[lualatex-manual-None]"
		# doesn't like paths?
		tests/test_directive_other.py::test_include_source_read_event
		# flaky
		tests/test_build_linkcheck.py
		# TODO: regressions in 7.2.6
		tests/test_ext_autodoc.py::test_autodoc
		tests/test_ext_autodoc_automodule.py::test_subclass_of_mocked_object
		tests/test_ext_autodoc_configs.py::test_mocked_module_imports
		tests/test_ext_autosummary.py::test_autosummary_mock_imports
		tests/test_util_typing.py::test_restify_mock
		tests/test_util_typing.py::test_stringify_mock
	)
	[[ ${EPYTHON} == pypy3 ]] && EPYTEST_DESELECT+=(
		tests/test_ext_autodoc.py::test_autodoc_inherited_members_None
		tests/test_ext_autodoc.py::test_automethod_for_builtin
		tests/test_ext_autodoc.py::test_partialfunction
		tests/test_ext_autodoc_autofunction.py::test_builtin_function
		tests/test_ext_autodoc_autofunction.py::test_methoddescriptor
		tests/test_ext_autodoc_preserve_defaults.py::test_preserve_defaults_special_constructs
		tests/test_ext_autosummary.py::test_autosummary_generate_content_for_module
		tests/test_ext_autosummary.py::test_autosummary_generate_content_for_module_skipped
		tests/test_util_inspect.py::test_isattributedescriptor
		tests/test_util_typing.py::test_is_invalid_builtin_class
	)

	# note: pytest-xdist causes random test failures
	epytest
}

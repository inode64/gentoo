# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

TYPESHED_P="typeshed-ae9d4f4b21bb5e1239816c301da7b1ea904b44c3"
DJANGO_STUBS_P="django-stubs-fd057010f6cbf176f57d1099e82be46d39b99cb9"

DESCRIPTION="Autocompletion library for Python"
HOMEPAGE="
	https://github.com/davidhalter/jedi/
	https://pypi.org/project/jedi/
"
SRC_URI="
	https://github.com/davidhalter/jedi/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
	https://github.com/davidhalter/typeshed/archive/${TYPESHED_P#typeshed-}.tar.gz
		-> ${TYPESHED_P}.tar.gz
	https://github.com/davidhalter/django-stubs/archive/${DJANGO_STUBS_P#django-stubs-}.tar.gz
		-> ${DJANGO_STUBS_P/v/}.tar.gz
"

LICENSE="
	MIT
	test? ( Apache-2.0 )
"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~loong ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~arm64-macos ~x64-macos"

RDEPEND="
	<dev-python/parso-0.9[${PYTHON_USEDEP}]
	>=dev-python/parso-0.8.3[${PYTHON_USEDEP}]
"

# RDEPEND needed because of an import jedi inside conf.py
distutils_enable_sphinx docs \
	dev-python/parso \
	dev-python/sphinx-rtd-theme
distutils_enable_tests pytest

python_prepare_all() {
	# upstream includes these as submodules ...
	rmdir "${S}"/jedi/third_party/{django-stubs,typeshed} || die
	mv "${WORKDIR}/${DJANGO_STUBS_P/v/}" \
		"${S}/jedi/third_party/django-stubs" || die
	mv "${WORKDIR}/${TYPESHED_P}" \
		"${S}/jedi/third_party/typeshed" || die

	# test_complete_expanduser relies on $HOME not being empty
	> "${HOME}"/somefile || die

	distutils-r1_python_prepare_all
}

python_test() {
	local EPYTEST_DESELECT=(
		# fragile
		test/test_speed.py
		# assumes pristine virtualenv
		test/test_inference/test_imports.py::test_os_issues
	)

	# some plugin breaks case-insensitivity on completions
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	# django and pytest tests are very version dependent
	epytest -o addopts= -k "not django and not pytest"
}

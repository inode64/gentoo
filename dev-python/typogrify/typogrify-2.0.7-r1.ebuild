# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Filters for web typography, supporting Django & Jinja templates"
HOMEPAGE="
	https://github.com/mintchaos/typogrify/
	https://pypi.org/project/typogrify/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86"

RDEPEND="
	>=dev-python/smartypants-1.8.3[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_test() {
	epytest --doctest-modules \
		typogrify/filters.py \
		typogrify/packages/titlecase/tests.py
}

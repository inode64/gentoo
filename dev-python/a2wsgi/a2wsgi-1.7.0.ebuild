# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm
PYTHON_COMPAT=( pypy3 python3_{9..11} )

inherit distutils-r1 pypi

DESCRIPTION="Convert WSGI app to ASGI app or ASGI app to WSGI app"
HOMEPAGE="
	https://github.com/abersheeran/a2wsgi/
	https://pypi.org/project/a2wsgi/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~loong ~ppc64 ~riscv"

BDEPEND="
	test? (
		<dev-python/asgiref-4[${PYTHON_USEDEP}]
		>=dev-python/asgiref-3.2.7[${PYTHON_USEDEP}]
		<dev-python/httpx-1[${PYTHON_USEDEP}]
		>=dev-python/httpx-0.22.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

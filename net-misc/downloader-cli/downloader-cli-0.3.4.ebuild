# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Simple downloader with an customizable progressbar"
HOMEPAGE="
	https://github.com/deepjyoti30/downloader-cli/
	https://pypi.org/project/downloader-cli/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"

RDEPEND="dev-python/urllib3[${PYTHON_USEDEP}]"

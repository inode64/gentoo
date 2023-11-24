# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Python based FIDO 2.0 library"
HOMEPAGE="https://github.com/Yubico/python-fido2"
SRC_URI="https://github.com/Yubico/python-fido2/releases/download/${PV}/${P}.tar.gz"

LICENSE="Apache-2.0 BSD-2 MIT MPL-2.0"
SLOT="0/0.9" # Bumped every time a backwards-incompatible version is released
KEYWORDS="amd64 arm64 ~ppc64 ~riscv x86"
IUSE="examples"

RDEPEND="
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/pyscard[${PYTHON_USEDEP}]
	examples? (
		dev-python/flask[${PYTHON_USEDEP}]
		dev-python/pyopenssl[${PYTHON_USEDEP}]
	)
"
BDEPEND="test? (
	dev-python/mock[${PYTHON_USEDEP}]
	>=dev-python/pyfakefs-3.4[${PYTHON_USEDEP}] )
"

distutils_enable_tests unittest

python_install_all() {
	distutils-r1_python_install_all

	if use examples; then
		docinto examples
		dodoc -r "${S}"/examples/.
		docompress -x "/usr/share/doc/${PF}/examples"
	fi
}

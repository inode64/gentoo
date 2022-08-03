# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

MY_PN="PyAudio"

DESCRIPTION="Python bindings for PortAudio"
HOMEPAGE="http://people.csail.mit.edu/hubert/pyaudio/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

# Tests work if you have the correct HW device(s) to test. 0.2.11-r1.
RESTRICT="test"

RDEPEND="media-libs/portaudio"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/numpy[${PYTHON_USEDEP}] )"

distutils_enable_sphinx sphinx
distutils_enable_tests unittest

PATCHES=(
	"${FILESDIR}"/${PN}-0.2.11-python310-size_t.patch
)

python_test() {
	elog "These tests require an OS loopback sound device that forwards audio"
	elog "output, generated by PyAudio for playback, and forwards it to an input"
	elog "device, which PyAudio can record and verify against a test signal."

	cd tests || die
	# pyaudio_tests have very complicated runtime requirements, therefore skipping them.
	"${EPYTHON}" -m unittest error_tests -v || die "Tests fail with ${EPYTHON}"
}

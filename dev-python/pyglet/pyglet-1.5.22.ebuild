# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1 virtualx xdg-utils

DESCRIPTION="Cross-platform windowing and multimedia library for Python"
HOMEPAGE="http://pyglet.org/"
SRC_URI="https://github.com/pyglet/pyglet/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~riscv ~x86 ~amd64-linux ~x86-linux"
IUSE="examples image +sound"

BDEPEND="
	test? (
		dev-python/pillow[${PYTHON_USEDEP}]
		media-libs/fontconfig
	)
"
RDEPEND="
	virtual/glu
	virtual/opengl
	image? ( || (
		dev-python/pillow[${PYTHON_USEDEP}]
		x11-libs/gtk+:2
	) )
	sound? ( || (
		media-libs/openal
		media-sound/pulseaudio
	) )
"
#	ffmpeg? ( media-libs/avbin-bin )

DOCS=( DESIGN NOTICE README.md RELEASE_NOTES )

distutils_enable_tests pytest

python_test() {
	xdg_environment_reset

	# Deselect openal test, can't open device in sandbox
	local EPYTEST_DESELECT=(
		tests/unit/media/test_listener.py::test_openal_listener
	)

	# Specify path to avoid running interactive tests
	# We could add in integration tests, but they're slow
	virtx epytest tests/unit
}

python_install_all() {
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi

	distutils-r1_python_install_all
}

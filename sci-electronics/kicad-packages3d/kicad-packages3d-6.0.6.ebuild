# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit check-reqs cmake

DESCRIPTION="Electronic Schematic and PCB design tools 3D package libraries"
HOMEPAGE="https://gitlab.com/kicad/libraries/kicad-packages3D"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://gitlab.com/kicad/libraries/kicad-packages3D.git"
	inherit git-r3
else
	MY_PV="${PV/_rc/-rc}"
	MY_P="${PN}-${MY_PV}"
	# Source directory for this package always has the repository hash in the directory name
	MY_HASH="6bfd8dfa3adc6ac316b9857977c87f22282c6e24"
	SRC_URI="https://gitlab.com/kicad/libraries/${PN}/-/archive/${MY_PV}/${MY_P}.tar.gz -> ${P}.tar.gz"

	if [[ ${PV} != *_rc* ]] ; then
		KEYWORDS="~amd64 ~arm64 ~riscv ~x86"
	fi

	S="${WORKDIR}/${PN/3d/3D}-${MY_PV}-${MY_HASH}"
fi

IUSE="+occ"
LICENSE="CC-BY-SA-4.0"
SLOT="0"

RDEPEND=">=sci-electronics/kicad-6.0.0[occ=]"

if [[ ${PV} == 9999 ]] ; then
	# x11-misc-util/macros only required on live ebuilds
	BDEPEND=">=x11-misc/util-macros-1.18"
fi

CHECKREQS_DISK_BUILD="11G"

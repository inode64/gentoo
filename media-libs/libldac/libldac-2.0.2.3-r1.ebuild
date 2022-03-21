# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_ECLASS=cmake
inherit cmake-multilib

DESCRIPTION="LDAC codec library from AOSP"
HOMEPAGE="https://android.googlesource.com/platform/external/libldac/"
SRC_URI="https://github.com/EHfive/ldacBT/releases/download/v${PV}/ldacBT-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ppc ppc64 ~riscv ~sparc x86 ~amd64-linux ~x86-linux"

S="${WORKDIR}/ldacBT"

multilib_src_configure() {
	local mycmakeargs=(
		-DLDAC_SOFT_FLOAT=OFF
		-DINSTALL_LIBDIR=/usr/$(get_libdir)
	)

	cmake_src_configure
}

src_install() {
	cmake-multilib_src_install
}

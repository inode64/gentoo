# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
GIT_COMMIT=0065cff7e0222c234b75a71e72b8883df5d000c2

# Upstream don't make releases anymore and instead have a (broken) "rolling git tag"
# model.
#
# https://github.com/LuaJIT/LuaJIT/issues/665#issuecomment-784452583
# https://www.freelists.org/post/luajit/LuaJIT-uses-rolling-releases
#
# Regular snapshots should be made from the v2.1 branch.

inherit pax-utils toolchain-funcs

MY_PV="$(ver_cut 1-5)"
MY_PV="${MY_PV/_beta/-beta}"
MY_P="LuaJIT-${MY_PV}"

DESCRIPTION="Just-In-Time Compiler for the Lua programming language"
HOMEPAGE="https://luajit.org/"
# SRC_URI="https://luajit.org/download/${MY_P}.tar.gz"
SRC_URI="https://github.com/LuaJIT/LuaJIT/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
# this should probably be pkgmoved to 2.0 for sake of consistency.
SLOT="2/${PV}"
KEYWORDS="~amd64 ~arm ~arm64 -hppa ~mips ~ppc -riscv -sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="lua52compat static-libs"

S="${WORKDIR}/LuaJIT-${GIT_COMMIT}"

src_configure() {
	tc-export_build_env

	# You need to use a 32-bit toolchain to build for a 32-bit architecture.
	# Some 64-bit toolchains (like amd64 and ppc64) usually have multilib
	# enabled, allowing you to build in 32-bit with -m32. This won't work in all
	# cases, but it will otherwise just break, so it's worth trying anyway. If
	# you're trying to build for 64-bit from 32-bit, then you're screwed, sorry.
	# See https://github.com/LuaJIT/LuaJIT/issues/664 for the upstream issue.
	if tc-is-cross-compiler && [[ $(tc-get-build-ptr-size) != 4 && $(tc-get-ptr-size) == 4 ]]; then
		BUILD_CFLAGS+=" -m32"
		BUILD_LDFLAGS+=" -m32"
	fi
}

_emake() {
	emake \
		Q= \
		PREFIX="${EPREFIX}/usr" \
		MULTILIB="$(get_libdir)" \
		DESTDIR="${D}" \
		CFLAGS="" \
		LDFLAGS="" \
		HOST_CC="$(tc-getBUILD_CC)" \
		HOST_CFLAGS="${BUILD_CPPFLAGS} ${BUILD_CFLAGS}" \
		HOST_LDFLAGS="${BUILD_LDFLAGS}" \
		STATIC_CC="$(tc-getCC)" \
		DYNAMIC_CC="$(tc-getCC) -fPIC" \
		TARGET_LD="$(tc-getCC)" \
		TARGET_CFLAGS="${CPPFLAGS} ${CFLAGS}" \
		TARGET_LDFLAGS="${LDFLAGS}" \
		TARGET_AR="$(tc-getAR) rcus" \
		BUILDMODE="$(usex static-libs mixed dynamic)" \
		TARGET_STRIP="true" \
		INSTALL_LIB="${ED}/usr/$(get_libdir)" \
		"$@"
}

src_compile() {
	_emake XCFLAGS="$(usex lua52compat "-DLUAJIT_ENABLE_LUA52COMPAT" "")"
}

src_install() {
	_emake install
	dosym luajit-2.1.0-beta3 /usr/bin/luajit
	pax-mark m "${ED}/usr/bin/luajit-${MY_PV}"

	HTML_DOCS="doc/." einstalldocs
}

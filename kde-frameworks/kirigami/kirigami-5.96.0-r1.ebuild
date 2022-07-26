# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_EXAMPLES="true"
ECM_QTHELP="false"
ECM_TEST="true"
KDE_ORG_NAME="${PN}2"
QTMIN=5.15.4
inherit ecm frameworks.kde.org

DESCRIPTION="Lightweight user interface framework for mobile and convergent applications"
HOMEPAGE="https://techbase.kde.org/Kirigami"
EGIT_REPO_URI="${EGIT_REPO_URI/${PN}2/${PN}}"
SRC_URI+=" https://dev.gentoo.org/~asturm/distfiles/${P}-fix-ScrollBar-binding-loop-freeze.patch.xz"

LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE=""

# requires package to already be installed
RESTRICT="test"

DEPEND="
	>=dev-qt/qtconcurrent-${QTMIN}:5
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=dev-qt/qtsvg-${QTMIN}:5
"
RDEPEND="${DEPEND}
	>=dev-qt/qtgraphicaleffects-${QTMIN}:5
"
BDEPEND=">=dev-qt/linguist-tools-${QTMIN}:5"

PATCHES=( "${WORKDIR}/${P}-fix-ScrollBar-binding-loop-freeze.patch" ) # KDE-bug 448784

src_configure() {
	local mycmakeargs=(
		-DBUILD_EXAMPLES=$(usex examples)
	)

	ecm_src_configure
}

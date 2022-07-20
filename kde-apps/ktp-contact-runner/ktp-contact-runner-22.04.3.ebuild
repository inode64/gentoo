# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PVCUT=$(ver_cut 1-3)
KFMIN=5.92.0
QTMIN=5.15.4
inherit ecm gear.kde.org

DESCRIPTION="KDE Telepathy krunner plugin"
HOMEPAGE="https://community.kde.org/KTp"

LICENSE="LGPL-2.1"
SLOT="5"
KEYWORDS="amd64 ~arm64 ~riscv ~x86"
IUSE=""

RDEPEND="
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-apps/ktp-common-internals-${PVCUT}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/krunner-${KFMIN}:5
	>=net-libs/telepathy-qt-0.9.8
"
DEPEND="${RDEPEND}
	>=kde-frameworks/kservice-${KFMIN}:5
"

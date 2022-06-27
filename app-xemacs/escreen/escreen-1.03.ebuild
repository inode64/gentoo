# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

SLOT="0"
DESCRIPTION="Multiple editing sessions withing a single frame (like screen).."
XEMACS_PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="~alpha amd64 ppc ppc64 ~riscv sparc x86"

inherit xemacs-packages

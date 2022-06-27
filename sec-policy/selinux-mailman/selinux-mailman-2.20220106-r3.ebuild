# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

IUSE=""
MODS="mailman"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for mailman"

if [[ ${PV} != 9999* ]] ; then
	KEYWORDS="amd64 arm arm64 ~mips x86"
fi

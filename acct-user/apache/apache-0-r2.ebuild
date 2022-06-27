# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

ACCT_USER_ID="81"
ACCT_USER_GROUPS=( "apache" )
ACCT_USER_HOME="/var/www"

acct-user_add_deps

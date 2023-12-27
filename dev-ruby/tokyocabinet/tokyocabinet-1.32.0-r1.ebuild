# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby31 ruby32 ruby33"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTENSIONS=(./extconf.rb)

inherit ruby-fakegem

DESCRIPTION="Ruby bindings for Tokyo Cabinet"
HOMEPAGE="https://fallabs.com/tokyocabinet/"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE=""

RDEPEND+="dev-db/tokyocabinet"

# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An accumulation place for pure-scheme Guile modules"
HOMEPAGE="http://www.nongnu.org/guile-lib/"
SRC_URI="mirror://nongnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="strip"

RDEPEND=">=dev-scheme/guile-2.0.0:="
DEPEND="${RDEPEND}"

# guile generates ELF files without use of C or machine code
# It's a portage's false positive. bug #677600
QA_PREBUILT='*[.]go'

src_prepare() {
	default

	# http://debbugs.gnu.org/cgi/bugreport.cgi?bug=38112
	find "${S}" -name "*.scm" -exec touch {} + || die
}

src_configure() {
	econf --with-guile-site=yes
}

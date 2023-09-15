# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PHP_EXT_NAME="memcache"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
PHP_EXT_NEEDED_USE="session(-)?"
DOCS=( README example.php )
HTML_DOCS=( memcache.php )

USE_PHP="php8-0 php8-1"

inherit php-ext-pecl-r3

KEYWORDS="~amd64 ~hppa ~ppc64 ~x86"

DESCRIPTION="PHP extension for using memcached"
LICENSE="PHP-3"
SLOT="8"
IUSE="+session"

DEPEND="
	php_targets_php8-0? ( sys-libs/zlib )
	php_targets_php8-1? ( sys-libs/zlib )
"
RDEPEND="${DEPEND}"

# The test suite requires memcached to be running.
RESTRICT='test'
PATCHES=( "${FILESDIR}/8.0-patches-20211123.patch" )

src_prepare() {
	if use php_targets_php8-0 || use php_targets_php8-1 ; then
		php-ext-source-r3_src_prepare
	else
		default
	fi
}

src_configure() {
	if use php_targets_php8-0 || use php_targets_php8-1 ; then
		local PHP_EXT_ECONF_ARGS=( --enable-memcache --with-zlib-dir="${EPREFIX}/usr" $(use_enable session memcache-session) )
		php-ext-source-r3_src_configure
	fi
}

src_install() {
	if use php_targets_php8-0 || use php_targets_php8-1 ; then
		php-ext-pecl-r3_src_install

		php-ext-source-r3_addtoinifiles "memcache.allow_failover" "true"
		php-ext-source-r3_addtoinifiles "memcache.max_failover_attempts" "20"
		php-ext-source-r3_addtoinifiles "memcache.chunk_size" "32768"
		php-ext-source-r3_addtoinifiles "memcache.default_port" "11211"
		php-ext-source-r3_addtoinifiles "memcache.hash_strategy" "consistent"
		php-ext-source-r3_addtoinifiles "memcache.hash_function" "crc32"
		php-ext-source-r3_addtoinifiles "memcache.redundancy" "1"
		php-ext-source-r3_addtoinifiles "memcache.session_redundancy" "2"
		php-ext-source-r3_addtoinifiles "memcache.protocol" "ascii"
	fi
}

# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-1 )
PYTHON_COMPAT=( python3_{8..10} )
PYTHON_REQ_USE="threads(+)"

RUBY_OPTIONAL="yes"
USE_RUBY="ruby25 ruby26 ruby27 ruby30"

PHP_EXT_INI="no"
PHP_EXT_NAME="dummy"
PHP_EXT_OPTIONAL_USE="php"
USE_PHP="php7-3 php7-4" # deps must be registered separately below

MY_P="${P/_/-}"

inherit lua-single pax-utils php-ext-source-r3 python-r1 ruby-ng

DESCRIPTION="uWSGI server for Python web applications"
HOMEPAGE="https://projects.unbit.it/uwsgi/"
SRC_URI="https://github.com/unbit/uwsgi/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ~arm64 x86 ~amd64-linux"

UWSGI_PLUGINS_STD=( ping cache carbon nagios rpc rrdtool
	http ugreen signal syslog rsyslog
	router_{uwsgi,redirect,basicauth,rewrite,http,cache,static,memcached,redis,hash,expires,metrics}
	{core,fast,raw,ssl}router
	redislog mongodblog log{file,socket}
	spooler cheaper_busyness symcall
	transformation_{chunked,gzip,offload,tofile}
	zergpool )
UWSGI_PLUGINS_OPT=( alarm_{curl,xmpp} clock_{monotonic,realtime} curl_cron
	dumbloop echo emperor_{amqp,pg,zeromq} forkptyrouter
	geoip graylog2 legion_cache_fetch ldap log{crypto,pipe} notfound pam
	rados router_{access,radius,spnego,xmldir}
	sqlite ssi stats_pusher_statsd
	systemd_logger transformation_toupper tuntap webdav xattr xslt zabbix )

LANG_SUPPORT_SIMPLE=( cgi mono perl ) # plugins which can be built in the main build process
LANG_SUPPORT_EXTENDED=( go lua php python python-asyncio python-gevent ruby )

# plugins to be ignored (for now):
# cheaper_backlog2: example plugin
# coroae: TODO
# cplusplus: partially example code, needs explicit class
# dummy: no idea
# example: example plugin
# exception_log: example plugin
# *java*: TODO
# v8: TODO
# matheval: TODO
IUSE="apache2 +caps debug +embedded expat jemalloc json +pcre +routing selinux +ssl +xml yajl yaml zeromq"

for plugin in ${UWSGI_PLUGINS_STD[@]}; do IUSE="${IUSE} +uwsgi_plugins_${plugin}"; done
for plugin in ${UWSGI_PLUGINS_OPT[@]}; do IUSE="${IUSE} uwsgi_plugins_${plugin}"; done
IUSE="${IUSE} ${LANG_SUPPORT_SIMPLE[@]} ${LANG_SUPPORT_EXTENDED[@]}"

REQUIRED_USE="|| ( ${LANG_SUPPORT_SIMPLE[@]} ${LANG_SUPPORT_EXTENDED[@]} )
	uwsgi_plugins_logcrypto? ( ssl )
	uwsgi_plugins_sslrouter? ( ssl )
	routing? ( pcre )
	uwsgi_plugins_emperor_zeromq? ( zeromq )
	uwsgi_plugins_forkptyrouter? ( uwsgi_plugins_corerouter )
	uwsgi_plugins_router_xmldir? ( xml !expat )
	lua? ( ${LUA_REQUIRED_USE} )
	python? ( ${PYTHON_REQUIRED_USE} )
	python-asyncio? ( python )
	python-gevent? ( python )
	expat? ( xml )"

# util-linux is required for libuuid when requesting zeromq support
# Order:
# 1. Unconditional
# 2. General features
# 3. Plugins
# 4. Language/app support
CDEPEND="
	sys-libs/zlib
	virtual/libcrypt:=
	caps? ( sys-libs/libcap )
	json? (
		!yajl? ( dev-libs/jansson:= )
		yajl? ( dev-libs/yajl )
	)
	pcre? ( dev-libs/libpcre:3 )
	ssl? ( dev-libs/openssl:0= )
	xml? (
		!expat? ( dev-libs/libxml2 )
		expat? ( dev-libs/expat )
	)
	yaml? ( dev-libs/libyaml )
	zeromq? ( net-libs/zeromq sys-apps/util-linux )
	uwsgi_plugins_alarm_curl? ( net-misc/curl )
	uwsgi_plugins_alarm_xmpp? ( net-libs/gloox )
	uwsgi_plugins_curl_cron? ( net-misc/curl )
	uwsgi_plugins_emperor_pg? ( dev-db/postgresql:= )
	uwsgi_plugins_geoip? ( dev-libs/geoip )
	uwsgi_plugins_ldap? ( net-nds/openldap )
	uwsgi_plugins_pam? ( sys-libs/pam )
	uwsgi_plugins_sqlite? ( dev-db/sqlite:3 )
	uwsgi_plugins_rados? ( sys-cluster/ceph )
	uwsgi_plugins_router_access? ( sys-apps/tcp-wrappers )
	uwsgi_plugins_router_spnego? ( virtual/krb5 )
	uwsgi_plugins_systemd_logger? ( sys-apps/systemd )
	uwsgi_plugins_webdav? ( dev-libs/libxml2 )
	uwsgi_plugins_xslt? ( dev-libs/libxslt )
	go? ( sys-devel/gcc:=[go] )
	lua? ( ${LUA_DEPS} )
	mono? ( dev-lang/mono:= )
	perl? ( dev-lang/perl:= )
	php? (
		php_targets_php7-3? ( dev-lang/php:7.3[embed] )
		php_targets_php7-4? ( dev-lang/php:7.4[embed] )
	)
	python? ( ${PYTHON_DEPS} )
	python-asyncio? ( virtual/python-greenlet[${PYTHON_USEDEP}] )
	python-gevent? ( >=dev-python/gevent-1.3.5[${PYTHON_USEDEP}] )
	ruby? ( $(ruby_implementations_depend) )"
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}
	selinux? ( sec-policy/selinux-uwsgi )
	uwsgi_plugins_rrdtool? ( net-analyzer/rrdtool )"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${P}-py310-fix.patch"
	"${FILESDIR}/${P}-pynode-compile.patch"
	"${FILESDIR}/${P}-py310-fix-2.patch"
)

S="${WORKDIR}/${MY_P}"

src_unpack() {
	echo ${PYTHON_USEDEP}
	default
}

pkg_setup() {
	python_setup
	use lua && lua-single_pkg_setup
	use ruby && ruby-ng_pkg_setup
}

src_prepare() {
	default

	sed -i \
		-e "s|'-O2', ||" \
		-e "s|'-Werror', ||" \
		-e "s|uc.get('plugin_dir')|uc.get('plugin_build_dir')|" \
		uwsgiconfig.py || die "sed failed"

	sed -i \
		-e "s|/lib|/$(get_libdir)|" \
		plugins/php/uwsgiplugin.py || die "sed failed"
}

src_configure() {
	local embedded_plugins=()
	local plugins=()
	local malloc_impl="libc"
	local json="false"
	local xml="false"

	for p in ${UWSGI_PLUGINS_STD[@]} ${UWSGI_PLUGINS_OPT[@]} ; do
		use uwsgi_plugins_${p} && embedded_plugins+=("${p}")
	done
	for p in ${LANG_SUPPORT_SIMPLE[@]} ; do
		use ${p} && plugins+=("${p}")
	done

	# do not embed any plugins
	if ! use embedded; then
		plugins=( ${plugins[@]} ${embedded_plugins[@]} )
		embedded_plugins=()
	fi

	# flatten the arrays
	plugins=${plugins[@]}
	embedded_plugins=${embedded_plugins[@]}

	# rename some of the use flags, language plugins are always real plugins
	plugins="${plugins/perl/psgi}"
	plugins="${plugins/sqlite/sqlite3}"
	embedded_plugins="${embedded_plugins/sqlite/sqlite3}"

	# override defaults as requested by the user
	if use xml; then
		use expat && xml="expat" || xml="libxml2"
	fi
	if use json; then
		use yajl && json="yajl" || json="jansson"
	fi
	use jemalloc && malloc_impl="jemalloc"

	# prepare the buildconf for gentoo
	cp "${FILESDIR}"/gentoo.buildconf buildconf/gentoo.ini || die
	sed -i \
		-e "s|VAR_XML|${xml}|" \
		-e "s|VAR_YAML|$(usex yaml libyaml true)|" \
		-e "s|VAR_JSON|${json}|" \
		-e "s|VAR_SSL|$(usex ssl true false)|" \
		-e "s|VAR_PCRE|$(usex pcre true false)|" \
		-e "s|VAR_ZMQ|$(usex zeromq true false)|" \
		-e "s|VAR_ROUTING|$(usex routing true false)|" \
		-e "s|VAR_DEBUG|$(usex debug true false)|" \
		-e "s|VAR_MALLOC|${malloc_impl}|" \
		-e "s|VAR_PLUGINS|${plugins// /, }|" \
		-e "s|VAR_PLUGIN_DIR|${EPREFIX}/usr/$(get_libdir)/uwsgi|" \
		-e "s|VAR_BUILD_DIR|${T}/plugins|" \
		-e "s|VAR_EMBEDDED|${embedded_plugins// /, }|" \
		buildconf/gentoo.ini || die "sed failed"

	if ! use caps; then
		sed -i -e 's|sys/capability.h|DISABLED|' uwsgiconfig.py || die "sed failed"
	fi

	if ! use zeromq; then
		sed -i -e 's|uuid/uuid.h|DISABLED|' uwsgiconfig.py || die "sed failed"
	fi

	if use uwsgi_plugins_emperor_pg ; then
		PGPV="$(best_version dev-db/postgresql)"
		PGSLOT="$(ver_cut 1-2 ${PGPV##dev-db/postgresql-})"
		sed -i \
			-e "s|pg_config|pg_config${PGSLOT/.}|" \
			plugins/emperor_pg/uwsgiplugin.py || die "sed failed"
	fi
}

each_ruby_compile() {
	cd "${WORKDIR}/${MY_P}" || die "sed failed"

	UWSGICONFIG_RUBYPATH="${RUBY}" python uwsgiconfig.py --plugin plugins/rack gentoo rack_${RUBY##*/} || die "building plugin for ${RUBY} failed"
	UWSGICONFIG_RUBYPATH="${RUBY}" python uwsgiconfig.py --plugin plugins/fiber gentoo fiber_${RUBY##*/}|| die "building fiber plugin for ${RUBY} failed"
	UWSGICONFIG_RUBYPATH="${RUBY}" python uwsgiconfig.py --plugin plugins/rbthreads gentoo rbthreads_${RUBY##*/}|| die "building rbthreads plugin for ${RUBY} failed"
}

python_compile_plugins() {
	local EPYV
	local PYV
	EPYV=${EPYTHON/.}
	PYV=${EPYV/python}

	${PYTHON} uwsgiconfig.py --plugin plugins/python gentoo ${EPYV} || die "building plugin for ${EPYTHON} failed"

	if use python-asyncio ; then
		if [[ "${PYV}" != "27" ]] ; then
			${PYTHON} uwsgiconfig.py --plugin plugins/asyncio gentoo asyncio${PYV} || die "building plugin for asyncio-support in ${EPYTHON} failed"
		fi
	fi

	if use python-gevent ; then
		${PYTHON} uwsgiconfig.py --plugin plugins/gevent gentoo gevent${PYV} || die "building plugin for gevent-support in ${EPYTHON} failed"
	fi

	if use python-gevent || use python-asyncio; then
			${PYTHON} uwsgiconfig.py --plugin plugins/greenlet gentoo greenlet${PYV} || die "building plugin for greenlet-support in ${EPYTHON} failed"
	fi
}

python_install_symlinks() {
	dosym uwsgi /usr/bin/uwsgi_${EPYTHON/.}
}

src_compile() {
	mkdir -p "${T}/plugins" || die

	CPUCOUNT=1 python uwsgiconfig.py --build gentoo || die "building uwsgi failed"

	if use go ; then
		python uwsgiconfig.py --plugin plugins/gccgo gentoo || die "building plugin for go failed"
	fi

	if use lua ; then
		# setting the name for the pkg-config file to lua, since that is the name
		# provided by the wrapper from Lua eclasses
		UWSGICONFIG_LUAPC="lua" python uwsgiconfig.py --plugin plugins/lua gentoo || die "building plugin for lua failed"
	fi

	if use php ; then
		for s in $(php_get_slots); do
			UWSGICONFIG_PHPDIR="/usr/$(get_libdir)/${s}" python uwsgiconfig.py --plugin plugins/php gentoo ${s/.} || die "building plugin for ${s} failed"
		done
	fi

	if use python ; then
		python_foreach_impl python_compile_plugins
	fi

	if use ruby ; then
		ruby-ng_src_compile
	fi
}

src_install() {
	dobin uwsgi
	pax-mark m "${D}"/usr/bin/uwsgi

	insinto /usr/$(get_libdir)/uwsgi
	doins "${T}/plugins"/*.so

	use cgi && dosym uwsgi /usr/bin/uwsgi_cgi
	use go && dosym uwsgi /usr/bin/uwsgi_go
	use lua && dosym uwsgi /usr/bin/uwsgi_lua
	use mono && dosym uwsgi /usr/bin/uwsgi_mono
	use perl && dosym uwsgi /usr/bin/uwsgi_psgi

	if use php ; then
		for s in $(php_get_slots); do
			dosym uwsgi /usr/bin/uwsgi_${s/.}
		done
	fi

	if use python ; then
		python_foreach_impl python_install_symlinks
		python_foreach_impl python_domodule uwsgidecorators.py
	fi

	newinitd "${FILESDIR}"/uwsgi.initd-r7 uwsgi
	newconfd "${FILESDIR}"/uwsgi.confd-r4 uwsgi
	keepdir /etc/"${PN}".d
	use uwsgi_plugins_spooler && keepdir /var/spool/"${PN}"
}

pkg_postinst() {
	if use apache2 ; then
		ewarn "As reported on bug #650776 [1], Apache module mod_proxy_uwsgi"
		ewarn "is being transferred to upstream Apache since 2.4.30, see [2]."
		ewarn "We therefore do not build them any more."
		ewarn "    [1] https://bugs.gentoo.org/650776"
		ewarn "    [2] https://github.com/unbit/uwsgi/issues/1636"
	fi

	elog "Append the following options to the uwsgi call to load the respective language plugin:"
	use cgi    && elog "  '--plugins cgi' for cgi"
	use lua    && elog "  '--plugins lua' for lua"
	use mono   && elog "  '--plugins mono' for mono"
	use perl   && elog "  '--plugins psgi' for perl"

	if use php ; then
		for s in $(php_get_slots); do
			elog "  '--plugins ${s/.}' for ${s}"
		done
	fi

	python_pkg_postinst() {
		local EPYV
		local PYV
		EPYV=${EPYTHON/.}
		PYV=${EPYV/python}

		elog " "
		elog "  '--plugins ${EPYV}' for ${EPYTHON}"
		if use python-asyncio ; then
			if [[ ${EPYV} == python34 ]] ; then
				elog "  '--plugins ${EPYV},asyncio${PYV}' for asyncio support in ${EPYTHON}"
			else
				elog "  (asyncio is only supported in python3.4)"
			fi
		fi
		if use python-gevent ; then
			elog "  '--plugins ${EPYV},gevent${PYV}' for gevent support in ${EPYTHON}"
		fi
	}

	use python && python_foreach_impl python_pkg_postinst

	if use ruby ; then
		for ruby in $(ruby_get_use_implementations) ; do
			elog "  '--plugins rack_${ruby/.}' for ${ruby}"
			elog "  '--plugins fiber_${ruby/.}' for ${ruby} fibers"
			elog "  '--plugins rbthreads_${ruby/.}' for ${ruby} rbthreads"
		done
	fi
}

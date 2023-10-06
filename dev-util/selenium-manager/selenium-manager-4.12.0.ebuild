# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4-r1

EAPI=8

CRATES="
	addr2line@0.19.0
	adler@1.0.2
	aes@0.8.3
	aho-corasick@1.0.2
	android-tzdata@0.1.1
	anstream@0.3.2
	anstyle@0.3.5
	anstyle@1.0.1
	anstyle-parse@0.2.1
	anstyle-query@1.0.0
	anstyle-wincon@1.0.1
	assert_cmd@2.0.12
	autocfg@1.1.0
	backtrace@0.3.67
	base64@0.21.0
	base64ct@1.6.0
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@1.3.2
	bitflags@2.4.0
	block-buffer@0.9.0
	block-buffer@0.10.4
	bstr@1.4.0
	bumpalo@3.12.0
	byteorder@1.4.3
	bytes@1.4.0
	bzip2@0.4.4
	bzip2-sys@0.1.11+1.0.8
	cc@1.0.79
	cfb@0.7.3
	cfg-if@1.0.0
	chrono@0.4.26
	cipher@0.4.4
	clap@4.3.23
	clap_builder@4.3.23
	clap_derive@4.3.12
	clap_lex@0.5.0
	colorchoice@1.0.0
	constant_time_eq@0.1.5
	cpufeatures@0.2.5
	crc@3.0.1
	crc-catalog@2.2.0
	crc32fast@1.3.2
	crossbeam-utils@0.8.15
	crypto-common@0.1.6
	difflib@0.4.0
	digest@0.9.0
	digest@0.10.6
	directories@5.0.1
	dirs-sys@0.4.1
	doc-comment@0.3.3
	either@1.8.1
	encoding_rs@0.8.32
	env_logger@0.10.0
	equivalent@1.0.0
	errno@0.2.8
	errno@0.3.1
	errno-dragonfly@0.1.2
	exitcode@1.1.2
	fastrand@2.0.0
	filetime@0.2.22
	filetime_creation@0.1.6
	flate2@1.0.27
	fnv@1.0.7
	form_urlencoded@1.1.0
	futures@0.3.27
	futures-channel@0.3.27
	futures-core@0.3.27
	futures-executor@0.3.27
	futures-io@0.3.27
	futures-macro@0.3.27
	futures-sink@0.3.27
	futures-task@0.3.27
	futures-timer@3.0.2
	futures-util@0.3.27
	generic-array@0.14.6
	getrandom@0.2.8
	gimli@0.27.3
	glob@0.3.1
	h2@0.3.17
	hashbrown@0.12.3
	hashbrown@0.14.0
	heck@0.4.1
	hermit-abi@0.2.6
	hermit-abi@0.3.1
	hmac@0.12.1
	http@0.2.9
	http-body@0.4.5
	httparse@1.8.0
	httpdate@1.0.2
	humantime@2.1.0
	hyper@0.14.25
	hyper-rustls@0.24.0
	idna@0.3.0
	indexmap@1.9.2
	indexmap@2.0.0
	infer@0.15.0
	inout@0.1.3
	io-lifetimes@1.0.11
	ipnet@2.7.1
	is-terminal@0.4.5
	is_executable@1.0.1
	itertools@0.10.5
	itoa@1.0.6
	jobserver@0.1.26
	js-sys@0.3.61
	libc@0.2.147
	linux-raw-sys@0.1.4
	linux-raw-sys@0.4.5
	log@0.4.20
	lzma-rust@0.1.4
	memchr@2.5.0
	mime@0.3.17
	miniz_oxide@0.6.2
	miniz_oxide@0.7.1
	mio@0.8.6
	nt-time@0.5.3
	num-traits@0.2.16
	num_cpus@1.15.0
	object@0.30.4
	once_cell@1.17.1
	opaque-debug@0.3.0
	option-ext@0.2.0
	password-hash@0.4.2
	pbkdf2@0.11.0
	percent-encoding@2.2.0
	pin-project-lite@0.2.12
	pin-utils@0.1.0
	pkg-config@0.3.26
	predicates@3.0.1
	predicates-core@1.0.6
	predicates-tree@1.0.9
	proc-macro2@1.0.66
	quote@1.0.31
	rand_core@0.6.4
	redox_syscall@0.2.16
	redox_syscall@0.3.5
	redox_users@0.4.3
	regex@1.9.3
	regex-automata@0.1.10
	regex-automata@0.3.6
	regex-syntax@0.7.4
	relative-path@1.9.0
	reqwest@0.11.19
	ring@0.16.20
	rstest@0.18.2
	rstest_macros@0.18.2
	rustc-demangle@0.1.23
	rustc_version@0.4.0
	rustix@0.36.11
	rustix@0.38.8
	rustls@0.21.6
	rustls-pemfile@1.0.2
	rustls-webpki@0.101.4
	ryu@1.0.13
	sct@0.7.0
	semver@1.0.17
	serde@1.0.185
	serde_derive@1.0.185
	serde_json@1.0.103
	serde_spanned@0.6.3
	serde_urlencoded@0.7.1
	sevenz-rust@0.5.2
	sha1@0.10.5
	sha2@0.9.9
	sha2@0.10.6
	slab@0.4.8
	socket2@0.4.9
	socket2@0.5.3
	spin@0.5.2
	strsim@0.10.0
	subtle@2.4.1
	syn@1.0.109
	syn@2.0.29
	tar@0.4.40
	tempfile@3.8.0
	termcolor@1.2.0
	termtree@0.4.1
	thiserror@1.0.40
	thiserror-impl@1.0.40
	time@0.3.23
	time-core@0.1.1
	time-macros@0.2.10
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio@1.32.0
	tokio-macros@2.1.0
	tokio-rustls@0.24.1
	tokio-util@0.7.7
	toml@0.7.6
	toml_datetime@0.6.3
	toml_edit@0.19.14
	tower-service@0.3.2
	tracing@0.1.37
	tracing-core@0.1.30
	try-lock@0.2.4
	typenum@1.16.0
	unicode-bidi@0.3.13
	unicode-ident@1.0.8
	unicode-normalization@0.1.22
	untrusted@0.7.1
	url@2.3.1
	utf8parse@0.2.1
	uuid@1.3.0
	version_check@0.9.4
	wait-timeout@0.2.0
	want@0.3.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.84
	wasm-bindgen-backend@0.2.84
	wasm-bindgen-futures@0.4.34
	wasm-bindgen-macro@0.2.84
	wasm-bindgen-macro-support@0.2.84
	wasm-bindgen-shared@0.2.84
	web-sys@0.3.61
	webpki-roots@0.25.2
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.45.0
	windows-sys@0.48.0
	windows-targets@0.42.2
	windows-targets@0.48.1
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.0
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.0
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.0
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.0
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.0
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.0
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.0
	winnow@0.5.0
	winreg@0.50.0
	xattr@1.0.1
	zip@0.6.6
	zstd@0.11.2+zstd.1.5.2
	zstd-safe@5.0.2+zstd.1.5.2
	zstd-sys@2.0.7+zstd.1.5.4
"

inherit cargo

DESCRIPTION="CLI tool that manages the browser/driver infrastructure required by Selenium"
# Double check the homepage as the cargo_metadata crate
# does not provide this value so instead repository is used
HOMEPAGE="https://github.com/SeleniumHQ/selenium"
SRC_URI="
	${CARGO_CRATE_URIS}
	https://github.com/SeleniumHQ/selenium/archive/refs/tags/selenium-${PV}.tar.gz -> ${P}.tar.gz
"
S="${WORKDIR}/selenium-selenium-${PV}/rust"

# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD Boost-1.0 CC0-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="test? ( || ( www-client/firefox www-client/firefox-bin ) )"

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_prepare() {
	default

	# Avoid tests requiring a network
	rm -f tests/{browser_download,chrome_download,grid}_tests.rs || die

	# Avoid tests requiring a specific browser to be installed to keep
	# the dependency tree manageable.
	rm -f tests/{cli,iexplorer,output,safari,stable_browser}_tests.rs || die
	sed -i -e '/case.*\(chrome\|edge\|iexplorer\)/ s:^://:' tests/{browser,exec_driver}_tests.rs || die
	sed -i -e '/browser_version_test/,/^}/ s:^://:' tests/browser_tests.rs || die
}

src_install() {
	default

	cargo_src_install

	dodoc README.md
}

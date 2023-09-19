# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.10

EAPI=8

CRATES="
	adler32@1.2.0
	adler@1.0.2
	aho-corasick@1.0.1
	android-tzdata@0.1.1
	android_system_properties@0.1.4
	ansi_term@0.12.1
	anstream@0.5.0
	anstyle-parse@0.2.1
	anstyle-query@1.0.0
	anstyle-wincon@2.1.0
	anstyle@1.0.2
	anyhow@1.0.65
	autocfg@1.1.0
	bitflags@1.3.2
	bitflags@2.4.0
	bumpalo@3.12.0
	byteorder@1.4.3
	camino@1.1.1
	cargo-platform@0.1.2
	cargo_metadata@0.18.0
	cc@1.0.73
	cfg-if@1.0.0
	chrono@0.4.30
	clap@4.4.0
	clap_builder@4.4.0
	clap_derive@4.4.0
	clap_lex@0.5.1
	colorchoice@1.0.0
	convert_case@0.6.0
	core-foundation-sys@0.8.3
	coveralls-api@0.5.0
	crc32fast@1.3.2
	curl-sys@0.4.56+curl-7.83.1
	curl@0.4.44
	deflate@0.8.6
	enum-display-macro@0.1.3
	enum-display@0.1.3
	equivalent@1.0.0
	errno-dragonfly@0.1.2
	errno@0.2.8
	fallible-iterator@0.3.0
	fastrand@1.8.0
	flate2@1.0.24
	fnv@1.0.7
	form_urlencoded@1.0.1
	gimli@0.28.0
	git2@0.18.0
	glob@0.3.1
	gzip-header@0.3.0
	hashbrown@0.11.2
	hashbrown@0.14.0
	heck@0.4.1
	hermit-abi@0.3.1
	hex@0.4.3
	humantime-serde@1.1.1
	humantime@2.1.0
	iana-time-zone@0.1.46
	idna@0.2.3
	indexmap@1.8.2
	indexmap@2.0.0
	instant@0.1.12
	io-lifetimes@1.0.3
	itoa@1.0.3
	jobserver@0.1.24
	js-sys@0.3.59
	lazy_static@1.4.0
	lcov@0.8.1
	leb128@0.2.5
	libc@0.2.147
	libgit2-sys@0.16.1+1.7.1
	libssh2-sys@0.3.0
	libz-sys@1.1.8
	linux-raw-sys@0.1.3
	llvm_profparser@0.3.3
	log@0.4.17
	matchers@0.0.1
	matches@0.1.9
	md5@0.7.0
	memchr@2.6.3
	minimal-lexical@0.2.1
	miniz_oxide@0.5.3
	nix@0.27.1
	nom@7.1.1
	num-traits@0.2.15
	num_cpus@1.16.0
	object@0.26.2
	object@0.32.1
	once_cell@1.13.1
	openssl-probe@0.1.5
	openssl-src@111.25.0+1.1.1t
	openssl-sys@0.9.75
	percent-encoding@2.1.0
	pin-project-lite@0.2.9
	pkg-config@0.3.25
	proc-macro2@1.0.67
	procfs@0.15.1
	quick-error@1.2.3
	quick-xml@0.30.0
	quote@1.0.33
	redox_syscall@0.2.16
	regex-automata@0.1.10
	regex-automata@0.3.8
	regex-syntax@0.6.29
	regex-syntax@0.7.5
	regex@1.9.5
	remove_dir_all@0.5.3
	rustc-demangle@0.1.23
	rustc_version@0.4.0
	rustix@0.36.4
	rusty-fork@0.3.0
	ruzstd@0.4.0
	ryu@1.0.11
	same-file@1.0.6
	schannel@0.1.20
	semver@1.0.13
	serde@1.0.188
	serde_derive@1.0.188
	serde_json@1.0.107
	serde_spanned@0.6.3
	sharded-slab@0.1.4
	smallvec@1.9.0
	socket2@0.4.4
	stable_deref_trait@1.2.0
	static_assertions@1.1.0
	strsim@0.10.0
	syn@1.0.109
	syn@2.0.28
	tempfile@3.3.0
	thiserror-core-impl@1.0.38
	thiserror-core@1.0.38
	thiserror-impl@1.0.32
	thiserror@1.0.32
	thread_local@1.1.4
	tinyvec@1.6.0
	tinyvec_macros@0.1.0
	toml@0.8.0
	toml_datetime@0.6.3
	toml_edit@0.20.0
	tracing-attributes@0.1.24
	tracing-core@0.1.30
	tracing-log@0.1.3
	tracing-subscriber@0.2.25
	tracing@0.1.38
	twox-hash@1.6.3
	unicode-bidi@0.3.8
	unicode-ident@1.0.3
	unicode-normalization@0.1.21
	unicode-segmentation@1.10.1
	url@2.2.2
	utf8parse@0.2.1
	valuable@0.1.0
	vcpkg@0.2.15
	wait-timeout@0.2.0
	walkdir@2.4.0
	wasm-bindgen-backend@0.2.82
	wasm-bindgen-macro-support@0.2.82
	wasm-bindgen-macro@0.2.82
	wasm-bindgen-shared@0.2.82
	wasm-bindgen@0.2.82
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.36.1
	windows-sys@0.42.0
	windows-sys@0.48.0
	windows-targets@0.48.5
	windows_aarch64_gnullvm@0.42.0
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.36.1
	windows_aarch64_msvc@0.42.0
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.36.1
	windows_i686_gnu@0.42.0
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.36.1
	windows_i686_msvc@0.42.0
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.36.1
	windows_x86_64_gnu@0.42.0
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.42.0
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.36.1
	windows_x86_64_msvc@0.42.0
	windows_x86_64_msvc@0.48.5
	winnow@0.5.15
"

inherit cargo

DESCRIPTION="Cargo-Tarpaulin is a tool to determine code coverage achieved via tests"
HOMEPAGE="https://github.com/xd009642/tarpaulin"
SRC_URI="
	https://github.com/xd009642/tarpaulin/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/${P#cargo-}"

LICENSE="|| ( Apache-2.0 MIT )"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD MIT Unicode-DFS-2016 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="/usr/bin/cargo-tarpaulin"

PATCHES=(
	# integration tests require internet access
	"${FILESDIR}/cargo-tarpaulin-0.20.1-tests.patch"
	# test fails when not in a git repo
	"${FILESDIR}/cargo-tarpaulin-0.25.0-tests.patch"
)

DOCS=(
	CHANGELOG.md
	CONTRIBUTING.md
	README.md
)

src_install() {
	cargo_src_install

	dodoc "${DOCS[@]}"
}

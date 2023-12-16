# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	aes@0.8.3
	ahash@0.8.6
	aho-corasick@1.1.2
	allocator-api2@0.2.16
	amplify@4.5.0
	amplify_derive@4.0.0
	amplify_num@0.5.0
	amplify_syn@2.0.1
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.4
	anstyle-parse@0.2.2
	anstyle-query@1.0.0
	anstyle-wincon@3.0.1
	anstyle@1.0.4
	anyhow@1.0.75
	approx@0.5.1
	arbitrary@1.3.2
	arrayvec@0.7.4
	ascii@1.1.0
	assert-impl@0.1.3
	async-broadcast@0.6.0
	async-channel@1.9.0
	async-channel@2.1.1
	async-compression@0.4.5
	async-ctrlc@1.2.0
	async-executor@1.8.0
	async-global-executor@2.4.0
	async-io@1.13.0
	async-io@2.2.1
	async-lock@2.8.0
	async-lock@3.2.0
	async-native-tls@0.5.0
	async-process@1.8.1
	async-rustls@0.4.1
	async-signal@0.2.5
	async-std@1.12.0
	async-task@4.5.0
	async-trait@0.1.74
	async_executors@0.7.0
	asynchronous-codec@0.7.0
	atomic-waker@1.1.2
	atomic@0.5.3
	atty@0.2.14
	autocfg@1.1.0
	axum-core@0.3.4
	axum@0.6.20
	backtrace@0.3.69
	base16ct@0.2.0
	base64@0.13.1
	base64@0.21.5
	base64ct@1.6.0
	bitflags@1.3.2
	bitflags@2.4.1
	bitvec@1.0.1
	blake2@0.10.6
	blanket@0.3.0
	block-buffer@0.10.4
	blocking@1.5.1
	bounded-vec-deque@0.1.1
	bumpalo@3.14.0
	by_address@1.1.0
	bytemuck@1.14.0
	byteorder@1.5.0
	bytes@1.5.0
	cc@1.0.83
	cfg-if@1.0.0
	chrono@0.4.31
	cipher@0.4.4
	clap@4.4.10
	clap_builder@4.4.9
	clap_derive@4.4.7
	clap_lex@0.6.0
	coarsetime@0.1.33
	colorchoice@1.0.0
	concurrent-queue@2.4.0
	config@0.13.4
	const-oid@0.9.5
	convert_case@0.4.0
	core-foundation-sys@0.8.6
	core-foundation@0.9.4
	cpufeatures@0.2.11
	crc32fast@1.3.2
	crossbeam-channel@0.5.8
	crossbeam-queue@0.3.8
	crossbeam-utils@0.8.16
	crunchy@0.2.2
	crypto-bigint@0.5.5
	crypto-common@0.1.6
	ctr@0.9.2
	ctrlc@3.4.1
	curve25519-dalek-derive@0.1.1
	curve25519-dalek@4.1.1
	darling@0.14.4
	darling@0.20.3
	darling_core@0.14.4
	darling_core@0.20.3
	darling_macro@0.14.4
	darling_macro@0.20.3
	dashmap@5.5.3
	data-encoding@2.5.0
	der@0.7.8
	deranged@0.3.10
	derive-adhoc-macros@0.7.3
	derive-adhoc@0.7.3
	derive_arbitrary@1.3.2
	derive_builder_core_fork_arti@0.11.2
	derive_builder_fork_arti@0.11.2
	derive_builder_macro_fork_arti@0.11.2
	derive_more@0.99.17
	digest@0.10.7
	directories@5.0.1
	dirs-sys@0.4.1
	dirs@5.0.1
	displaydoc@0.2.4
	downcast-rs@1.2.0
	dyn-clone@1.0.16
	dynasm@2.0.0
	dynasmrt@2.0.0
	ecdsa@0.16.9
	ed25519-dalek@2.1.0
	ed25519@2.2.3
	educe@0.4.23
	either@1.9.0
	elliptic-curve@0.13.8
	enum-as-inner@0.6.0
	enum-ordinalize@3.1.15
	env_logger@0.5.13
	equivalent@1.0.1
	erased-serde@0.3.31
	errno@0.3.8
	event-listener-strategy@0.1.0
	event-listener-strategy@0.4.0
	event-listener@2.5.3
	event-listener@3.1.0
	event-listener@4.0.0
	fallible-iterator@0.3.0
	fallible-streaming-iterator@0.1.9
	fast-socks5@0.9.2
	fastrand@1.9.0
	fastrand@2.0.1
	ff@0.13.0
	fiat-crypto@0.2.5
	filetime@0.2.22
	fixed-capacity-vec@1.0.1
	flate2@1.0.28
	float-cmp@0.9.0
	float-ord@0.3.2
	float_eq@1.0.1
	fluid-let@1.0.0
	fnv@1.0.7
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	form_urlencoded@1.2.1
	fslock@0.2.1
	funty@2.0.0
	futures-await-test-macro@0.3.0
	futures-await-test@0.3.0
	futures-channel@0.3.29
	futures-core@0.3.29
	futures-executor@0.3.29
	futures-io@0.3.29
	futures-lite@1.13.0
	futures-lite@2.1.0
	futures-macro@0.3.29
	futures-sink@0.3.29
	futures-task@0.3.29
	futures-util@0.3.29
	futures@0.3.29
	generational-arena@0.2.9
	generic-array@0.14.7
	getrandom@0.2.11
	gimli@0.28.1
	glob-match@0.2.1
	gloo-timers@0.2.6
	group@0.13.0
	growable-bloom-filter@2.0.1
	hashbrown@0.12.3
	hashbrown@0.14.3
	hashlink@0.8.4
	heck@0.4.1
	hermit-abi@0.1.19
	hermit-abi@0.3.3
	hex-literal@0.4.1
	hex@0.4.3
	hickory-proto@0.24.0
	hkdf@0.12.3
	hmac@0.12.1
	hostname-validator@1.1.1
	http-body@0.4.5
	http@0.2.11
	http@1.0.0
	httparse@1.8.0
	httpdate@1.0.3
	humantime-serde@1.1.1
	humantime@1.3.0
	humantime@2.1.0
	hyper@0.14.27
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.58
	ident_case@1.0.1
	idna@0.4.0
	idna@0.5.0
	indexmap@1.9.3
	indexmap@2.1.0
	inotify-sys@0.1.5
	inotify@0.9.6
	inout@0.1.3
	instant@0.1.12
	inventory@0.3.13
	io-lifetimes@1.0.11
	ipnet@2.9.0
	itertools@0.11.0
	itertools@0.12.0
	itoa@1.0.9
	jobserver@0.1.27
	js-sys@0.3.66
	k12@0.3.0
	keccak@0.1.4
	kqueue-sys@1.0.4
	kqueue@1.0.8
	kv-log-macro@1.0.7
	lazy_static@1.4.0
	libc@0.2.150
	libm@0.2.8
	libredox@0.0.1
	libsqlite3-sys@0.27.0
	linux-raw-sys@0.3.8
	linux-raw-sys@0.4.12
	lock_api@0.4.11
	log@0.4.20
	lzma-sys@0.1.20
	matchers@0.1.0
	matchit@0.7.3
	matrixmultiply@0.3.8
	memchr@2.6.4
	memmap2@0.5.10
	memmap2@0.9.0
	merlin@3.0.0
	mime@0.3.17
	minimal-lexical@0.2.1
	miniz_oxide@0.7.1
	mio@0.8.9
	nalgebra-macros@0.1.0
	nalgebra@0.29.0
	native-tls@0.2.11
	nix@0.27.1
	nom@7.1.3
	notify@6.1.1
	nu-ansi-term@0.46.0
	num-bigint-dig@0.8.4
	num-bigint@0.4.4
	num-complex@0.4.4
	num-integer@0.1.45
	num-iter@0.1.43
	num-rational@0.4.1
	num-traits@0.2.17
	num_cpus@1.16.0
	num_enum@0.7.1
	num_enum_derive@0.7.1
	object@0.32.1
	once_cell@1.18.0
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-src@300.1.6+3.1.4
	openssl-sys@0.9.96
	openssl@0.10.60
	option-ext@0.2.0
	ordered-float@2.10.1
	overload@0.1.1
	p256@0.13.2
	p384@0.13.0
	p521@0.13.3
	parking@2.2.0
	parking_lot@0.12.1
	parking_lot_core@0.9.9
	paste@1.0.14
	pathdiff@0.2.1
	pem-rfc7468@0.7.0
	pem@0.8.3
	percent-encoding@2.3.1
	permutohedron@0.2.4
	phf@0.11.2
	phf_generator@0.11.2
	phf_macros@0.11.2
	phf_shared@0.11.2
	pin-project-internal@1.1.3
	pin-project-lite@0.2.13
	pin-project@1.1.3
	pin-utils@0.1.0
	piper@0.2.1
	pkcs1@0.7.5
	pkcs8@0.10.2
	pkg-config@0.3.27
	platforms@3.2.0
	polling@2.8.0
	polling@3.3.1
	postage@0.5.0
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	primeorder@0.13.6
	priority-queue@1.3.2
	proc-macro-crate@1.3.1
	proc-macro-crate@2.0.0
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.70
	pwd-grp@0.1.1
	quick-error@1.2.3
	quote@1.0.33
	radium@0.7.0
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rand_distr@0.4.3
	rangemap@1.4.0
	rawpointer@0.2.1
	redox_syscall@0.3.5
	redox_syscall@0.4.1
	redox_users@0.4.4
	regex-automata@0.1.10
	regex-automata@0.4.3
	regex-syntax@0.6.29
	regex-syntax@0.8.2
	regex@1.10.2
	retain_mut@0.1.9
	rfc6979@0.4.0
	ring@0.16.20
	ring@0.17.6
	rlimit@0.10.1
	rmp-serde@1.1.2
	rmp@0.8.12
	rsa@0.9.6
	rusqlite@0.30.0
	rustc-demangle@0.1.23
	rustc_version@0.4.0
	rustix@0.37.27
	rustix@0.38.26
	rustls-webpki@0.101.7
	rustls@0.21.9
	rustversion@1.0.14
	ryu@1.0.15
	safe_arch@0.7.1
	same-file@1.0.6
	sanitize-filename@0.5.0
	schannel@0.1.22
	scopeguard@1.2.0
	sct@0.7.1
	sec1@0.7.3
	secmem-proc@0.3.2
	security-framework-sys@2.9.1
	security-framework@2.9.2
	semver@1.0.20
	serde-value@0.7.0
	serde@1.0.193
	serde_bytes@0.11.12
	serde_derive@1.0.193
	serde_ignored@0.1.9
	serde_json@1.0.108
	serde_path_to_error@0.1.14
	serde_repr@0.1.17
	serde_spanned@0.6.4
	serde_test@1.0.176
	serde_urlencoded@0.7.1
	serde_with@3.4.0
	serde_with_macros@3.4.0
	serial_test@2.0.0
	serial_test_derive@2.0.0
	sha1-asm@0.5.2
	sha1@0.10.6
	sha2@0.10.8
	sha3@0.10.8
	sharded-slab@0.1.7
	shellexpand@3.1.0
	signal-hook-async-std@0.2.2
	signal-hook-registry@1.4.1
	signal-hook@0.3.17
	signature@1.6.4
	signature@2.2.0
	simba@0.6.0
	simple_asn1@0.6.2
	siphasher@0.3.11
	slab@0.4.9
	slotmap@1.0.7
	smallvec@1.11.2
	socket2@0.4.10
	socket2@0.5.5
	spin@0.5.2
	spin@0.9.8
	spki@0.7.3
	ssh-cipher@0.2.0
	ssh-encoding@0.2.0
	ssh-key@0.6.3
	static_assertions@1.1.0
	statrs@0.16.0
	strsim@0.10.0
	strum@0.25.0
	strum_macros@0.25.3
	subtle@2.5.0
	syn@1.0.109
	syn@2.0.39
	sync_wrapper@0.1.2
	tap@1.0.1
	tempfile@3.8.1
	termcolor@1.4.0
	terminal_size@0.3.0
	test-cert-gen@0.9.0
	thiserror-impl@1.0.50
	thiserror@1.0.50
	thread_local@1.1.7
	time-core@0.1.2
	time-macros@0.2.15
	time@0.3.30
	tiny-keccak@2.0.2
	tinystr@0.7.5
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tls-api-native-tls@0.9.0
	tls-api-openssl@0.9.0
	tls-api-test@0.9.0
	tls-api@0.9.0
	tokio-macros@2.2.0
	tokio-socks@0.5.1
	tokio-stream@0.1.14
	tokio-util@0.7.10
	tokio@1.34.0
	toml@0.5.11
	toml@0.7.8
	toml_datetime@0.6.5
	toml_edit@0.19.15
	toml_edit@0.20.7
	tower-layer@0.3.2
	tower-service@0.3.2
	tower@0.4.13
	tracing-appender@0.2.3
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing-journald@0.3.0
	tracing-log@0.2.0
	tracing-subscriber@0.3.18
	tracing-test-macro@0.2.4
	tracing-test@0.2.4
	tracing@0.1.40
	try-lock@0.2.4
	typed-index-collections@3.1.0
	typenum@1.17.0
	typetag-impl@0.2.13
	typetag@0.2.13
	unicode-bidi@0.3.13
	unicode-ident@1.0.12
	unicode-normalization@0.1.22
	untrusted@0.6.2
	untrusted@0.7.1
	untrusted@0.9.0
	url@2.5.0
	utf8parse@0.2.1
	valuable@0.1.0
	value-bag@1.4.2
	vcpkg@0.2.15
	version_check@0.9.4
	visibility@0.1.0
	visible@0.0.1
	void@1.0.2
	waker-fn@1.1.1
	walkdir@2.4.0
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.89
	wasm-bindgen-futures@0.4.39
	wasm-bindgen-macro-support@0.2.89
	wasm-bindgen-macro@0.2.89
	wasm-bindgen-shared@0.2.89
	wasm-bindgen@0.2.89
	weak-table@0.3.2
	web-sys@0.3.66
	webpki@0.22.4
	wide@0.7.13
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.51.1
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.0
	windows@0.48.0
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.0
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.0
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.0
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.0
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.0
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.0
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.0
	winnow@0.5.19
	wyz@0.5.1
	x25519-dalek@2.0.0
	x509-signature@0.5.0
	xxhash-rust@0.8.7
	xz2@0.1.7
	zerocopy-derive@0.7.28
	zerocopy@0.7.28
	zeroize@1.7.0
	zeroize_derive@1.4.2
	zstd-safe@7.0.0
	zstd-sys@2.0.9+zstd.1.5.5
	zstd@0.13.0
"

inherit cargo

MY_P="${PN}-${PN}-v${PV}"

DESCRIPTION="An implementation of Tor, in Rust."
HOMEPAGE="https://gitlab.torproject.org/tpo/core/arti/"

if [[ "${PV}" == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.torproject.org/tpo/core/arti"
else
	SRC_URI="https://gitlab.torproject.org/tpo/core/${PN}/-/archive/${PN}-v${PV}/${PN}-${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2
		${CARGO_CRATE_URIS}"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="MIT Apache-2.0"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD Boost-1.0 CC0-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016
	Unlicense ZLIB
"
SLOT="0"

DEPEND="app-arch/xz-utils
	dev-db/sqlite:3
	dev-libs/openssl:="
RDEPEND="${DEPEND}"

QA_FLAGS_IGNORED="usr/bin/arti"

src_unpack() {
	if [[ "${PV}" == *9999 ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_compile() {
	for crate in crates/*; do
		pushd crates/arti || die
		cargo_src_compile
		popd >/dev/null || die
	done
}

src_install() {
	pushd crates/arti >/dev/null || due

	cargo_src_install
	newdoc src/arti-example-config.toml arti.toml

	popd >/dev/null || die

	dodoc -r doc/*
}

# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.6.3

EAPI=8

CRATES="
	adler-1.0.2
	anstream-0.6.5
	anstyle-1.0.4
	anstyle-parse-0.2.3
	anstyle-query-1.0.2
	anstyle-wincon-3.0.2
	anyhow-1.0.75
	arc-swap-1.6.0
	autocfg-1.1.0
	bitflags-1.3.2
	bitflags-2.4.1
	bstr-1.8.0
	btoi-0.4.3
	bzip2-rs-0.1.2
	cc-1.0.83
	cfg-if-1.0.0
	clap-4.4.11
	clap_builder-4.4.11
	clap_lex-0.6.0
	clru-0.6.1
	colorchoice-1.0.0
	crc32fast-1.3.2
	ctrlc-3.4.1
	curl-0.4.44
	curl-sys-0.4.70+curl-8.5.0
	deranged-0.3.10
	dunce-1.0.4
	encoding_rs-0.8.33
	equivalent-1.0.1
	errno-0.3.8
	faster-hex-0.9.0
	fastrand-2.0.1
	filetime-0.2.23
	flate2-1.0.28
	form_urlencoded-1.2.1
	gix-0.56.0
	gix-actor-0.28.1
	gix-bitmap-0.2.8
	gix-chunk-0.4.5
	gix-commitgraph-0.22.1
	gix-config-0.32.1
	gix-config-value-0.14.1
	gix-date-0.8.1
	gix-diff-0.38.0
	gix-discover-0.27.0
	gix-features-0.36.1
	gix-fs-0.8.1
	gix-glob-0.14.1
	gix-hash-0.13.3
	gix-hashtable-0.4.1
	gix-index-0.27.1
	gix-lock-11.0.1
	gix-macros-0.1.1
	gix-object-0.39.0
	gix-odb-0.55.0
	gix-pack-0.45.0
	gix-path-0.10.1
	gix-quote-0.4.8
	gix-ref-0.39.0
	gix-refspec-0.20.0
	gix-revision-0.24.0
	gix-revwalk-0.10.0
	gix-sec-0.10.1
	gix-tempfile-11.0.1
	gix-trace-0.1.4
	gix-traverse-0.35.0
	gix-url-0.25.2
	gix-utils-0.1.6
	gix-validate-0.8.1
	hashbrown-0.14.3
	hermit-abi-0.3.3
	home-0.5.5
	idna-0.5.0
	indexmap-2.1.0
	is-terminal-0.4.9
	itoa-1.0.10
	libc-0.2.151
	libz-sys-1.1.12
	linux-raw-sys-0.4.12
	lock_api-0.4.11
	memchr-2.6.4
	memmap2-0.9.0
	minimal-lexical-0.2.1
	miniz_oxide-0.7.1
	nix-0.27.1
	nom-7.1.3
	num-traits-0.2.17
	num_threads-0.1.6
	once_cell-1.19.0
	openssl-probe-0.1.5
	openssl-sys-0.9.97
	parking_lot-0.12.1
	parking_lot_core-0.9.9
	percent-encoding-2.3.1
	pkg-config-0.3.27
	powerfmt-0.2.0
	proc-macro2-1.0.70
	prodash-26.2.2
	quote-1.0.33
	redox_syscall-0.4.1
	regex-automata-0.4.3
	rustix-0.38.28
	ryu-1.0.16
	same-file-1.0.6
	schannel-0.1.22
	scopeguard-1.2.0
	serde-1.0.193
	serde_derive-1.0.193
	serde_json-1.0.108
	sha1_smol-1.0.0
	smallvec-1.11.2
	socket2-0.4.10
	strsim-0.10.0
	syn-2.0.39
	tar-0.4.40
	tempfile-3.8.1
	termcolor-1.4.0
	terminal_size-0.3.0
	thiserror-1.0.50
	thiserror-impl-1.0.50
	time-0.3.30
	time-core-0.1.2
	time-macros-0.2.15
	tinyvec-1.6.0
	tinyvec_macros-0.1.1
	unicode-bidi-0.3.14
	unicode-bom-2.0.3
	unicode-ident-1.0.12
	unicode-normalization-0.1.22
	url-2.5.0
	utf8parse-0.2.1
	vcpkg-0.2.15
	walkdir-2.4.0
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.6
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-0.48.0
	windows-sys-0.48.0
	windows-sys-0.52.0
	windows-targets-0.48.5
	windows-targets-0.52.0
	windows_aarch64_gnullvm-0.48.5
	windows_aarch64_gnullvm-0.52.0
	windows_aarch64_msvc-0.48.5
	windows_aarch64_msvc-0.52.0
	windows_i686_gnu-0.48.5
	windows_i686_gnu-0.52.0
	windows_i686_msvc-0.48.5
	windows_i686_msvc-0.52.0
	windows_x86_64_gnu-0.48.5
	windows_x86_64_gnu-0.52.0
	windows_x86_64_gnullvm-0.48.5
	windows_x86_64_gnullvm-0.52.0
	windows_x86_64_msvc-0.48.5
	windows_x86_64_msvc-0.52.0
	winnow-0.5.26
	xattr-1.1.2
"

inherit cargo flag-o-matic

DESCRIPTION="Stack-based patch management for Git"
HOMEPAGE="https://stacked-git.github.io/"
SRC_URI="$(cargo_crate_uris)"
SRC_URI+=" https://github.com/stacked-git/stgit/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD MIT Unicode-DFS-2016"
SLOT="0/2"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~riscv ~x86"
IUSE="doc"

DEPEND="doc? ( app-text/asciidoc )"
RDEPEND=""

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/stg"

src_configure() {
	filter-lto #bug 897692
}

src_compile() {
	cargo_src_compile
	emake completion
	emake contrib
	use doc && emake doc
}

src_install() {
	cargo_src_install
	emake DESTDIR="${D}" prefix="/usr" install-completion
	emake DESTDIR="${D}" prefix="/usr" install-contrib
	if use doc; then
		emake DESTDIR="${D}" prefix="/usr" install-man
		emake DESTDIR="${D}" prefix="/usr" \
			htmldir="/usr/share/doc/${PF}"  \
			install-html
	fi
}

# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.1

EAPI=8

CRATES="
	aho-corasick-0.7.18
	ansi_term-0.12.1
	archery-0.4.0
	atty-0.2.14
	autocfg-1.1.0
	bitflags-1.3.2
	bumpalo-3.9.1
	bytecount-0.6.2
	cc-1.0.73
	cfg-if-1.0.0
	clap-3.1.18
	clap_lex-0.2.0
	const_format-0.2.23
	const_format_proc_macros-0.2.22
	crossbeam-channel-0.5.4
	crossbeam-deque-0.8.1
	crossbeam-epoch-0.9.8
	crossbeam-utils-0.8.8
	ctor-0.1.22
	diff-0.1.12
	either-1.6.1
	env_logger-0.7.1
	fixedbitset-0.4.1
	fnv-1.0.7
	hashbrown-0.11.2
	hermit-abi-0.1.19
	humantime-1.3.0
	indexmap-1.7.0
	itertools-0.10.3
	lazy_static-1.4.0
	libc-0.2.126
	libmimalloc-sys-0.1.24
	log-0.4.17
	memchr-2.5.0
	memoffset-0.6.5
	mimalloc-0.1.28
	minimal-lexical-0.2.1
	nom-7.1.1
	num_cpus-1.13.1
	once_cell-1.12.0
	os_str_bytes-6.0.1
	output_vt100-0.1.3
	owo-colors-3.4.0
	petgraph-0.6.1
	pretty_assertions-1.2.1
	pretty_env_logger-0.4.0
	proc-macro2-1.0.39
	quick-error-1.2.3
	quote-1.0.18
	radix-heap-0.4.2
	rayon-1.5.3
	rayon-core-1.9.3
	regex-1.5.6
	regex-syntax-0.6.26
	rpds-0.10.0
	rustc-hash-1.1.0
	same-file-1.0.6
	scopeguard-1.1.0
	static_assertions-1.1.0
	strsim-0.10.0
	syn-1.0.95
	term_size-0.3.2
	termcolor-1.1.3
	terminal_size-0.1.17
	textwrap-0.15.0
	tree-sitter-0.20.6
	tree_magic_mini-3.0.3
	typed-arena-2.0.1
	unicode-ident-1.0.0
	unicode-width-0.1.9
	unicode-xid-0.2.3
	walkdir-2.3.2
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	wu-diff-0.1.2
"

inherit cargo

DESCRIPTION="A structural diff that understands syntax."
# Double check the homepage as the cargo_metadata crate
# does not provide this value so instead repository is used
HOMEPAGE="https://github.com/wilfred/difftastic"
SRC_URI="
	$(cargo_crate_uris ${CRATES})
	https://github.com/Wilfred/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz
"

# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="Apache-2.0 MIT MPL-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/bin/difft"

DOCS=(
	CHANGELOG.md
	README.md
	manual/
)

src_prepare() {
	rm manual/.gitignore || die
	default
}

src_install() {
	cargo_src_install
	dodoc -r "${DOCS[@]}"
}

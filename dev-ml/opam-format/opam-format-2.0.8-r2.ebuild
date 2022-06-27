# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# We are opam
OPAM_INSTALLER_DEP=" "
inherit dune

DESCRIPTION="Core libraries for opam"
HOMEPAGE="https://opam.ocaml.org/ https://github.com/ocaml/opam"
SRC_URI="https://github.com/ocaml/opam/archive/${PV/_/-}.tar.gz -> opam-${PV}.tar.gz"
S="${WORKDIR}/opam-${PV}"
OPAM_INSTALLER="${S}/opam-installer"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="amd64 arm arm64 ~ppc ppc64 x86"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="
	<dev-lang/ocaml-4.12
	~dev-ml/opam-core-${PV}:=
	dev-ml/re:=
	dev-ml/opam-file-format:=
	dev-ml/dose3:=
"
DEPEND="${RDEPEND}
	dev-ml/cppo"
BDEPEND="test? (
	sys-apps/bubblewrap
	dev-ml/mccs
)"

src_prepare() {
	default
	cat <<- EOF >> "${S}/dune"
		(env
		 (dev
		  (flags (:standard -warn-error -3-9-33)))
		 (release
		  (flags (:standard -warn-error -3-9-33))))
	EOF
}

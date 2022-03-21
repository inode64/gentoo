# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Skeleton command:
# java-ebuilder --generate-ebuild --workdir . --pom pom.xml --download-uri https://github.com/FasterXML/jackson-dataformats-text/archive/refs/tags/jackson-dataformats-text-2.13.0.tar.gz --slot 0 --keywords "~amd64 ~arm ~arm64 ~ppc64 ~x86" --ebuild jackson-dataformat-yaml-2.13.0.ebuild

EAPI=8

JAVA_PKG_IUSE="doc source test"
MAVEN_ID="com.fasterxml.jackson.dataformat:jackson-dataformat-yaml:2.13.0"
JAVA_TESTING_FRAMEWORKS="junit-4"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Support for reading and writing YAML-encoded data via Jackson abstractions"
HOMEPAGE="https://github.com/FasterXML/jackson-dataformats-text"
SRC_URI="https://github.com/FasterXML/jackson-dataformats-text/archive/refs/tags/jackson-dataformats-text-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ppc64 x86"

# Common dependencies
# POM: pom.xml
# com.fasterxml.jackson.core:jackson-core:2.13.0 -> >=dev-java/jackson-core-2.13.0:0
# com.fasterxml.jackson.core:jackson-databind:2.13.0 -> >=dev-java/jackson-databind-2.13.0:0
# org.yaml:snakeyaml:1.28 -> >=dev-java/snakeyaml-1.28:0

CP_DEPEND="
	dev-java/jackson-core:0
	dev-java/jackson-databind:0
	dev-java/snakeyaml:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8:*"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8:*"

DOCS=( README.md release-notes/{CREDITS,VERSION} )

S="${WORKDIR}/jackson-dataformats-text-jackson-dataformats-text-${PV}/yaml"

JAVA_SRC_DIR=( "src/main/java" "src/moditect" )
JAVA_RESOURCE_DIRS="src/main/resources"

JAVA_TEST_GENTOO_CLASSPATH="junit-4"
JAVA_TEST_SRC_DIR="src/test/java"
JAVA_TEST_RESOURCE_DIRS="src/test/resources"
JAVA_TEST_EXCLUDES=(
	# Upstream doesn't run these tests and gets
	# »Tests run: 121, Failures: 0, Errors: 0, Skipped: 0«
	com.fasterxml.jackson.dataformat.yaml.failing.ObjectIdWithTree2Test
	com.fasterxml.jackson.dataformat.yaml.failing.PolymorphicWithObjectId25Test
	com.fasterxml.jackson.dataformat.yaml.failing.SimpleGeneration215Test
)

src_prepare() {
	default
	java-pkg-2_src_prepare

	sed -e 's:@package@:com.fasterxml.jackson.dataformat.yaml:g' \
		-e "s:@projectversion@:${PV}:g" \
		-e 's:@projectgroupid@:com.fasterxml.jackson.dataformat:g' \
		-e "s:@projectartifactid@:${PN}:g" \
		"${JAVA_SRC_DIR}/com/fasterxml/jackson/dataformat/yaml/PackageVersion.java.in" \
		> "${JAVA_SRC_DIR}/com/fasterxml/jackson/dataformat/yaml/PackageVersion.java" || die

	# dev-java/snakeyaml-1.28-r1 does not provide module-info
	sed -e '/snakeyaml;/d' -i src/moditect/module-info.java || die
}

src_install() {
	default # https://bugs.gentoo.org/789582
	java-pkg-simple_src_install
}

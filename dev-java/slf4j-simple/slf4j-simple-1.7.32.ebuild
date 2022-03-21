# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Skeleton command:
# java-ebuilder --generate-ebuild --workdir . --pom pom.xml --download-uri https://github.com/qos-ch/slf4j/archive/refs/tags/v_1.7.32.tar.gz --slot 0 --keywords "~amd64 ~arm ~arm64 ~ppc64 ~x86" --ebuild slf4j-simple-1.7.32.ebuild

EAPI=8

JAVA_PKG_IUSE="doc source test"
MAVEN_ID="org.slf4j:slf4j-simple:1.7.32"
JAVA_TESTING_FRAMEWORKS="junit-4"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="SLF4J Simple binding"
HOMEPAGE="https://www.slf4j.org"
SRC_URI="https://github.com/qos-ch/slf4j/archive/refs/tags/v_${PV}.tar.gz -> slf4j-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ppc64 x86"

# Common dependencies
# POM: pom.xml
# org.slf4j:slf4j-api:1.7.32 -> >=dev-java/slf4j-api-1.7.32:0

CP_DEPEND="
	~dev-java/slf4j-api-${PV}:0
"

# Compile dependencies
# POM: slf4j-v_${PV}/${PN}/pom.xml
# test? junit:junit:4.12 -> >=dev-java/junit-4.12:4
# test? org.slf4j:slf4j-api:1.7.30 -> >=dev-java/slf4j-api-1.7.30:0

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8:*
	test? (
		~dev-java/slf4j-api-${PV}:0
	)"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8:*"

DOCS=( LICENSE.txt ../README.md )

S="${WORKDIR}/slf4j-v_${PV}/${PN}"

JAVA_SRC_DIR="src/main/java"
JAVA_RESOURCE_DIRS="src/main/resources"

JAVA_TEST_GENTOO_CLASSPATH="junit-4,slf4j-api"
JAVA_TEST_SRC_DIR="src/test/java"
JAVA_TEST_RESOURCE_DIRS="src/test/resources"

JAVA_TEST_EXCLUDES=(
	# java.lang.InstantiationException
	"org.slf4j.helpers.MultithreadedInitializationTest"

	# java.lang.AssertionError: 1284 < 1263+16
	"org.slf4j.helpers.SimpleLoggerMultithreadedInitializationTest"
)

src_prepare() {
	default
	java-pkg_clean
	cp "../slf4j-api/src/test/java/org/slf4j/helpers/MultithreadedInitializationTest.java" \
		"${JAVA_TEST_SRC_DIR}/org/slf4j/helpers/" || die
	cp "../slf4j-api/src/test/java/org/slf4j/LoggerAccessingThread.java" \
		"${JAVA_TEST_SRC_DIR}/org/slf4j/" || die
}

src_install() {
	default # https://bugs.gentoo.org/789582
	java-pkg-simple_src_install
}

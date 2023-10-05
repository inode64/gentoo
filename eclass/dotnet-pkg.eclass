# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: dotnet-pkg.eclass
# @MAINTAINER:
# Gentoo Dotnet project <dotnet@gentoo.org>
# @AUTHOR:
# Anna Figueiredo Gomes <navi@vlhl.dev>
# Maciej Barć <xgqt@gentoo.org>
# @SUPPORTED_EAPIS: 8
# @PROVIDES: dotnet-pkg-base nuget
# @BLURB: common functions and variables for .NET packages
# @DESCRIPTION:
# This eclass is designed to help with building and installing packages that
# use the .NET SDK.
# It provides the required phase functions and special variables that make
# it easier to write ebuilds for .NET packages.
# If you do not use the exported phase functions, then consider using
# the "dotnet-pkg-base.eclass" instead.
#
# .NET SDK is a open-source framework from Microsoft, it is a cross-platform
# successor to .NET Framework.
#
# .NET packages require proper inspection before packaging:
# - the compatible .NET SDK version has to be declared,
#   this can be done by inspecting the package's "*.proj" files,
#   unlike JAVA, .NET packages tend to lock onto one exact selected .NET SDK
#   version, so building with other .NET versions will be mostly unsupported,
# - Nugets, packages' .NET dependencies, which are similar to JAVA's JARs,
#   have to be listed using either the "NUGETS" variable or bundled inside
#   a "prebuilt" archive, in second case also the "NUGET_PACKAGES" variable
#   has to be explicitly set.
# - the main project file (*.proj) that builds the project has to be specified
#   by the "DOTNET_PROJECT" variable.

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_DOTNET_PKG_ECLASS} ]] ; then
_DOTNET_PKG_ECLASS=1

inherit dotnet-pkg-base

# Append to "RDEPEND" and "BDEPEND" "DOTNET_PKG_RDEPS" and "DOTNET_PKG_BDEPS"
# generated by "dotnet-pkg-base" eclass.
RDEPEND+=" ${DOTNET_PKG_RDEPS} "
BDEPEND+=" ${DOTNET_PKG_BDEPS} "

# @ECLASS_VARIABLE: DOTNET_PKG_PROJECTS
# @DEFAULT_UNSET
# @DESCRIPTION:
# Path to the main .NET project files (".csproj", ".fsproj", ".vbproj")
# used by default by "dotnet-pkg_src_compile" phase function.
#
# In .NET version 6.0 and lower it was possible to build a project solution
# (".sln") immediately with output to a specified directory ("--output DIR"),
# but versions >= 7.0 deprecated this behavior. This means that
# "dotnet-pkg-base_build" will fail when pointed to a solution or a directory
# containing a solution file.
#
# It is up to the maintainer if this variable is set before inheriting
# "dotnet-pkg-base" eclass, but it is advised that it is set after
# the variable "${S}" is set, it should also integrate with it
# (see the example below).
#
# Example:
# @CODE
# SRC_URI="..."
# S="${WORKDIR}/${P}/src"
#
# LICENSE="MIT"
# SLOT="0"
# KEYWORDS="~amd64"
#
# DOTNET_PKG_PROJECTS=( "${S}/DotnetProject" )
#
# src_prepare() {
#     ...
# @CODE

# @ECLASS_VARIABLE: DOTNET_PKG_RESTORE_EXTRA_ARGS
# @DESCRIPTION:
# Extra arguments to pass to the package restore, in the "src_configure" phase.
#
# This is passed only when restoring the specified "DOTNET_PROJECT".
# Other project restorers do not use this variable.
#
# It is up to the maintainer if this variable is set before inheriting
# "dotnet-pkg.eclass", but it is advised that it is set after the variable
# "DOTNET_PROJECT" (from "dotnet-pkg-base" eclass) is set.
#
# Default value is an empty array.
#
# For more info see the "DOTNET_PROJECT" variable and "dotnet-pkg_src_configure".
DOTNET_PKG_RESTORE_EXTRA_ARGS=()

# @ECLASS_VARIABLE: DOTNET_PKG_BUILD_EXTRA_ARGS
# @DESCRIPTION:
# Extra arguments to pass to the package build, in the "src_compile" phase.
#
# This is passed only when building the specified "DOTNET_PROJECT".
# Other project builds do not use this variable.
#
# It is up to the maintainer if this variable is set before inheriting
# "dotnet-pkg.eclass", but it is advised that it is set after the variable
# "DOTNET_PROJECT" (from "dotnet-pkg-base" eclass) is set.
#
# Default value is an empty array.
#
# Example:
# @CODE
# DOTNET_PKG_BUILD_EXTRA_ARGS=( -p:WarningLevel=0 )
# @CODE
#
# For more info see the "DOTNET_PROJECT" variable and "dotnet-pkg_src_compile".
DOTNET_PKG_BUILD_EXTRA_ARGS=()

# @FUNCTION: dotnet-pkg_pkg_setup
# @DESCRIPTION:
# Default "pkg_setup" for the "dotnet-pkg" eclass.
# Pre-build configuration and checks.
#
# Calls "dotnet-pkg-base_pkg_setup".
dotnet-pkg_pkg_setup() {
	[[ ${MERGE_TYPE} != binary ]] && dotnet-pkg-base_setup
}

# @FUNCTION: dotnet-pkg_src_unpack
# @DESCRIPTION:
# Default "src_unpack" for the "dotnet-pkg" eclass.
# Unpack the package sources.
#
# Includes a special exception for nugets (".nupkg" files) - they are instead
# copied into the "NUGET_PACKAGES" directory.
dotnet-pkg_src_unpack() {
	nuget_link-system-nugets
	nuget_link-nuget-archives
	nuget_unpack-non-nuget-archives
}

# @FUNCTION: dotnet-pkg_src_prepare
# @DESCRIPTION:
# Default "src_prepare" for the "dotnet-pkg" eclass.
# Prepare the package sources.
#
# Run "dotnet-pkg-base_remove-global-json".
dotnet-pkg_src_prepare() {
	dotnet-pkg-base_remove-global-json

	default
}

# @FUNCTION: dotnet-pkg_foreach-project
# @USAGE: <args> ...
# @DESCRIPTION:
# Run a specified command for each project listed inside the "DOTNET_PKG_PROJECTS"
# variable.
#
# Used by "dotnet-pkg_src_configure" and "dotnet-pkg_src_compile".
dotnet-pkg_foreach-project() {
	debug-print-function "${FUNCNAME[0]}" "${@}"

	local dotnet_project
	for dotnet_project in "${DOTNET_PKG_PROJECTS[@]}" ; do
		ebegin "Running \"${*}\" for project: \"${dotnet_project##*/}\""
		"${@}" "${dotnet_project}"
		eend $? "${FUNCNAME[0]}: failed for project: \"${dotnet_project}\"" || die
	done
}

# @FUNCTION: dotnet-pkg_src_configure
# @DESCRIPTION:
# Default "src_configure" for the "dotnet-pkg" eclass.
# Configure the package.
#
# First show information about current .NET SDK that is being used,
# then restore the project file specified by "DOTNET_PROJECT",
# afterwards restore any found solutions.
dotnet-pkg_src_configure() {
	dotnet-pkg-base_info

	dotnet-pkg_foreach-project \
		dotnet-pkg-base_restore "${DOTNET_PKG_RESTORE_EXTRA_ARGS[@]}"

	dotnet-pkg-base_foreach-solution \
		"$(pwd)" \
		dotnet-pkg-base_restore "${DOTNET_PKG_RESTORE_EXTRA_ARGS[@]}"
}

# @FUNCTION: dotnet-pkg_src_compile
# @DESCRIPTION:
# Default "src_compile" for the "dotnet-pkg" eclass.
# Build the package.
#
# Build the package using "dotnet build" in the directory specified by either
# "DOTNET_PROJECT" or "S" (temporary build directory) variables.
#
# For more info see: "DOTNET_PROJECT" variable
# and "dotnet-pkg-base_get-project" function.
dotnet-pkg_src_compile() {
	dotnet-pkg_foreach-project \
		dotnet-pkg-base_build "${DOTNET_PKG_BUILD_EXTRA_ARGS[@]}"
}

# @FUNCTION: dotnet-pkg_src_test
# @DESCRIPTION:
# Default "src_test" for the "dotnet-pkg" eclass.
# Test the package.
#
# Test the package by testing any found solutions.
#
# It is very likely that this function will either not execute any tests or
# will execute wrong or incomplete test suite. Maintainers should inspect if
# any and/or correct tests are ran.
dotnet-pkg_src_test() {
	dotnet-pkg-base_foreach-solution "$(pwd)" dotnet-pkg-base_test
}

# @FUNCTION: dotnet-pkg_src_install
# @DESCRIPTION:
# Default "src_install" for the "dotnet-pkg" eclass.
# Install the package.
#
# This is the default package install:
#   - install the compiled .NET package artifacts,
#	  for more info see "dotnet-pkg-base_install" and "DOTNET_PKG_OUTPUT",
#   - create launcher from the .NET package directory to "/usr/bin",
#     phase will detect to choose either executable with capital letter
#     (common among .NET packages) or not,
#   - call "einstalldocs".
#
# It is very likely that this function is either insufficient or has to be
# redefined in a ebuild.
dotnet-pkg_src_install() {
	dotnet-pkg-base_install

	# /usr/bin/Nake -> /usr/share/nake-3.0.0/Nake
	if [[ -f "${D}/usr/share/${P}/${PN^}" ]] ; then
		dotnet-pkg-base_dolauncher "/usr/share/${P}/${PN^}"

		# Create a compatibility symlink and also for ease of use from CLI.
		dosym -r "/usr/bin/${PN^}" "/usr/bin/${PN}"

	elif [[ -f "${D}/usr/share/${P}/${PN}" ]] ; then
		dotnet-pkg-base_dolauncher "/usr/share/${P}/${PN}"
	fi

	einstalldocs
}

fi

EXPORT_FUNCTIONS pkg_setup src_unpack src_prepare src_configure src_compile src_test src_install

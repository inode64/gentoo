# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MODULES_OPTIONAL_USE="driver"
inherit desktop flag-o-matic linux-mod multilib readme.gentoo-r1 \
	systemd toolchain-funcs unpacker

NV_KERNEL_MAX="5.15"
NV_URI="https://download.nvidia.com/XFree86/"

DESCRIPTION="NVIDIA Accelerated Graphics Driver"
HOMEPAGE="https://www.nvidia.com/download/index.aspx"
SRC_URI="
	amd64? ( ${NV_URI}Linux-x86_64/${PV}/NVIDIA-Linux-x86_64-${PV}.run )
	x86? ( ${NV_URI}Linux-x86/${PV}/NVIDIA-Linux-x86-${PV}.run )
	$(printf "${NV_URI}%s/%s-${PV}.tar.bz2 " \
		nvidia-{installer,modprobe,persistenced,settings,xconfig}{,})"
# nvidia-installer is unused but here for GPL-2's "distribute sources"
S="${WORKDIR}"

LICENSE="NVIDIA-r2 BSD BSD-2 GPL-2 MIT"
SLOT="0/${PV%%.*}"
KEYWORDS="-* amd64 x86"
IUSE="+X abi_x86_32 abi_x86_64 +driver persistenced static-libs +tools"

COMMON_DEPEND="
	acct-group/video
	sys-libs/glibc
	persistenced? (
		acct-user/nvpd
		net-libs/libtirpc:=
	)
	tools? (
		dev-libs/atk
		dev-libs/glib:2
		dev-libs/jansson:=
		media-libs/harfbuzz:=
		x11-libs/cairo
		x11-libs/gdk-pixbuf:2
		x11-libs/gtk+:3
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXxf86vm
		x11-libs/pango
	)"
RDEPEND="
	${COMMON_DEPEND}
	X? (
		media-libs/libglvnd[X,abi_x86_32(-)?]
		x11-libs/libX11[abi_x86_32(-)?]
		x11-libs/libXext[abi_x86_32(-)?]
	)"
DEPEND="
	${COMMON_DEPEND}
	static-libs? (
		x11-libs/libX11
		x11-libs/libXext
	)
	tools? (
		media-libs/libglvnd
		sys-apps/dbus
		x11-base/xorg-proto
		x11-libs/libXrandr
		x11-libs/libXv
		x11-libs/libvdpau
	)"
BDEPEND="
	sys-devel/m4
	virtual/pkgconfig"

QA_PREBUILT="opt/bin/* usr/lib*"

PATCHES=(
	"${FILESDIR}"/nvidia-modprobe-390.141-uvm-perms.patch
	"${FILESDIR}"/nvidia-settings-390.141-fno-common.patch
	"${FILESDIR}"/nvidia-settings-390.144-desktop.patch
	"${FILESDIR}"/nvidia-settings-390.144-no-gtk2.patch
	"${FILESDIR}"/nvidia-settings-390.144-raw-ldflags.patch
)

pkg_setup() {
	use driver || return

	local CONFIG_CHECK="
		PROC_FS
		~DRM_KMS_HELPER
		~SYSVIPC
		~!AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
		~!LOCKDEP
		!DEBUG_MUTEXES"
	local ERROR_DRM_KMS_HELPER="CONFIG_DRM_KMS_HELPER: is not set but needed for Xorg auto-detection
	of drivers (no custom config), and optional nvidia-drm.modeset=1.
	With 390.xx drivers, also used by a GLX workaround needed for OpenGL.
	Cannot be directly selected in the kernel's menuconfig, and may need
	selection of a DRM device even if unused, e.g. CONFIG_DRM_AMDGPU=m or
	DRM_I915=y, DRM_NOUVEAU=m also acceptable if a module and not built-in."

	kernel_is -ge 5 8 && CONFIG_CHECK+=" X86_PAT" #817764

	MODULE_NAMES="
		nvidia(video:kernel)
		nvidia-drm(video:kernel)
		nvidia-modeset(video:kernel)
		$(usex x86 '' 'nvidia-uvm(video:kernel)')"

	linux-mod_pkg_setup

	[[ ${MERGE_TYPE} == binary ]] && return

	BUILD_PARAMS='NV_VERBOSE=1 IGNORE_CC_MISMATCH=yes SYSSRC="${KV_DIR}" SYSOUT="${KV_OUT_DIR}"'
	use x86 && BUILD_PARAMS+=' ARCH=i386'
	BUILD_TARGETS="modules"

	if linux_chkconfig_present CC_IS_CLANG; then
		ewarn "Warning: building ${PN} with a clang-built kernel is experimental"

		BUILD_PARAMS+=' CC=${CHOST}-clang'
		if linux_chkconfig_present LD_IS_LLD; then
			BUILD_PARAMS+=' LD=ld.lld'
			if linux_chkconfig_present LTO_CLANG_THIN; then
				# kernel enables cache by default leading to sandbox violations
				BUILD_PARAMS+=' ldflags-y=--thinlto-cache-dir= LDFLAGS_MODULE=--thinlto-cache-dir='
			fi
		fi
	fi

	if kernel_is -gt ${NV_KERNEL_MAX/./ }; then
		ewarn "Kernel ${KV_MAJOR}.${KV_MINOR} is either known to break this version of ${PN}"
		ewarn "or was not tested with it. It is recommended to use one of:"
		ewarn "  <=sys-kernel/gentoo-kernel-${NV_KERNEL_MAX}.x"
		ewarn "  <=sys-kernel/gentoo-sources-${NV_KERNEL_MAX}.x"
		ewarn "You are free to try or use /etc/portage/patches, but support will"
		ewarn "not be given and issues wait until NVIDIA releases a fixed version."
		ewarn
		ewarn "Do _not_ file a bug report if run into issues."
		ewarn
	fi
}

src_prepare() {
	# make patches usable across versions
	rm nvidia-modprobe && mv nvidia-modprobe{-${PV},} || die
	rm nvidia-persistenced && mv nvidia-persistenced{-${PV},} || die
	rm nvidia-settings && mv nvidia-settings{-${PV},} || die
	rm nvidia-xconfig && mv nvidia-xconfig{-${PV},} || die

	default

	# prevent detection of incomplete kernel DRM support (bug #603818)
	sed 's/defined(CONFIG_DRM/defined(CONFIG_DRM_KMS_HELPER/g' \
		-i kernel/conftest.sh || die

	sed 's/__USER__/nvpd/' \
		nvidia-persistenced/init/systemd/nvidia-persistenced.service.template \
		> "${T}"/nvidia-persistenced.service || die

	sed 's/__NV_VK_ICD__/libGLX_nvidia.so.0/' \
		nvidia_icd.json.template > nvidia_icd.json || die

	# 390 has legacy glx needing a modified .conf (bug #713546)
	# directory is not quite right, but kept for any existing custom xorg.conf
	sed "s|@LIBDIR@|${EPREFIX}/usr/$(get_libdir)|" \
		"${FILESDIR}"/nvidia-drm-outputclass-390.conf > nvidia-drm-outputclass.conf || die
}

src_compile() {
	tc-export AR CC LD OBJCOPY

	NV_ARGS=(
		PREFIX="${EPREFIX}"/usr
		HOST_CC="$(tc-getBUILD_CC)"
		HOST_LD="$(tc-getBUILD_LD)"
		NV_USE_BUNDLED_LIBJANSSON=0
		NV_VERBOSE=1 DO_STRIP= MANPAGE_GZIP= OUTPUTDIR=out
	)

	use driver && linux-mod_src_compile

	if use persistenced; then
		# 390.xx persistenced does not auto-detect libtirpc
		LIBS=$($(tc-getPKG_CONFIG) --libs libtirpc || die) \
			common_cflags=$($(tc-getPKG_CONFIG) --cflags libtirpc || die) \
			emake "${NV_ARGS[@]}" -C nvidia-persistenced
	fi

	emake "${NV_ARGS[@]}" -C nvidia-modprobe
	use X && emake "${NV_ARGS[@]}" -C nvidia-xconfig

	if use tools; then
		# cflags: avoid noisy logs, only use here and set first to let override
		# ldflags: abi currently needed if LD=ld.lld
		CFLAGS="-Wno-deprecated-declarations ${CFLAGS}" \
			RAW_LDFLAGS="$(get_abi_LDFLAGS) $(raw-ldflags)" \
			emake "${NV_ARGS[@]}" -C nvidia-settings
	elif use static-libs; then
		emake "${NV_ARGS[@]}" -C nvidia-settings/src build-xnvctrl
	fi
}

src_install() {
	local libdir=$(get_libdir) libdir32=$(ABI=x86 get_libdir)

	NV_ARGS+=( DESTDIR="${D}" LIBDIR="${ED}"/usr/${libdir} )

	local -A paths=(
		[APPLICATION_PROFILE]=/usr/share/nvidia
		[CUDA_ICD]=/etc/OpenCL/vendors
		[EGL_EXTERNAL_PLATFORM_JSON]=/usr/share/egl/egl_external_platform.d
		[GLVND_EGL_ICD_JSON]=/usr/share/glvnd/egl_vendor.d
		[VULKAN_ICD_JSON]=/usr/share/vulkan/icd.d
		[XORG_OUTPUTCLASS_CONFIG]=/usr/share/X11/xorg.conf.d

		[GLX_MODULE_SHARED_LIB]=/usr/${libdir}/xorg/modules/extensions
		[GLX_MODULE_SYMLINK]=/usr/${libdir}/extensions/nvidia
		[XMODULE_SHARED_LIB]=/usr/${libdir}/xorg/modules
		[XMODULE_SYMLINK]=/usr/${libdir}/xorg/modules
	)

	local skip_files=(
		# nvidia_icd(vulkan): skip with -X too as it uses libGLX_nvidia
		$(usex X '' '
			libGLX_nvidia libglx
			libnvidia-ifr
			nvidia_icd.json')
		libGLX_indirect # non-glvnd unused fallback
		libnvidia-gtk nvidia-{settings,xconfig} # built from source
		libnvidia-egl-wayland 10_nvidia_wayland # gui-libs/egl-wayland
	)
	local skip_modules=(
		$(usex X '' 'nvfbc vdpau xdriver')
		installer nvpd # handled separately / built from source
	)
	local skip_types=(
		GLVND_LIB GLVND_SYMLINK EGL_CLIENT.\* GLX_CLIENT.\* # media-libs/libglvnd
		OPENCL_WRAPPER.\* # virtual/opencl
		DOCUMENTATION DOT_DESKTOP # handled separately
		XMODULE_NEWSYM # use xorg's libwfb.so, nvidia also keeps it if it exists
		.\*_SRC DKMS_CONF LIBGL_LA OPENGL_HEADER # unused
	)

	local DOCS=(
		README.txt NVIDIA_Changelog
		nvidia-settings/doc/{FRAMELOCK,NV-CONTROL-API}.txt
	)
	local HTML_DOCS=( html/. )
	einstalldocs

	local DISABLE_AUTOFORMATTING=yes
	local DOC_CONTENTS="\
Trusted users should be in the 'video' group to use NVIDIA devices.
You can add yourself by using: gpasswd -a my-user video\
$(usex driver "

Like all out-of-tree kernel modules, it is necessary to rebuild
${PN} after upgrading or rebuilding the Linux kernel
by for example running \`emerge @module-rebuild\`. Alternatively,
if using a distribution kernel (sys-kernel/gentoo-kernel{,-bin}),
this can be automated by setting USE=dist-kernel globally.

Loaded kernel modules also must not mismatch with the installed
${PN} version (excluding -r revision), meaning should
ensure \`eselect kernel list\` points to the kernel that will be
booted before building and preferably reboot after upgrading
${PN} (the ebuild will emit a warning if mismatching).

See '${EPREFIX}/etc/modprobe.d/nvidia.conf' for modules options." '')\
$(use amd64 && usex abi_x86_32 '' "

Note that without USE=abi_x86_32 on ${PN}, 32bit applications
(typically using wine / steam) will not be able to use GPU acceleration.")\
$(usex X "

390.xx libglvnd support is partial and requires different Xorg modules
for working OpenGL/GLX. If using the default Xorg configuration these
should be used automatically, otherwise manually add the ModulePath
from: '${EPREFIX}/${paths[XORG_OUTPUTCLASS_CONFIG]#/}/nvidia-drm-outputclass.conf'" '')\
$(usex x86 '

Note that NVIDIA is no longer offering support for the unified memory
module (nvidia-uvm) on x86 (32bit), as such the module is missing.
This means OpenCL/CUDA (and related, like nvenc) cannot be used.
Other functions, like OpenGL, will continue to work.' '')

Support from NVIDIA for 390.xx will end in December 2022, how long
Gentoo will be able to reasonably support it beyond that is unknown.
If wish to continue using this hardware, should consider switching
to the Nouveau open source driver.
https://nvidia.custhelp.com/app/answers/detail/a_id/3142/

For general information on using ${PN}, please see:
https://wiki.gentoo.org/wiki/NVIDIA/nvidia-drivers"
	readme.gentoo_create_doc

	if use driver; then
		linux-mod_src_install

		insinto /etc/modprobe.d
		newins "${FILESDIR}"/nvidia-390.conf nvidia.conf
	fi

	emake "${NV_ARGS[@]}" -C nvidia-modprobe install
	fowners :video /usr/bin/nvidia-modprobe #505092
	fperms 4710 /usr/bin/nvidia-modprobe

	if use persistenced; then
		emake "${NV_ARGS[@]}" -C nvidia-persistenced install
		newconfd "${FILESDIR}"/nvidia-persistenced.confd nvidia-persistenced
		newinitd "${FILESDIR}"/nvidia-persistenced.initd nvidia-persistenced
		systemd_dounit "${T}"/nvidia-persistenced.service
	fi

	if use tools; then
		emake "${NV_ARGS[@]}" -C nvidia-settings install

		doicon nvidia-settings/doc/nvidia-settings.png
		domenu nvidia-settings/doc/nvidia-settings.desktop

		exeinto /etc/X11/xinit/xinitrc.d
		newexe "${FILESDIR}"/95-nvidia-settings-r1 95-nvidia-settings
	fi

	if use static-libs; then
		dolib.a nvidia-settings/src/libXNVCtrl/libXNVCtrl.a

		insinto /usr/include/NVCtrl
		doins nvidia-settings/src/libXNVCtrl/NVCtrl{Lib,}.h
	fi

	use X && emake "${NV_ARGS[@]}" -C nvidia-xconfig install

	# mimic nvidia-installer by reading .manifest to install files
	# 0:file 1:perms 2:type 3+:subtype/arguments -:module
	local m into
	while IFS=' ' read -ra m; do
		! [[ ${#m[@]} -ge 2 && ${m[-1]} =~ MODULE: ]] ||
			eval '[[ " ${m[0]##*/}" =~ ^(\ '${skip_files[*]/%/.*|\\}' )$ ]]' ||
			eval '[[ " ${m[2]}" =~ ^(\ '${skip_types[*]/%/|\\}' )$ ]]' ||
			has ${m[-1]#MODULE:} "${skip_modules[@]}" && continue

		case ${m[2]} in
			MANPAGE)
				gzip -dc ${m[0]} | newman - ${m[0]%.gz}; assert
				continue
			;;
			GLX_MODULE_SYMLINK|XMODULE_NEWSYM)
				# messy symlinks for non-glvnd xorg modules overrides put
				# in a different directory to avoid collisions (390-only)
				m[4]=../../xorg/modules/${m[3]#/}${m[4]}
				m[3]=/
			;;
			TLS_LIB) [[ ${m[4]} == CLASSIC ]] && continue;; # segfaults (bug #785289)
			VDPAU_SYMLINK) m[4]=vdpau/; m[5]=${m[5]#vdpau/};; # .so to vdpau/
			VULKAN_ICD_JSON) m[0]=${m[0]%.template};;
		esac

		if [[ -v paths[${m[2]}] ]]; then
			into=${paths[${m[2]}]}
		elif [[ ${m[2]} =~ _BINARY$ ]]; then
			into=/opt/bin
		elif [[ ${m[3]} == COMPAT32 ]]; then
			use abi_x86_32 || continue
			into=/usr/${libdir32}
		elif [[ ${m[2]} =~ _LIB$|_SYMLINK$ ]]; then
			into=/usr/${libdir}
		else
			die "No known installation path for ${m[0]}"
		fi
		[[ ${m[3]: -2} == ?/ ]] && into+=/${m[3]%/}
		[[ ${m[4]: -2} == ?/ ]] && into+=/${m[4]%/}

		if [[ ${m[2]} =~ _SYMLINK$|_NEWSYM$ ]]; then
			[[ ${m[4]: -1} == / ]] && m[4]=${m[5]}
			dosym ${m[4]} ${into}/${m[0]}
			continue
		fi

		printf -v m[1] %o $((m[1] | 0200)) # 444->644
		insopts -m${m[1]}
		insinto ${into}
		doins ${m[0]}
	done < .manifest || die

	# MODULE:installer non-skipped extras
	dolib.so libnvidia-cfg.so.${PV}
	dosym libnvidia-cfg.so.${PV} /usr/${libdir}/libnvidia-cfg.so.1
	dosym libnvidia-cfg.so.${PV} /usr/${libdir}/libnvidia-cfg.so

	dobin nvidia-bug-report.sh
}

pkg_preinst() {
	has_version "${CATEGORY}/${PN}[abi_x86_32]" && NV_HAD_ABI32=

	use driver || return
	linux-mod_pkg_preinst

	# set video group id based on live system (bug #491414)
	local g=$(getent group video | cut -d: -f3)
	[[ ${g} ]] || die "Failed to determine video group id"
	sed -i "s/@VIDEOGID@/${g}/" "${ED}"/etc/modprobe.d/nvidia.conf || die
}

pkg_postinst() {
	use driver && linux-mod_pkg_postinst

	readme.gentoo_print_elog

	if [[ -r /proc/driver/nvidia/version &&
		$(</proc/driver/nvidia/version) != *"  ${PV}  "* ]]; then
		ewarn "Currently loaded NVIDIA modules do not match the newly installed"
		ewarn "libraries and may prevent launching GPU-accelerated applications."
		use driver && ewarn "The easiest way to fix this is usually to reboot."
	fi

	if use !abi_x86_32 && [[ -v NV_HAD_ABI32 ]]; then
		elog
		elog "USE=abi_x86_32 is disabled, 32bit applications will not be able to"
		elog "use nvidia-drivers for acceleration without it (e.g. commonly used"
		elog "with app-emulation/wine-* or steam). Re-enable if needed."
	fi
}

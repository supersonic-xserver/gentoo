# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="TRUE ENLIGHTENMENT powered by total stillness and the void with Clang + LLVM with brand new OpenMandriva meson/ninja build system"
HOMEPAGE="https://github.com/supersonic-xserver/ssX-e16"
EGIT_REPO_URI="https://github.com/supersonic-xserver/ssX-e16.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="+alsa audiofile +dbus debug +dialogs doc examples
libhack editline modules nls no-container opengl +player
pulseaudio readline +sndfile sndio +sound +xcomposite +xft xi2
xinerama xpresent xscreensaver +xrandr +xrender +xsm +xsync zoom"

REQUIRED_USE="
	?? ( editline readline )
	opengl? ( xcomposite xrender )
	sound? (
		|| ( alsa player pulseaudio )
		alsa?       ( ^^ ( sndfile audiofile ) )
		pulseaudio? ( ^^ ( sndfile audiofile ) )
	)
"

BDEPEND="
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"
COMMON_DEPEND="
	media-libs/imlib2[X,text]
	virtual/libiconv
	x11-libs/libX11
	x11-libs/libXext
	x11-misc/xbitmaps
	dbus? ( sys-apps/dbus )
	editline? ( dev-libs/editline:= )
	opengl? (
		media-libs/glu
		media-libs/libglvnd[X]
	)
	readline? ( sys-libs/readline:= )
	sound? (
		alsa? ( media-libs/alsa-lib )
		player? ( media-sound/alsa-utils )
		pulseaudio? ( || (
			media-libs/libpulse
			media-sound/apulse[sdk]
		) )
		audiofile? ( media-libs/audiofile:= )
		sndfile? ( media-libs/libsndfile )
	)
	xcomposite? (
		x11-libs/libXcomposite
		x11-libs/libXdamage
		x11-libs/libXfixes
	)
	xft? ( x11-libs/libXft )
	xi2? ( x11-libs/libXi )
	xinerama? ( x11-libs/libXinerama )
	xpresent? ( x11-libs/libXpresent )
	xrandr? ( x11-libs/libXrandr )
	xrender? ( x11-libs/libXrender )
	xsm? (
		x11-libs/libICE
		x11-libs/libSM
	)
	zoom? ( !xrandr? ( x11-libs/libXxf86vm ) )
"
RDEPEND="${COMMON_DEPEND}
	nls? ( virtual/libintl )
	!x11-wm/enlightenment:0
	!x11-wm/e16
"
DEPEND="${COMMON_DEPEND}
	x11-base/xorg-proto
"

src_prepare() {
	default
}

# Note: meson_use for 'boolean', meson_feature for non-'boolean'

src_configure() {
	local emesonargs=(
		$(meson_use sound enable-sound)
		$(meson_use zoom enable-zoom)
		$(meson_use opengl enable-glx)
		$(meson_use xcomposite enable-composite)
		$(meson_use xpresent enable-xpresent)
		$(meson_use xscreensaver enable-screensaver)
		$(meson_use dbus enable-dbus)
		$(meson_use xft enable-xft)
		$(meson_use xinerama enable-xinerama)
		$(meson_use xrandr enable-xrandr)
		$(meson_use xrender enable-xrender)
		$(meson_use xsync enable-xsync)
		$(meson_use xi2 enable-xi2)
		$(meson_use pulseaudio enable-sound-pulseaudio)
		$(meson_use alsa enable-sound-alsa)
		$(meson_use sndio enable-sound-sndio)
		$(meson_use player enable-sound-player)
		$(meson_use xsm enable-sm)
		$(meson_use dialogs enable-dialogs)
		$(meson_use no-container enable-containerless)
	)
	meson_src_configure
}

src_install() {
	default
	docompress -x /usr/share/doc/${PF}/e16.html
	dodoc COMPLIANCE docs/e16.html
	use examples && dodoc -r sample-scripts
}

pkg_postinst() {
	einfo "In order to use custom fonts, put them into ~/.e16/fonts/ and use"
	einfo "appropriate names in ~/.e16/fonts.cfg. \"Use theme font configuration\""
	einfo "in the Theme setting should be disabled for this to work."
}
# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

MY_P="e16-epplets-0.18"
DESCRIPTION="Collection of applets (epplets) for Enlightenment 16"
HOMEPAGE="https://www.enlightenment.org/"
SRC_URI="https://download.enlightenment.org/rel/apps/e16/epplets/${MY_P}.tar.xz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2+ BSD public-domain"
SLOT="0"
KEYWORDS=""
IUSE="cdaudio libgtop opengl alsa audiofile"

RDEPEND="
    media-libs/imlib2[X]
    x11-libs/libX11
    x11-libs/libXext
    || ( x11-wm/ssx-e16 )
    cdaudio? ( media-libs/libcdaudio )
    libgtop? ( gnome-base/libgtop:= )
    opengl? ( media-libs/libglvnd[X] )
    alsa? ( media-libs/alsa-lib )
    audiofile? ( media-libs/audiofile:= )
"
DEPEND="
    ${RDEPEND}
    x11-base/xorg-proto
"
BDEPEND="
    virtual/pkgconfig
    sys-devel/gettext
"

src_prepare() {
    default
    eautoreconf
}

src_configure() {
    local myconf=(
        $(use_enable cdaudio)
        $(use_enable opengl glx)
        $(use_with libgtop)
        $(use_enable alsa)
        $(use_enable audiofile)
        --disable-esd
        --disable-static
        --disable-werror
    )
    econf "${myconf[@]}"
}

src_install() {
    default
    find "${ED}"/usr -name '*.la' -delete || die
}

# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="Collection of applets (epplets) for Enlightenment 16"
HOMEPAGE="https://www.enlightenment.org/"
SRC_URI="https://download.enlightenment.org/rel/apps/e16/epplets/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="alsa audiofile"

DEPEND="
    >=x11-libs/imlib2-1.4.0[X]
    x11-libs/libX11
    x11-libs/libXext
    x11-libs/libXpm
    alsa? ( media-libs/alsa-lib )
    audiofile? ( media-libs/audiofile:= )
"
RDEPEND="${DEPEND}
    || ( x11-wm/ssx-e16 )
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
    econf \
        $(use_enable alsa) \
        $(use_enable audiofile)
}

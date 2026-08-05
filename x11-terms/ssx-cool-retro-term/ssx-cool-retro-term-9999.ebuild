# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 qmake-utils xdg

DESCRIPTION="A good looking terminal emulator which mimics the old cathode display... Updated with QT6 deps"
HOMEPAGE="https://github.com/supersonic-xserver/ssX-cool-retro-term"
EGIT_REPO_URI="https://github.com/supersonic-xserver/${PN}.git"

LICENSE="GPL-3 GPL-2"
SLOT="0"

# todo check if it actually overrides cool-retro-term files
RDEPEND="
	dev-qt/qt5compat:6
	dev-qt/qtbase:6[concurrent,gui,network,sql,widgets]
	dev-qt/qtdeclarative:6
	!x11-terms/cool-retro-term
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-qt/qtshadertools:6
"

src_configure() {
	eqmake6 PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	# todo get painter/hapless to change the name for this
	doman packaging/debian/cool-retro-term.1
}

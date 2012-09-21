# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit mozextension-2 multilib eutils

MY_P="${PN}_standard-${PV}-fx+sm+tb"
DESCRIPTION="A set of proxy management tools for firefox"
HOMEPAGE="http://getfoxyproxy.org"
SRC_URI="http://releases.mozilla.org/pub/mozilla.org/addons/2464/${MY_P}.xpi"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="|| (
	>=www-client/firefox-bin-3.0.0
	>=www-client/firefox-3.0.0
)"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	xpi_unpack $A
#	epatch "${FILESDIR}/${MY_P}.patch"
}

src_compile () {
	einfo "Nothing to compile"
}

src_install () {
	declare MOZILLA_FIVE_HOME
	if has_version '>=www-client/firefox-1.5.0.7'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/firefox"
		xpi_install "${S}/${MY_P}"
	fi
	if has_version '>=www-client/firefox-bin-1.5.0.7'; then
		MOZILLA_FIVE_HOME="/opt/firefox"
		xpi_install "${S}/${MY_P}"
	fi
}

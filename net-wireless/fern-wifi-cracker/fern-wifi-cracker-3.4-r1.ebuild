# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
PYTHON_REQ_USE="sqlite"

inherit desktop python-single-r1 wrapper xdg-utils

DESCRIPTION="Wireless tool for WEP/WPA cracking and WPS keys recovery"
HOMEPAGE="https://github.com/savio-code/fern-wifi-cracker"
SRC_URI="https://github.com/savio-code/fern-wifi-cracker/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${P}/Fern-Wifi-Cracker"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="dict policykit"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	$(python_gen_cond_dep '
		dev-python/pyqt5[gui,widgets,${PYTHON_USEDEP}]
		>=net-analyzer/scapy-2.4.3[${PYTHON_USEDEP}]
	')
	net-analyzer/macchanger
	net-wireless/aircrack-ng
	dict? ( sys-apps/cracklib-words )
	|| ( net-wireless/reaver-wps-fork-t6x net-wireless/reaver )
	policykit? ( sys-auth/polkit )"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	python_fix_shebang "${S}"

	default
}

src_install() {
	insinto "/usr/share/fern-wifi-cracker"
	doins -r *
	python_optimize "${ED}/usr/share/fern-wifi-cracker"

	dosym "../fern-wifi-cracker/resources/icon.png" "/usr/share/pixmaps/${PN}.png"

	make_wrapper $PN \
		"${EPYTHON} /usr/share/fern-wifi-cracker/execute.py"

	if use policykit; then
		insinto "/usr/share/polkit-1/actions/"
		doins "${FILESDIR}"/com.fern-pro.pkexec.fern-wifi-cracker.policy

		make_desktop_entry \
			"pkexec /usr/bin/${PN}" \
			"Fern Wifi Cracker" \
			"${PN}" \
			"System;Security;X-Pentoo;X-Penetration;X-Wireless;"
	else
		make_desktop_entry \
			"$PN" \
			"Fern Wifi Cracker" \
			"$PN" \
			"System;Security;X-Pentoo;X-Penetration;X-Wireless;"
	fi

	dodoc ../README.md
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

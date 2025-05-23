# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Stateful programmatic web browsing in Python"
HOMEPAGE="https://github.com/python-mechanize/mechanize"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="|| ( BSD ZPL )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/html5lib[${PYTHON_USEDEP}]
	dev-python/html5-parser[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" run_tests.py || die
}

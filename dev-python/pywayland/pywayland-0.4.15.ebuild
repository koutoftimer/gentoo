# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} pypy3 )
inherit distutils-r1 xdg-utils

DESCRIPTION="Python bindings for the libwayland library"
HOMEPAGE="
	https://pywayland.readthedocs.io/en/latest/
	https://github.com/flacjacket/pywayland
	https://pypi.org/project/pywayland/
"
SRC_URI="
	https://github.com/flacjacket/pywayland/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~riscv ~x86"

RDEPEND="
	dev-libs/wayland
	virtual/python-cffi[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="dev-libs/wayland-protocols
	dev-util/wayland-scanner"

distutils_enable_tests pytest

python_prepare_all() {
	# Needed for tests (XDG_RUNTIME_DIR)
	xdg_environment_reset
	distutils-r1_python_prepare_all
}

python_test() {
	# No die deliberately as sometimes it doesn't exist
	rm -r pywayland

	epytest
}

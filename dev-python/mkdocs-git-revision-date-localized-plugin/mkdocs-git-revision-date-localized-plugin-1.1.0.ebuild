# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( python3_{9..11} )

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="
	dev-python/mkdocs-i18n
	dev-python/mkdocs-material
	dev-python/mkdocs-git-authors-plugin
	dev-python/mkdocs-git-revision-date-localized-plugin
"

inherit distutils-r1 docs

DESCRIPTION="Display the localized date of the last git modification of a markdown file"
HOMEPAGE="
	https://github.com/timvink/mkdocs-git-revision-date-localized-plugin/
	https://pypi.org/project/mkdocs-git-revision-date-localized-plugin/
"
SRC_URI="https://github.com/timvink/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ppc ~riscv x86"

RDEPEND="
	>=dev-python/Babel-2.7.0[${PYTHON_USEDEP}]
	dev-python/GitPython[${PYTHON_USEDEP}]
	>=dev-python/mkdocs-1.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/click[${PYTHON_USEDEP}]
		dev-python/mkdocs-material[${PYTHON_USEDEP}]
		dev-python/mkdocs-i18n[${PYTHON_USEDEP}]
		dev-vcs/git
	)
	doc? ( dev-vcs/git )
"

distutils_enable_tests pytest

python_prepare_all() {
	# mkdocs-git-revision-date-localized-plugin's tests need git repo
	if use test || use doc; then
		git init -q || die
		git config --global user.email "you@example.com" || die
		git config --global user.name "Your Name" || die
		git add . || die
		git commit -qm 'init' || die
	fi

	distutils-r1_python_prepare_all
}

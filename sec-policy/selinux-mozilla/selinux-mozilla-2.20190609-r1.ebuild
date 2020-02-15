# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

IUSE="alsa"
MODS="mozilla"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for mozilla"

if [[ ${PV} != 9999* ]] ; then
	KEYWORDS="~amd64 -arm ~arm64 ~mips ~x86"
fi
DEPEND="${DEPEND}
	sec-policy/selinux-xserver
"
RDEPEND="${RDEPEND}
	sec-policy/selinux-xserver
"

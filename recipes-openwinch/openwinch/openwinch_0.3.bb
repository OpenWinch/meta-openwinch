SUMMARY = "bitbake-layers recipe"
DESCRIPTION = "OpenWinch layer"
HOMEPAGE = "https://github.com/openwinch/openwinch-cpp"
SECTION = "application"
#LICENSE = "Apache-2.0"
LICENSE = "CLOSED"

SRC_URI = "\
    file://openwinch-0.3.tar.xz \
    file://pi.patch \
"

inherit cmake systemd

# OECMAKE_GENERATOR = "Unix Makefiles"
# EXTRA_OECMAKE_append = "-DOW_BOARD='raspberry' "

SYSTEMD_SERVICE_${PN} = "\
    openwinch.service \
"

FILES_SOLIBSDEV = ""
FILES_${PN} = "\
    ${sysconfdir} \
    /usr/man/* \
    /opt/openwinch/bin/* \
    /usr/lib/cmake/* \
    ${libdir}/*.so \
    ${bindir} \
    ${systemd_unitdir}/system \
"
FILES_${PN}-dev = "${includedir}"
FILES_${PN}-staticdev = "\
    ${includedir} \
    /usr/man/* \
    /opt/openwinch/bin/* \
    /usr/lib/cmake/* \
    ${libdir}/*.so \
    ${bindir} \
    ${systemd_unitdir}/system \
"


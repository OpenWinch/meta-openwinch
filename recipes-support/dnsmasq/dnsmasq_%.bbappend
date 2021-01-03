## DOC
# http://layers.openembedded.org/layerindex/recipe/124690/

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://dnsmasq.conf \
"

SYSTEMD_AUTO_ENABLE_${PN} = "enable"

do_install_append() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/dnsmasq.conf ${D}${sysconfdir}/dnsmasq.conf

    # install -d ${D}${sysconfdir}/sysctl.d
    # install -m 0644 ${WORKDIR}/ip_forward.conf ${D}${sysconfdir}/sysctl.d/ip_forward.conf
}

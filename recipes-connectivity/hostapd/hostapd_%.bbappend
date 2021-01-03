## DOC
# http://layers.openembedded.org/layerindex/recipe/123514/

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://hostapd.conf \
"

SYSTEMD_AUTO_ENABLE_${PN} = "enable"

FILES_${PN} += " \
    ${sysconfdir}/hostapd.conf \
"

do_install_append() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/hostapd.conf ${D}${sysconfdir}/hostapd.conf

    sed -i 's|%SSID|${OW_SSID}|g' ${D}${sysconfdir}/hostapd.conf
    sed -i 's|%PASS|${OW_WPASS}|g' ${D}${sysconfdir}/hostapd.conf

    # install -d ${D}${sysconfdir}/sysctl.d
    # install -m 0644 ${WORKDIR}/ip_forward.conf ${D}${sysconfdir}/sysctl.d/ip_forward.conf
}

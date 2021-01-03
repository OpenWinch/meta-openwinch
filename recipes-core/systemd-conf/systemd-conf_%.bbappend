## DOC
# http://layers.openembedded.org/layerindex/recipe/122139/

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# set these from your local.conf
OW_SSID ?= "OpenWinch"
OW_IP ?= "192.168.2.1/24"
OW_GW ?= ""
OW_DNS ?= ""
OW_DEV_SSID ?= "OpenWinch-Dev"

SRC_URI += " \
    file://20-eth-app.network \
    file://20-en-app.network \
    file://20-wlan-app.network \
    file://30-wlan-dev.network \
    file://40-wlan-fallback.network \
"

FILES_${PN} += " \
    ${sysconfdir}/systemd/network/*-eth*.network \
    ${sysconfdir}/systemd/network/*-en*.network \
    ${sysconfdir}/systemd/network/*-wlan*.network \
"

do_install_append() {
    install -d ${D}${sysconfdir}/systemd/network
    install -m 0644 ${WORKDIR}/*-eth*.network ${D}${sysconfdir}/systemd/network
    install -m 0644 ${WORKDIR}/*-en*.network ${D}${sysconfdir}/systemd/network
    install -m 0644 ${WORKDIR}/*-wlan*.network ${D}${sysconfdir}/systemd/network

    sed -i 's|%SSID|${OW_SSID}|g' ${D}${sysconfdir}/systemd/network/20-wlan-app.network
    sed -i 's|%IP|${OW_IP}|g' ${D}${sysconfdir}/systemd/network/20-wlan-app.network

    if [ -n "${OW_GW}" ]; then
        sed -i 's|#Gateway=|Gateway=${OW_GW}|g' ${D}${sysconfdir}/systemd/network/20-wlan-app.network
    fi
    if [ -n "${OW_GW}" ]; then
        sed -i 's|#DNS=|DNS=${OW_DNS}|g' ${D}${sysconfdir}/systemd/network/20-wlan-app.network
    fi

    sed -i 's|%SSID|${OW_DEV_SSID}|g' ${D}${sysconfdir}/systemd/network/30-wlan-dev.network
}

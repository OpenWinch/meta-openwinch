## DOC
# http://layers.openembedded.org/layerindex/recipe/122215/

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# set these from your local.conf
SSID ?= ""
PSK ?= ""

SRC_URI += "file://wpa_supplicant-nl80211-wlan0.conf"

SYSTEMD_SERVICE_${PN} += " wpa_supplicant-nl80211@wlan0.service"
SYSTEMD_AUTO_ENABLE = "enable"

do_install_append() {
    install -d ${D}${sysconfdir}/wpa_supplicant/
    install -D -m 600 ${WORKDIR}/wpa_supplicant-nl80211-wlan0.conf ${D}${sysconfdir}/wpa_supplicant/

    sed -i 's/%SSID/${SSID}/g' ${D}${sysconfdir}/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf

    if [ -z "${PSK_RAW}" ]; then
        sed -i 's/%PSK/psk="${PSK_RAW}"/g' ${D}${sysconfdir}/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf
    fi

    if [ -z "${PSK_HEX}" ]; then
        sed -i 's/%PSK/psk=${PSK_RAW}/g' ${D}${sysconfdir}/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf
    fi

    if [ -z "${SSID}" ]; then
        bbwarn "The SSID for wpa_supplicant is not set in local.conf"
    fi

    if [ -z "${PSK_RAW}" ] || [ -z "${PSK_HEX}" ]; then
        bbwarn "The PSK for wpa_supplicant is not set in local.conf"
    fi

    install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants/
    ln -s ${systemd_unitdir}/system/wpa_supplicant@.service ${D}${sysconfdir}/systemd/system/multi-user.target.wants/wpa_supplicant-nl80211@wlan0.service
}

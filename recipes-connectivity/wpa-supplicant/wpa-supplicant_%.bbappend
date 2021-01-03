## DOC
# http://layers.openembedded.org/layerindex/recipe/122215/

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# set these from your local.conf
OW_DEV_SSID ?= "OpenWinch-Dev"
OW_DEV_PSK_RAW ?= ""
OW_DEV_PSK_HEX ?= ""

SRC_URI += "\
            file://wpa_supplicant-nl80211-wlan0.conf \
            "

SYSTEMD_SERVICE_${PN} += " wpa_supplicant-nl80211@.service"

# Don't enable this by default
#SYSTEMD_AUTO_ENABLE_${PN} = "enable"
SYSTEMD_AUTO_ENABLE_${PN} = "disable"

do_install_append() {

    rm ${D}${sysconfdir}/wpa_supplicant.conf
    install -d ${D}${sysconfdir}/wpa_supplicant/
    install -D -m 600 ${WORKDIR}/wpa_supplicant-nl80211-wlan0.conf ${D}${sysconfdir}/wpa_supplicant/

    # Replace config
    sed -i 's|%SSID|${OW_DEV_SSID}|g' ${D}${sysconfdir}/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf
    if [ -n "${OW_DEV_PSK_HEX}" ]; then
        sed -i 's|%PSK|${OW_DEV_PSK_HEX}|g' ${D}${sysconfdir}/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf
    fi
    if [ -n "${OW_DEV_PSK_RAW}" ]; then
        sed -i 's|%PSK|"${OW_DEV_PSK_RAW}"|g' ${D}${sysconfdir}/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf
    fi

    # Bad config
    if [ -z "${OW_DEV_SSID}" ]; then
        bbwarn "The OW_DEV_SSID for wpa_supplicant is not set in local.conf"
    fi
    if [ -z "${OW_DEV_PSK_RAW}" ] || [ -z "${OW_DEV_PSK_HEX}" ]; then
        bbwarn "The OW_DEV_PSK(_RAW or _HEX) for wpa_supplicant is not set in local.conf"
    fi

    # Make sure the system directory for systemd exists.
    install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants/
    # Link the service file for autostart.
    ln -s ${systemd_unitdir}/system/wpa_supplicant-nl80211@.service ${D}${sysconfdir}/systemd/system/multi-user.target.wants/wpa_supplicant-nl80211@wlan0.service
}

CONFFILES_${PN} += "${sysconfdir}/wpa_supplicant/*.conf"

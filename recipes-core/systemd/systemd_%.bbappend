## DOC
# http://layers.openembedded.org/layerindex/recipe/122137/

#FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PACKAGECONFIG_append = " networkd resolved"
RDEPENDS_${PN}_append = " wpa-supplicant "

## DOC
# http://layers.openembedded.org/layerindex/recipe/124690/

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# Don't enable this by default
SYSTEMD_AUTO_ENABLE_${PN} = "disable"

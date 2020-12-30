## DOC
# http://layers.openembedded.org/layerindex/recipe/122248/

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://fragment.cfg;subdir=git"

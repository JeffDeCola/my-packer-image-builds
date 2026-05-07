#!/bin/sh -e
# my-packer-image-builds jeffs-virtualbox-image-arch-linux-on-windows
# convert-ovf-to-vbox.sh
#
# Imports the OVF appliance produced by build-image.sh into VirtualBox
# so the VM appears in the VirtualBox Manager UI and can be cloned.
#
# Run this AFTER build-image.sh succeeds. Picks up the most recent build
# matching the IMAGE_NAME pattern.
#
# # Usage:
#   ./convert-ovf-to-vbox.sh [OPTIONS]
#
# Options:
#   -debug    Enable debug output (set -x)

echo " "

if [ "$1" = "-debug" ]
then
    echo "************************************************************************"
    echo "* convert-ovf-to-vbox.sh -debug (START) ********************************"
    echo "************************************************************************"
    set -x
    echo " "
else
    echo "************************************************************************"
    echo "* convert-ovf-to-vbox.sh (START) ***************************************"
    echo "************************************************************************"
    echo " "
fi

# ----------------------------------------------------------------------------
# CONFIG
# ----------------------------------------------------------------------------

IMAGE_NAME="virtualbox-image-arch-linux"
VM_BASE_DIR="D:/virtualbox"
VM_NAME_PREFIX="jeffs"
VBOXMANAGE="/c/Program Files/Oracle/VirtualBox/VBoxManage.exe"

# ----------------------------------------------------------------------------
# FIND MOST RECENT OVF
# ----------------------------------------------------------------------------

OVF_PATH=$(ls -1t "${VM_BASE_DIR}"/${VM_NAME_PREFIX}-${IMAGE_NAME}-*/*.ovf 2>/dev/null | head -n 1)

if [ -z "${OVF_PATH}" ]
then
    echo "ERROR: No OVF found matching ${VM_BASE_DIR}/${VM_NAME_PREFIX}-${IMAGE_NAME}-*/*.ovf"
    echo "Run build-image.sh first."
    exit 1
fi

VM_NAME=$(basename "${OVF_PATH}" .ovf)

echo "Found OVF:  ${OVF_PATH}"
echo "VM name:    ${VM_NAME}"
echo " "

# ----------------------------------------------------------------------------
# UNREGISTER EXISTING VM (IF ANY)
# ----------------------------------------------------------------------------

if "${VBOXMANAGE}" list vms | grep -q "\"${VM_NAME}\""
then
    echo "VM ${VM_NAME} is already registered. Unregistering..."
    "${VBOXMANAGE}" unregistervm "${VM_NAME}" --delete
    echo " "
fi

# ----------------------------------------------------------------------------
# IMPORT
# ----------------------------------------------------------------------------

echo "Importing OVF into VirtualBox..."
"${VBOXMANAGE}" import "${OVF_PATH}"
echo " "

# ----------------------------------------------------------------------------
# VERIFY
# ----------------------------------------------------------------------------

if "${VBOXMANAGE}" list vms | grep -q "\"${VM_NAME}\""
then
    echo "SUCCESS: VM ${VM_NAME} is now registered in VirtualBox."
else
    echo "WARNING: import finished but VM is not in 'list vms' output."
    exit 1
fi
echo " "

echo "************************************************************************"
echo "* convert-ovf-to-vbox.sh (END) *****************************************"
echo "************************************************************************"
echo " "

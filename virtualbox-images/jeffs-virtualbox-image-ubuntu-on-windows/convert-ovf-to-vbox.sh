#!/bin/sh -e
# my-packer-image-builds jeffs-virtualbox-image-ubuntu-on-windows
# convert-ovf-to-vbox.sh
#
# Imports the OVF appliance produced by build-image.sh into VirtualBox
# so the VM appears in the VirtualBox Manager UI and can be cloned.
#
# Run this AFTER build-image.sh succeeds.
#
# # Usage:
#   ./convert-ovf-to-vbox.sh [OPTIONS]
#
# Options:
#   -debug    Enable debug output (set -x)
#
# Examples:
#   ./convert-ovf-to-vbox.sh              # import today's build
#   ./convert-ovf-to-vbox.sh -debug       # import with debug output

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

echo "The goal is to import the OVF produced by Packer into VirtualBox"
echo "so it appears in the Manager UI and can be cloned from."
echo " "

# ----------------------------------------------------------------------------
# CONFIG
# ----------------------------------------------------------------------------

IMAGE_NAME="virtualbox-image-ubuntu"
VM_BASE_DIR="D:/virtualbox"
VM_NAME_PREFIX="jeffs"
VM_NAME_POSTFIX=$(date +%Y%m%d)
VM_NAME="${VM_NAME_PREFIX}-${IMAGE_NAME}-${VM_NAME_POSTFIX}"
OVF_PATH="${VM_BASE_DIR}/${VM_NAME}/${VM_NAME}.ovf"
VBOXMANAGE="/c/Program Files/Oracle/VirtualBox/VBoxManage.exe"

echo "VM name:   ${VM_NAME}"
echo "OVF path:  ${OVF_PATH}"
echo " "

# ----------------------------------------------------------------------------
# CHECK OVF EXISTS
# ----------------------------------------------------------------------------

if [ ! -f "${OVF_PATH}" ]
then
    echo "ERROR: OVF file not found at ${OVF_PATH}"
    echo " "
    echo "Possible causes:"
    echo "  - build-image.sh has not been run yet today"
    echo "  - build-image.sh failed before producing the OVF"
    echo "  - the build was done on a different date"
    echo " "
    echo "Available builds in ${VM_BASE_DIR}:"
    ls -1 "${VM_BASE_DIR}" 2>/dev/null | grep "^${VM_NAME_PREFIX}-${IMAGE_NAME}-" || echo "  (none)"
    exit 1
fi

# ----------------------------------------------------------------------------
# UNREGISTER EXISTING VM (IF ANY)
# Avoids name collision on import. Common when re-running on the same day.
# ----------------------------------------------------------------------------

if "${VBOXMANAGE}" list vms | grep -q "\"${VM_NAME}\""
then
    echo "VM ${VM_NAME} is already registered in VirtualBox."
    echo "Unregistering before import to avoid name collision..."
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
    echo " "
    echo "It should appear in the VirtualBox Manager UI sidebar."
    echo "To clone it, right-click in the UI -> Clone, or run:"
    echo "  \"${VBOXMANAGE}\" clonevm \"${VM_NAME}\" --name \"my-new-vm\" --register --mode all"
else
    echo "WARNING: import command finished but VM is not in 'list vms' output."
    echo "Something went wrong - check the import output above."
    exit 1
fi
echo " "

echo "************************************************************************"
echo "* convert-ovf-to-vbox.sh (END) *****************************************"
echo "************************************************************************"
echo " "

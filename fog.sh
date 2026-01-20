#!/bin/bash

POOL="filesystems"

image="$1"
name="$2"
base="$(mktemp -d)"

primary="${name}.qcow2"
metadata="${base}/${name}.iso"

# cp "${image}" "${primary}"

function upload {
  virsh vol-create-as --pool ${POOL} --name $2 --capacity 1g
  virsh vol-upload --pool ${POOL} --vol $2 --file $1
  virsh vol-list --pool ${POOL}
}

function make_cloud_init {
  genisoimage -output ${metadata} \
    -volid cidata \
    -joliet \
    -rock \
    cloud-init/user-data \
    cloud-init/meta-data \
    cloud-init/network-config
}

function make_vm {
  virt-install \
    --import \
    --virt-type kvm \
    --osinfo rocky9 \
    --name "${name}" \
    --memory 1024 \
    --vcpus 1 \
    --disk=vol=${POOL}/${primary},device=disk \
    --cloud-init=user-data=cloud-init/user-data,meta-data=cloud-init/meta-data,network-config=cloud-init/network-config \
    --network default \
    --graphics none \
    --noautoconsole
}

# make_cloud_init
upload "${image}" "${name}.qcow2"
# upload "${metadata}" "${name}.iso"
make_vm

# virt-install \
  # --virt-type qemu \
  # --arch x86_64 \ 
  # --name tst \
  # --disk CentOS-7-x86_64-GenericCloud-1907.qcow2c \
  # --os-type Linux \
  # --os-variant centos7.0 \
  # --virt-type kvm \
  # --graphics none \
  # --network default \
  # --import

# Virtualisation Platform Options:
#   -v, --hvm             This guest should be a fully virtualised guest
#   -p, --paravirt        This guest should be a paravirtualised guest
#   --container           This guest should be a container guest
#   --virt-type HV_TYPE   Hypervisor name to use (kvm, qemu, xen, ...)
#   --arch ARCH           The CPU architecture to simulate
#   --primary MACHINE     The machine type to emulate

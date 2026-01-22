
Prerequisites
```
$ sudo dnf install qemu-kvm-common
$ sudo dnf install cloud-utils-growpart
$ sudo dnf install libguestfs
$ sudo dnf install guestfs-tools
```
Example guest configuration
```
export HOST="tt"
export POOL="filesystems"
export IMAGE="rocky10.qcow2"
export OS="rocky9"
export CPUS="2"
export MEMORY="4096"

export ROOT_DEVICE="/dev/sda4"
export ROOT_SIZE="20G"

export NETWORK="default"
export NETWORK_DEVICE="enp1s0"
export IP_ADDRESS="192.168.1.24"
export GATEWAY_ADDRESS="192.168.1.254"
export DNS_SERVER="1.1.1.1"

export SSH_PUBLIC_KEY="$(cat ${HOME}/.ssh/id_rsa.pub)"
```
Variables

| Variable        | Purpose   |
| --------------- | --------- |
| HOST            |           |
| POOL            |           |
| IMAGE           |           |
| OS              |           |
| CPUS            |           |
| MEMORY          |           |
|                 |           |
| ROOT_DEVICE     |           |
| ROOT_SIZE       |           |
|                 |           |
| NETWORK         |           |
| NETWORK_DEVICE  |           |
| IP_ADDRESS      |           |
| GATEWAY_ADDRESS |           |
| DNS_SERVER      |           |
|                 |           |
| SSH_PUBLIC_KEY  |           |

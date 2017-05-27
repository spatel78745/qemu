#!/bin/bash

image=$1
mac_vlan0=$2
mac_vlan1=$3

echo "Launching VM $image vlan0=$mac_vlan0 vlan1=$mac_vlan1" 

qemu-system-x86_64 $image\
	-m 3072 \
	-net nic,vlan=0,macaddr=$mac_vlan0 -net tap,vlan=0 \
	-net nic,vlan=1,macaddr=$mac_vlan1 -net vde,vlan=1,sock=/tmp/myswitch

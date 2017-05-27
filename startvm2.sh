#!/bin/bash

#image=$1
#mac_eth0=52:54:00:12:34:56
#mac_eth1=52:54:00:12:34:57
MAC_BASE=52:54:00:12:34:

# Start all the VMs
for vm in vm*; do
	# Compute the MAC
	vmid=$(printf "%02d" ${vm:2})
	macid=$(printf "%02d" $vmid)
	mac=${MAC_BASE}:${macid}

	# Compute the switch id
	vswid=vsw${vmid}

	echo $mac $vswid

	# Start switches
	if [ ! -e /tmp/${vswid}.ctl ]; then
		echo "Starting switch ${vswid}."
		vde_switch --daemon --sock /tmp/${vswid}.ctl --mgmt /tmp/${vswid}.mgmt
	else
		echo "Switch $vswid is running."
	fi
done

#
# Start a VM for the conn-sync testcase at:
#		http://conntrack-tools.netfilter.org/testcase.html
#
#qemu-system-x86_64 $image\
#	-m 3072 \
#	-net nic,vlan=0,macaddr=$mac -net vde,vlan=0,sock=/tmp/vsw0 \
#	-net nic,vlan=1,macaddr=$mac -net vde,vlan=1,sock=/tmp/vsw1

#!/bin/bash

image=$1
mac=$2

#
# To get Internet access with this configuration:
# - Start myswitch with a tap interface:
#   - vde_switch --tap tap_vde -F sock /tmp/myswitch
#   - NAT when outputting to eth0
#     - iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
qemu-system-x86_64 $image\
	-m 3072 \
	-net nic,macaddr=$mac -net vde,sock=/tmp/myswitch

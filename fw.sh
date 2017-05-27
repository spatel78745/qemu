iptables -P FORWARD DROP
iptables -A FORWARD -i eth0 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i eth1 -p tcp --syn -m state --state NEW -j ACCEPT
iptables -A FORWARD -i eth1 -p tcp -m state --state ESTABLISHED -j ACCEPT
iptables -A FORWARD -m state --state INVALID -j LOG
iptables -I POSTROUTING -t nat -s 192.168.0.3 -j SNAT --to 192.168.1.100

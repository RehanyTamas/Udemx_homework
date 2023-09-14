#!/bin/bash

# Flush existing rules
iptables -F

# Allow incoming SSH traffic
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Allow incoming HTTP traffic (port 80)
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 9001 -j ACCEPT
iptables -A INPUT -p tcp --dport 9002 -j ACCEPT
iptables -A INPUT -p tcp --dport 9003 -j ACCEPT
iptables -A INPUT -p tcp --dport 9004 -j ACCEPT
iptables -A INPUT -p tcp --dport 9005 -j ACCEPT

# Allow outgoing DNS traffic (TCP and UDP port 53)
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT

iptables -A OUTPUT -o eth0 -p tcp --dport 9418 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --sport 9418 -m state --state ESTABLISHED -j ACCEPT

# Block all other incoming traffic
iptables -A INPUT -j DROP

# Save the rules
mkdir -p /etc/iptables
iptables-save > /etc/iptables/rules.v4


#!/bin/bash
# this script needs to be run on the satellite server

# update satellite with
# - dns
# - dhcp
# - tftp

satellite-installer \
--foreman-proxy-dns true \
--foreman-proxy-dns-interface eth0 \
--foreman-proxy-dns-zone boston.lab.example.com \
--foreman-proxy-dns-forwarders 172.25.250.254 \
--foreman-proxy-dns-reverse 250.25.172.in-addr.arpa \
--foreman-proxy-dhcp true \
--foreman-proxy-dhcp-interface eth0 \
--foreman-proxy-dhcp-range "172.25.250.12 172.25.250.19" \
--foreman-proxy-dhcp-gateway 172.25.250.254 \
--foreman-proxy-dhcp-nameservers 172.25.250.7 \
--foreman-proxy-tftp true



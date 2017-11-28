#!/bin/bash
# this script must run on the satellite
# prepare the satellite for bare metal discovery

satellite-installer --enable-foreman-plugin-discovery

# install additional packages
yum install -y foreman-discovery-image rubygem-smart_proxy_discovery


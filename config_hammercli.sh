#!/bin/bash
# config hammer cli

# create hammer config directory
mkdir -p ~/.hammer

# create config file
cat > ~/.hammer/cli_config.yml <<EOF
:foreman:
  :host: 'satellite.lab.example.com'
  :username:admin
  :password:redhat
EOF

# limit access to this file
chmod 0600 ~/.hammer/cli_config.yml


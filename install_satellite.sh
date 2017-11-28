#!/bin/bash
# install satellite server
# run this script on the satellite server

# declare variables
SATSERVER=satellite.lab.example.com
ISOLOC=http://classroom.example.com/content/rhsat6.2.1/x86_64/isos
SATISO=satellite-6.2.1-rhel-7-x86_64-dvd.iso
LOOPISO=/mnt/isos
HAMCONF=cli_config.yml
HAMLOC='~/.hammer/'

function pause() {
    read -p "$*"
}


function get_iso {
# download satellite iso on satellite server
if [ -f /tmp/${SATISO} ]
then
    echo "File already downloaded"
else
    wget -O /tmp/${SATISO} ${ISOLOC}/${SATISO}
fi
# show file has been downloaded
ls -lh /tmp/${SATISO}
echo "Satellite Installer ISO has been downloaded (or not)"
#pause 'Press enter to continue....'
}

function mount_iso {
# loopmount iso
if [ -d /mnt/isos ]
then
    echo "Work directory /mnt/isos exists, no need to create a directory"
else
    mkdir /mnt/isos
fi
mount -o loop /tmp/${SATISO} ${LOOPISO}

# show ISO has been mounted
ls -l /mnt
df -h
echo "ISO is mounted (or not)"
#pause 'Press enter to continue....'
}

function unmount_iso {
# switch back to root home dir and unmount iso
cd
umount ${LOOPISO}

# show ISO has been unmounted
df -h
echo "ISO has been unmounted,move on with next step"
#pause 'Press enter to continue....'
}

function run_package_installer {
# run satellite packager
cd ${LOOPISO}
./install_packages

# wait after installer has tried to run
echo "Install_packages has been executed, move on with next step"
#pause 'Press enter to continue....'
}

function run_sat_scenario {
# run satellite installer script
satellite-installer --scenario satellite \
--foreman-admin-username admin \
--foreman-admin-password redhat \
--foreman-admin-email 'admin@satellite.lab.example.com'

# wait after run satellite installer script
echo "Satellite installer has tried to install with scenario satellite"
#pause 'Press enter to continue....'
}

function config_hammercli {
# copy hammer cli config file
mkdir -p ~/.hammer
cat > ${HAMLOC}${HAMCONF} << EOF
:foreman:
  :host: 'satellite.lab.example.com'
  :username: 'admin'
  :password: 'redhat'
EOF
chmod 0600 ${HAMLOC}${HAMCONF}

# wait after create hammercli config file
ls -l ${HAMLOC}${HAMCONF}
echo "Hammer cli config file has been created (or not)"
#pause 'Press enter to continue....'
}

function set_firewall {
# set firewall
firewall-cmd --permanent --add-service=RH-Satellite-6 && firewall-cmd --reload

# wait after firewalld has been updated with satellite profile
firewall-cmd --list-all
echo "Satellite installer has tried to install with scenario satellite"
#pause 'Press enter to continue....'
}

function end_message {
# Satellite installation completed
echo "Satellite installed on this server, move on with populating organization, locations, users and host collections."
}

# main body
get_iso
mount_iso
run_package_installer
unmount_iso
run_sat_scenario
echo "Run config_hammercli.sh on workstation"
set_firewall
end_message

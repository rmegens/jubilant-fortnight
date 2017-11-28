#!/bin/bash
# setup users with roles and host collections for chapter 2
# v1.0, d.d. 28 nov 2017, RME

# setup users
#hammer user create --login jack \
#--auth-source-id 1 \
#--locations Boston \
#--organizations 'Operations' \
#--mail 'jack@example.com' \
#--password redhat
#
#hammer user create --login jill \
#--auth-source-id 1 \
#--locations Boston \
#--organizations 'Operations' \
#--mail 'jill@example.com' \
#--password redhat
#
#hammer user create --login ito \
#--auth-source-id 1 \
#--locations Tokyo \
#--organizations 'Finance' \
#--mail 'ito@example.com' \
#--password redhat
#
#hammer user create --login linda \
#--auth-source-id 1 \
#--locations 'San Francisco' \
#--organizations 'Finance' \
#--mail 'linda@example.com' \
#--password redhat
#
# add users to roles
hammer user add-role --role Manager --login ito
hammer user add-role --role Manager --login jack
hammer user add-role --role Viewer --login jill
hammer user add-role --role Viewer --login linda

# set default organization and location
# this setting can only be done by using the location-id and organization-id
# in this case :
org_Operations=3
org_Finance=4
loc_Boston=5
loc_sanFrancisco=6
loc_Tokyo=7

hammer user update --default-organization-id ${org_Operations} --default-location-id ${loc_Boston} --login jack
hammer user update --default-organization-id ${org_Operations} --default-location-id ${loc_Boston} --login jill
hammer user update --default-organization-id ${org_Finance} --default-location-id ${loc_sanFrancisco} --login linda
hammer user update --default-organization-id ${org_Finance} --default-location-id ${loc_Tokyo} --login ito

 
# setup host collections
hammer host-collection create --organization 'Operations' --name OpsServers
hammer host-collection create --organization 'Finance' --name FinServers
hammer host-collection create --organization 'Finance' --name FinDesktops

# show all the hard work
hammer user list
hammer user info --login jack
hammer user info --login jill
hammer user info --login ito
hammer user info --login linda
hammer host-collection list --organization 'Operations'
hammer host-collection list --organization 'Finance'

echo 'Done'

# Usefull links & resources
#Hammer cheat sheat :
#Hammer CLI :
#Your own imagination.

# create a new organization with 2 new locations. Create two new users and two new host collections.

# organization : Operations
hammer organization create --name Operations
hammer organization list

# organization : Finance
hammer organization create --name Finance
hammer organization list

# locations : 
hammer location create --name 'Boston'
hammer location create --name 'San Francisco'
hammer location create --name 'Tokyo'
hammer location list

# add locations to organization Operations
hammer location add-organization --name 'Boston' --organization Operations
hammer organization info --name Operations | grep Locations -A3

# add locations to organization Finance
hammer location add-organization --name 'San Francisco' --organization Finance
hammer location add-organization --name 'Tokyo' --organization Finance
hammer organization info --name Finance | grep Locations -A3

# users :
#  - linda, Auditor, role: Viewer(11), Location: San Francisco
#  - ito, DBA, role: Manager(7), Location : Tokyo

## List roles
hammer role list

## List organizations
hammer organization list

## List locations
hammer location list

## create user and add to (default) organization and location
## for this we first make sure we know the id's by asking out satellite with the list subcommand
hammer user create --login linda  \
--auth-source-id 1 \
--locations 'San Francisco' \
--organizations 'Finance' \
--mail linda@workstation.lab.example.com \
--password redhat

hammer user create --login ito \
--auth-source-id 1 \
--locations 'Tokyo' \
--organizations 'Finance' \
--mail ito@workstation.lab.example.com \
--password redhat

# add user to role
## List available roles
hammer role list
hammer user add-role --login linda  --role-id 11
hammer user add-role --login ito --role-id 7

# create host collections FinDesktops and FinServers in the Finance organization
hammer host-collection create --organization 'Finance' --name FinDesktops
hammer host-collection create --organization 'Finance' --name FinServers
hammer host-collection list --organization 'Finance'

# create host collections OpsDesktops and OpsServers in the Operations organization
hammer host-collection create --organization 'Operations' --name OpsDesktops
hammer host-collection create --organization 'Operations' --name OpsServers
hammer host-collection list --organization 'Operations'

# import manifests
wget http://classroom.example.com/content/courses/rh403/rhsat6.2.1/materials/manifest_acme.zip
wget http://classroom.example.com/content/courses/rh403/rhsat6.2.1/materials/manifest_finance.zip
wget http://classroom.example.com/content/courses/rh403/rhsat6.2.1/materials/manifest_operations.zip
hammer subscription upload --organization 'Operations' --file manifest_operations.zip --repository-url 'http://content.example.com/rhsat6.2.1/cdn/'
hammer subscription upload --organization 'Finance' --file manifest_finance.zip --repository-url 'http://content.example.com/rhsat6.2.1/cdn/'
hammer subscription upload --organization 'Default Organization' --file manifest_acme.zip --repository-url 'http://content.example.com/rhsat6.2.1/cdn/'

# retrieve info about repository sets
hammer product list --organization 'Finance'
hammer product list --organization 'Operations'
hammer product list --organization 'Default Organization'

# enable repository set
#hammer repository-set enable --organization "Default Organization" \
#--product "Red Hat Enterprise Linux Server" \
#--basearch "x86_64" \
#--releasever "7Server" \
#--name "Red Hat Enterprise Linux Server (RPMS)"

# enable Red Hat Enterprise Linux Server 7 (RPMs)
## for organization Finance
hammer repository-set enable --id 2456 --product-id 7 --organization 'Finance' --basearch 'x86_64' --releasever '7Server'
## for organiation Operations
hammer repository-set enable --id 2456 --product-id 17 --organization 'Operations' --basearch 'x86_64' --releasever '7Server'
## for organization Default Organization
hammer repository-set enable --id 2456 --product-id 27 --organization 'Default Organization' --basearch 'x86_64' --releasever '7Server'

# enable Red Hat Satellite Tools 6.2 (for RHEL 7 Server)
# no releasever set for this repository
## for organization Finance
hammer repository-set enable --id 4831 --product-id 7 --organization 'Finance' --basearch 'x86_64'
## for organization Operations
hammer repository-set enable --id 4831 --product-id 17 --organization 'Operations' --basearch 'x86_64'
## for organization Default Organization
hammer repository-set enable --id 4831 --product-id 27 --organization 'Default Organization' --basearch 'x86_64'


# sync repositorys
ORG='Finance'
RHT_FIN=$(hammer repository list --organization ${ORG} | grep "Satellite Tools" | cut -b 1)
hammer repository synchronize \
--organization ${ORG} \
--product-id 7 \
--id ${RHT_FIN} \
--async

RH7_FIN=$(hammer repository list --organization ${ORG} | grep "Enterprise Linux 7 Server RPMs" | cut -b 1)
hammer repository synchronize \
--organization ${ORG} \
--product-id 7 \
--id ${RH7_FIN} \
--async

# sync repositorys
ORG='Operations'
RHT_OPS=$(hammer repository list --organization ${ORG} | grep "Satellite Tools" | cut -b 1)
hammer repository synchronize \
--organization ${ORG} \
--product-id 7 \
--id ${RHT_OPS} \
--async

RH7_OPS=$(hammer repository list --organization ${ORG} | grep "Enterprise Linux 7 Server RPMs" | cut -b 1)
hammer repository synchronize \
--organization ${ORG} \
--product-id 7 \
--id ${RH7_OPS} \
--async

# sync repositorys
ORG='Default Organization'
RHT_DOR=$(hammer repository list --organization ${ORG} | grep "Satellite Tools" | cut -b 1)
hammer repository synchronize \
--organization ${ORG} \
--product-id 7 \
--id ${RHT_DOR} \
--async

RH7_DOR=$(hammer repository list --organization ${ORG} | grep "Enterprise Linux 7 Server RPMs" | cut -b 1)
hammer repository synchronize \
--organization ${ORG} \
--product-id 7 \
--id ${RH7_DOR} \
--async


# Create life cycle environments (Library -> Dev -> Prod)
## Finance
hammer lifecycle-environment create --organization 'Finance' --label 'Dev' --name 'Dev' --prior 'Library'
hammer lifecycle-environment create --organization 'Finance' --label 'Prod' --name 'Prod' --prior 'Dev'
hammer lifecycle-environment list --organization 'Finance'
## Operations
hammer lifecycle-environment create --organization 'Operations' --label 'Dev' --name 'Dev' --prior 'Library'
hammer lifecycle-environment create --organization 'Operations' --label 'Prod' --name 'Prod' --prior 'Dev'
hammer lifecycle-environment list --organization 'Operations'
## Default Organization
hammer lifecycle-environment create --organization 'Default Organization' --label 'Dev' --name 'Dev' --prior 'Library'
hammer lifecycle-environment create --organization 'Default Organization' --label 'Prod' --name 'Prod' --prior 'Dev'
hammer lifecycle-environment list --organization 'Default Organization'

# Create content view (Base)
## Finance
hammer 
## Operations
## Default Organization
:

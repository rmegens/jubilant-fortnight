#!/bin/bash
# Import manifest and initial content sync 
# v1.0, d.d. 28 nov 2017, by RME

# get the manifest from the classroomserver
cd ~
wget http://classroom.example.com/materials/manifest_operations.zip
wget http://classroom.example.com/materials/manifest_finance.zip

# import manifest into organization
hammer subscription upload \
--organization Operations \
--file ~/manifest_operations.zip \
--repository-url 'http://content.example.com/rhsat6.2.1/cdn'

hammer subscription upload \
--organization Finance \
--file ~/manifest_finance.zip \
--repository-url 'http://content.example.com/rhsat6.2.1/cdn'

# setup repositories for Operations
## id : 2456 = Red Hat Enterprise Linux 7 Server (RPMs)
## product-id : 7 = Red Hat Enterprise Linux Server
hammer repository-set enable --id 2456 \
--product-id 7 \
--basearch 'x86_64' \
--releasever '7Server' \
--organization Operations

## id : 4831 = Red Hat Satellite Tools 6.2 (RPMs)
## product-id : 7 = Red Hat Enterprise Linux Server
hammer repository-set enable --id 4831 \
--product-id 7 \
--basearch 'x86_64' \
--organization Operations

# setup repositories for Finance
## id : 2456 = Red Hat Enterprise Linux 7 Server (RPMs)
## product-id : 17 = Red Hat Enterprise Linux Server
hammer repository-set enable --id 2456 \
--product-id 17 \
--basearch 'x86_64' \
--releasever '7Server' \
--organization Operations

## id : 4831 = Red Hat Satellite Tools 6.2 (RPMs)
## product-id : 17 = Red Hat Enterprise Linux Server
hammer repository-set enable --id 4831 \
--product-id 7 \
--basearch 'x86_64' \
--organization Operations


# initiate content sync

# initiate content sync
hammer repository synchronize \
--product-id 7 \
--

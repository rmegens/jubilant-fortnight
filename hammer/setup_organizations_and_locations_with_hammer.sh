#!/bin/bash
# setup organizations and locations for chapter 2
# 1.0, d.d. 28 nov 2017, RME

# Create organizations Operations and Finance
hammer organization create --name Operations
hammer organization create --name Finance

# Create locations Boston, San Francisco and Tokyo
hammer location create --name 'Boston'
hammer location create --name 'San Francisco'
hammer location create --name 'Tokyo'

# Connect locations to organizations
hammer location add-organization --name 'Boston' --organization Operations
hammer location add-organization --name 'San Francisco' --organization Finance
hammer location add-organization --name 'Tokyo' --organization Finance

# show your work
hammer organization list
echo "Show locations for organization Finance"
hammer organization info --name 'Finance' | grep Locations -A3
echo "Show locations for organization Operations"
hammer organization info --name 'Operations' | grep Locations -A2


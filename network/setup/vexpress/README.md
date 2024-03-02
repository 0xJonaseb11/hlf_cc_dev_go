PLEASE NOTE
===========
Express setup is available ONLY for VirtualBox on Mac/Ubuntu/Windows
It will NOT work for HyperV on Windows | Any other Hypervisor


Virtual Box Express Setup
=========================
Pre-Work:
* Needed if you already had a VM setup under the project folder
* Execute  
> vagrant destroy
* Delete the .vagrant folder under the project root


1. Change the Vagrantfile in the project root folder

# Comment the line below by adding # in the beginning of the line
 config.vm.box = "bento/ubuntu-16.04"

# UNComment the line below by removing the # from the begining of the line
# config.vm.box = "acloudfan/hlfdev1.4"

2. Execute the vagrant up command & log in

PS: Make sure there is already no VM setup in current folder
    If in doubt just destroy using  
    > vagrant destroy

> vagrant up
> vagrant ssh

3. Execute the initialization script

> cd network/setup/vexpress
> chmod 755 *.sh
> ./init-vexpress.sh

4. Validate the setup

> ../validate-setup.sh

If all validations are successful the CONGRATULATIONS !!! 
you are all set to start learning Chaincode Development :)


Curious how this is working?
============================
These are some commands used to create the virtual box that is now hosted in the Vagrant cloud.
Checkout the box in Vagrantfile



VBox
====
https://scotch.io/tutorials/how-to-create-a-vagrant-base-box-from-an-existing-one

vagrant box list
vagrant box remove  BOX-Name
vagrant package --output acloudfan-hlfdev-2.0-0.box
vagrant box add hldfdev1.4 .\acloudfan-hlfdev-1.4-1.5.box

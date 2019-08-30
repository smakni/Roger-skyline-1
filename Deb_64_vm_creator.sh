#!/bin/bash

read -p "Insert vm's name : " name

read -p "Inser iso's path : " iso

VBoxManage createvm --name $name -ostype Debian_64 --register

VBoxManage modifyvm $name --memory 1024

VBoxManage createhd --filename ~/goinfre/$name.vdi --sizebyte 8000000000 --format VDI

VBoxManage storagectl $name --name "SATA Controller" --add sata --controller IntelAhci

VBoxManage storageattach $name --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium ~/goinfre/$name.vdi

VBoxManage storagectl $name --name "IDE Controller" --add ide --controller PIIX4

VBoxManage storageattach $name --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium $iso

VBoxManage startvm $name

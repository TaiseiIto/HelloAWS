#!/bin/sh

check_package_file=check_package.txt
packages="docker git make vim"

#yum update -y

for package in $packages; do
	uninstalled=$(yum list installed | awk '{print $1}' | grep $package)
	unupdated=$(yum list updates | awk '{print $1}' | grep $package)
	if [ ${#uninstalled} -eq 0 ] || [ ${#unupdated} -gt 0 ]; then
		echo $package " uninstalled or unupdated!"
	fi
done


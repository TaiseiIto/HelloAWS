#!/bin/sh

check_package_file=check_package.txt
packages="docker git make vim"

#yum update -y

for package in $packages; do
	check=$(yum list installed | awk '{print $1}' | grep $package)
	if [ ${#check} -eq 0 ]; then
		echo $package " uninstalled!"
	fi
done


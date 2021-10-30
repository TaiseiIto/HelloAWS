#!/bin/sh

check_package_file=check_package.txt
packages="docker git make vim"

yum update -y

for package in $packages; do
	yum list installed | awk '{print $1}' | grep $package > $check_package_file
	cat $check_package_file
done


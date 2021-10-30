#!/bin/sh

currentdir=$(pwd)
cd $(dirname $0)
echo -n "Your GitHub email:"
read email
echo -n "Your GitHub name:"
read name
git config --global user.email $email
git config --global user.name $name
cd $currentdir


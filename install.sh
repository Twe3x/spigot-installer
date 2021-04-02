#!/bin/sh
clear
echo installling git...
sleep 2
sudo apt install git screen -y

clear

read -p "Enter the server name: " name

dir=/home/Spigot/$name/

if [ -e /home/Spigot/ ]
then
	sleep 1
else
	mkdir /home/Spigot/
fi

if [ -e $dir ]
then
	sleep 1
else
	mkdir $dir
fi

cd $dir
echo '#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula).
#Fri Apr 02 23:31:20 CEST 2021
eula=true' >$dir/eula.txt

if [ -e $dir/BuildTools/ ]
then
	sleep 1
else
	mkdir $dir/BuildTools/
fi
cd $dir/BuildTools/

curl -z BuildTools.jar -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

clear

read -p "Enter the version: " version
java -jar BuildTools.jar --rev ${version:-latest}

mv spigot-$version.jar ../
rm -rf $dir/BuildTools/

clear

echo screen -dmS $name java -jar spigot-$version.jar >$dir/start.sh

echo "Server was created successfully"

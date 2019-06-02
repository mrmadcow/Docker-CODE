#!/bin/sh

# Update installed packages
apt-get update && apt-get -y upgrade

# Install HTTPS transport
apt-get -y install apt-transport-https

# Install locales
apt-get -y install locales-all

# Add Collabora repos
echo "deb https://collaboraoffice.com/repos/CollaboraOnline/CODE /" > /etc/apt/sources.list.d/collabora.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 6CCEA47B2281732DF5D504D00C54D189F4BA284D
apt-get update

# Install the Collabora packages
apt-get -y install loolwsd code-brand collaboraoffice6.0-dict* collaboraofficebasis6.0*

# Install inotifywait and killall to automatic restart loolwsd, if loolwsd.xml changes
apt-get -y install inotify-tools psmisc

# Install MS TTF fonts
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
apt-get install --yes --no-install-recommends ttf-mscorefonts-installer

# Cleanup
rm -rf /var/lib/apt/lists/*

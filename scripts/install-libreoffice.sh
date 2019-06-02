#!/bin/sh

# Update installed packages
apt-get update && apt-get -y upgrade

# Install HTTPS transport
apt-get -y install apt-transport-https

# Install locales
apt-get -y install locales-all

# Install MS TTF fonts
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
# MS TTF
apt-get install --yes --no-install-recommends \
	ttf-mscorefonts-installer \
	fonts-ancient-scripts \
	fonts-dkg-handwriting \
	fonts-georgewilliams \
	fonts-isabella \
	fonts-yanone-kaffeesatz \
	ttf-adf-baskervald \
	ttf-adf-gillius \
	ttf-adf-mekanus \
	ttf-adf-oldania \
	ttf-adf-romande \
	ttf-adf-switzera \
	ttf-adf-universalis \
	ttf-adf-verana \
	fonts-aenigma \
	curl
# Cleartype fonts
mkdir ~/.fonts
mkdir /usr/share/fonts/msttvistafonts
curl http://plasmasturm.org/code/vistafonts-installer/vistafonts-installer | bash
cp ~/.fonts/* /usr/share/fonts/msttvistafonts/
fc-cache

# Add Collabora repos
echo "deb https://collaboraoffice.com/repos/CollaboraOnline/CODE /" > /etc/apt/sources.list.d/collabora.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 6CCEA47B2281732DF5D504D00C54D189F4BA284D
apt-get update

# Install the Collabora packages
apt-get -y install loolwsd code-brand collaboraoffice6.0-dict* collaboraofficebasis6.0*

# Install inotifywait and killall to automatic restart loolwsd, if loolwsd.xml changes
apt-get -y install inotify-tools psmisc

# Cleanup
rm -rf /var/lib/apt/lists/*

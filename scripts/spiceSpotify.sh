#!/bin/bash

echo "###########################"
echo "Aggiungo permessi a spotify"
echo "###########################"
sudo chmod a+wr /var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify
sudo chmod a+wr -R /var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify/Apps

echo "###########################"
echo "Riapplico la patch"
echo "###########################"

spicetify backup apply

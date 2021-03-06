#!/bin/bash
# Libresonic installation

mkdir -p $MEDIA_PATH/sound/music
mkdir -p $MEDIA_PATH/sound/podcast
mkdir -p $MEDIA_PATH/sound/playlist
mkdir -p $MEDIA_PATH/sound/other

cat files/includes/libresonic.docker >> docker-compose.yml

sed -i "s@FQDN@$Ls_SDOM.$DOMAIN@g" docker-compose.yml
sed -i "s@MUSIC@$MEDIA_PATH/sound/music@g" docker-compose.yml
sed -i "s@PODCASTS@$MEDIA_PATH/sound/podcast@g" docker-compose.yml
sed -i "s@PLAYLISTS@$MEDIA_PATH/sound/playlist@g" docker-compose.yml
sed -i "s@MEDIA@$MEDIA_PATH/sound/other@g" docker-compose.yml
sed -i "s@stream-music_libresonic@$Ls_CNAME@g" docker-compose.yml

# Set Muximum configuration
cat <<EOF >> files/includes/muximux.conf

[Libresonic]
name = "Libresonic"
url = "https://192.168.42.52"
scale = 1
icon = "muximux-music"
color = "#cc7b19"
enabled = "true"
EOF

sed -i "s@192.168.42.52@$Ls_SDOM.$DOMAIN@g" files/includes/muximux.conf
INSTALLED+=('Ls')

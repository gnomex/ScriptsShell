#!/bin/bash
#
# Download a m3u8 and save to a .mp4 file
#
##########

M3U8FILE="$1"
SAVEAS="$2"
FFPARAMS='-acodec copy -vcodec copy -y -bsf aac_adtstoasc -loglevel verbose -f mp4'

ffmpeg -i "$M3U8FILE" "$FFPARAMS" "$SAVEAS"

#!/bin/bash

# This is is to scrape youtube podcasts into audio format, then upload them to 
# overcast
OUTPUT_DIRECTORY=~/podcasts

cd $OUTPUT_DIRECTORY

cat yt-podcasts.txt | while read playlist
do
	youtube-dl --extract-audio --audio-format mp3 --audio-quality 320k --dateafter now-7days --yes-playlist \
		--restrict-filenames --ignore-errors \
		--output '%(playlist_title)s/%(playlist_title)s-%(upload_date)s.%(ext)s' \
		--download-archive 'archive.txt' \
		$playlist
done

ls -d */ | while read podcast
do
	overcast-uploader -e benjamin.heebsh@gmail.com -p a076T1mv#^e7W4NL -d $podcast 
done

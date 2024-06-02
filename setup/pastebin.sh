#!/bin/sh

# This isn't needed, and installing should be done through the github tool

# Paste at Pastebin.com using command line (browsers are slow, right?)
# coder : Anil Dewani
# date : Novemeber 7, 2010

# revised on June 22, 2018 by Jonathan Guenther
# https://gist.github.com/jonguenther/e43977be33827ed45bc5b32a394cdf65

FILE_PATH="${1}" # content of your bin\
DEV_KEY="${2}" #PASTEBIN_DEV_KEY
NAME="${3}" # title of your bin

echo_help() {
    echo "USAGE: ./pastebin.sh path dev_key <title>"
}

if [ "$FILE_PATH" = '-h' ] || [ "$FILE_PATH" = '' ] || [ "$FILE_PATH" = '--help' ] || [ "$DEV_KEY" = '' ]
then
    echo_help
    exit 0
elif [ ! -e "$FILE_PATH" ]; then
    echo "File not found: $FILE_PATH"
    echo_help
    exit 1
fi;

INPUT=$(cat "$FILE_PATH")

if [ "$NAME" = '' ]; then
    NAME=$(basename "$FILE_PATH")
fi;


#PRIVATE=0 # if you want to make your paste public
PRIVATE=1 # if you want to make your paste private for testing
#PRIVATE=2 # if you want to make your paste unlisted <- recommended after testing

# Your Data
EMAIL= # deprecated (...?)
TYPE= # set File type (e.g. text, php, js; for more go to -dead-link- )
#USER_KEY= # your userkey

# for more options see the pastebin.com API ( https://pastebin.com/doc_api )

# combine to query
QUERY="api_paste_private=${PRIVATE}&api_paste_code=${INPUT}&api_paste_name=${NAME}&paste_email=${EMAIL}&api_paste_format=${TYPE}&api_option=paste&api_dev_key=${DEV_KEY}"

#echo curl -d "${QUERY}" https://pastebin.com/api/api_post.php

# post data to pastebin.com API
PASTEBIN_URL=$(curl -d "${QUERY}" https://pastebin.com/api/api_post.php)
echo "UPLOADED $NAME to $PASTEBIN_URL"

# the command will return the pastebin.com link to the newly created bin if successful
# if unsuccessful, it will return the errorcode provided by pastebin.com

# Note: If you just want to upload code / text to copy&paste between two machines quick and dirty, I suggest you use termbin.com
# Just type `echo your text goes here or maybe some file or whatever you want | nc https://termbin.com 9999`
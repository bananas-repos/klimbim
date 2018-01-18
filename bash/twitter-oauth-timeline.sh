#!/bin/bash
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the COMMON DEVELOPMENT AND DISTRIBUTION LICENSE
#
# You should have received a copy of the
# COMMON DEVELOPMENT AND DISTRIBUTION LICENSE (CDDL) Version 1.0
# along with this program.  If not, see http://www.sun.com/cddl/cddl.html

# 2013 http://www.bananas-playground.net

#
# fetch the timeline from given twitter user
# based on :
# https://github.com/gianu/latest_tweets/blob/master/latest_tweets.sh
# https://dev.twitter.com/discussions/14460
#

TIMESTAMP=`date +%s`;
NONCE=`date +%s%T%N | openssl base64 | sed -e s'/[+=/]//g'`
SCREEN_NAME="YOUR_TWITTER_NAME";
TWEET_COUNT=10;
OUTPUT_FILE="/path/to/output.json"

CONSUMER_KEY="YOUR_CONSUMER_KEY"
CONSUMER_SECRET="YOUR_CONSUMER_SECRET"
OAUTH_TOKEN="YOUR_OAUTH_TOKEN"
OAUTH_SECRET="YOUR_OUTH_SECRET"

signature_base_string="GET&https%3A%2F%2Fapi.twitter.com%2F1.1%2Fstatuses%2Fuser_timeline.json&count%3D${TWEET_COUNT}%26oauth_consumer_key%3D${CONSUMER_KEY}%26oauth_nonce%3D${NONCE}%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D${TIMESTAMP}%26oauth_token%3D${OAUTH_TOKEN}%26oauth_version%3D1.0%26screen_name%3D${SCREEN_NAME}"
signature_key="${CONSUMER_SECRET}&${OAUTH_SECRET}"
oauth_signature=`echo -n ${signature_base_string} | openssl dgst -sha1 -hmac ${signature_key} -binary | openssl base64 | sed -e s'/+/%2B/' -e s'/\//%2F/' -e s'/=/%3D/'`

header="Authorization: OAuth oauth_consumer_key=\"${CONSUMER_KEY}\", oauth_nonce=\"${NONCE}\", oauth_signature=\"${oauth_signature}\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"${TIMESTAMP}\", oauth_token=\"${OAUTH_TOKEN}\", oauth_version=\"1.0\""

wget -q --cache=off --output-document="${OUTPUT_FILE}" "https://api.twitter.com/1.1/statuses/user_timeline.json?count=${TWEET_COUNT}&screen_name=${SCREEN_NAME}" --header "Content-Type: application/x-www-form-urlencoded" --header "${header}";

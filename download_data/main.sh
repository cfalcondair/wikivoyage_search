#!/bin/sh

echo "Downloading wikivoyage data"
ARTICLES_FILE="page_articles.xml"
WIKIVOYAGE_DUMP_FILE="enwikivoyage-20170101-pages-articles.xml"

URL=https://dumps.wikimedia.org/enwikivoyage/20170101/$WIKIVOYAGE_DUMP_FILE.bz2
echo "Retrieving file from "$URL

wget -q -P /tmp/ $URL
echo "Unzipping file..."
bzip2 -d /tmp/$WIKIVOYAGE_DUMP_FILE.bz2
mv /tmp/$WIKIVOYAGE_DUMP_FILE /tmp/$ARTICLES_FILE
echo "Download complete."


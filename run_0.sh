#!/bin/sh

echo "Downloading wikivoyage data"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DATA_DIR=$DIR"/data/"
ARTICLES_FILE="page_articles.xml"
WIKIVOYAGE_DUMP_FILE="enwikivoyage-20170101-pages-articles.xml.bz2"

echo "Retrieving data..."
if ! [ -f $DATA_DIR$ARTICLES_FILE ]
then
  wget https://dumps.wikimedia.org/enwikivoyage/20170101/enwikivoyage-20170101-pages-articles.xml.bz2
  mkdir $DATA_DIR
  mv $WIKIVOYAGE_DUMP_FILE $DATA_DIR
  bzip2 -d $DATA_DIR$WIKIVOYAGE_DUMP_FILE
  mv $DATA_DIR"enwikivoyage-20170101-pages-articles.xml" $DATA_DIR$ARTICLES_FILE
else
  echo "Already downloaded data"
fi

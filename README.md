# wikivoyage_search
An Elasticsearch search engine with the Wikivoyage data
Instructions:

Operate this in a linux environment:
``Linux vm-jessie 3.16.0-4-amd64 #1 SMP Debian 3.16.39-1 (2016-12-30) x86_64 GNU/Linux``

run the 5 shell scripts in the location that are.

Description of each shell script:
1: Builds the docker image to download and parse the raw data.
2: Initialises the elasticsearch image and starts the service
3: Writes the mapping for the wikivoyage data
4: Waits for the elasticsearch image to be up and running and then it will start to write the data to
   the index.
5: Will query the runninng elasticsearch image (need to pass the query arguments to it)
   ie. source run_5.sh "museums in melbourne"
   It will return a list of the top ten most relevant items related to that search.

What are the 2-3 most common relevance challenges?

I would argue that the most common relevancy challenges for a search engine of
this nature would be:
- finding associated, but not explicitly declared, pharses or words to assist in the search query. For example
  if one were to search for 'galleries in berlin', it should also be looking for 'arthouses in berlin' or
  any other places that might house art. In order to solve this, the stack would need to take each term in the
  query sentence, find associative terms and include them in the query. This could be achieved by using an synonym lookup table 
  like the wordnet corpus which has an API in the python nltk library.
  

# wikivoyage_search
An Elasticsearch search engine with the Wikivoyage data


Instructions:

Operate this in a linux environment:
``Linux vm-jessie 3.16.0-4-amd64 #1 SMP Debian 3.16.39-1 (2016-12-30) x86_64 GNU/Linux``

It also requires:
- Docker version 17.05.0-ce, build 89658be(https://docs.docker.com/engine/installation/linux/ubuntu/)
- docker-compose version 1.13.0, build 1719ceb(https://docs.docker.com/compose/install/)



How to build search engine:
``source build_search_engine.sh``

This will run run 5 operations:
Description of operation:
- 0: Download the data
- 1: Builds the docker image to parse the raw data.
- 2: Initialises the elasticsearch image and starts the service
- 3: Writes the mapping for the wikivoyage data
- 4: Waits for the elasticsearch image to be up and running and then it will start to write the data to
   the index.

To execute query, run:
``source run_5.sh "museums in melbourne"``

This will query the runninng elasticsearch image. It will return a list of the top ten most relevant items related to that search.

What are the 2-3 most common relevance challenges?

I would argue that the most common relevancy challenges for a search engine of
this nature would be:
- Finding associated, but not explicitly declared, pharses or words to assist in the search query. For example
  if one were to search for 'galleries in berlin', it should also be looking for 'arthouses in berlin' or
  any other places that might house art. In order to solve this, the stack would need to take each term in the
  query sentence, find associative terms and include them in the query. This could be achieved by using an synonym lookup table 
  like the wordnet corpus which has an API in the python nltk library. Elasticsearch also has the notion of proximity matching of keywords
  or look-a-likes which could add implicit results to a search repsonse.
  
- The next challenge presents an ongoing issue regarding the accuracy/precision of relevancy. The notion of relevancy 
  can easily be measured on small data sets with labelling, but as the dataset grows larger, the task becomes more ominous.
  We could label the relevancy of a document for a particular query and measure the success of our engine,
  but when the query is client facing, and the permutations of queries and possible rankings balloons in size, the measure of success is more subjective.
  So we need to find other data to address to make it objective as possible. This can be achieved with measuring user baehaviour
  and their repsonse to the search engine's results. This would consist of a log of user queries, and the respective actions of the
  user, if they clicked on the first two or three links, completed their business and moved on then that was a relevant search, with
  some exceptions obviously. If they are scrolling through a search and not clicking, that is a strong indication of a poor search result.
  If you were to map queries to user behaviour, visualise in different ways, you could start to understand the health of your releancy algorthim.
  This can then be used as a 'objective' metric to relevancy success, using A/B testing and other metrics to fine-tune the algorithm.

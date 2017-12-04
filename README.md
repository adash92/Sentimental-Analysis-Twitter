# Sentimental-Analysis-Twitter


There are are 5 scripts to run the analysis. 

Script #1 : 00_INSTALL_PACKAGES.R --> This script is required for installing all the packages required for the analysis.
Script #2 : 01_NAMED_ENTITY_API_1.R --> This script collects all the data from Twitter API and finds the frequent named entities.
Script #3 : 02_NAMED_ENTITY_API_2.R --> This script collects all the data from NY Times API using the above identified named entities.
Script #4 : 03_SENTIMENT_ANALYSIS.R --> This script performs a sentimental analysis of the data collect from Script #2 & Script #3 and shows the results as positive and negative sentiment.

The requirement of the above code is broadly divided into the following sub-tasks:

1. Collect a random sample of 10K tweets using the Twitter API

2. From each tweet, parse the top 5 named-entities (Name, Person, Location, Product etc.)

3. Collect the latest news from various news source APIs featuring the named-entities you got from Step 2 (use at least one other API/library other than Twitter's to collect this data)

4. Perform a Sentiment Analysis on the data collected in Step 1 and 3, and compare the twitter and news sentiment for the common named-entities. Report these results in a graph.

5. If you can setup your code on GitHub and run it an application, we can test it sitting here also.

############################################################################################################
#################################### Using Twitter API to collect tweets ###################################
#Reference Source website : https://opensource.com/article/17/6/collecting-and-mapping-twitter-data-using-r
############################################################################################################

# Declaring the Twitter API Setting information for authentication
API_Key               <- "*****"
API_Secret            <- "*****"
Access_Token          <- "*****"
Access_Token_Secret   <- "*****"

#Connecting to Twitter to access the API
twitteR:::setup_twitter_oauth(API_Key, API_Secret, Access_Token, Access_Token_Secret)
 
#Extract tweets from Twitter API. For testing purposes same of 1000 should be sufficient.
Twitter_tweets <- searchTwitter(" ", n = 1000, lang = "en")

#Save results into a data frame
Twitter_tweets_API_1 <- twListToDF(Twitter_tweets)

#Writing the data frame into a csv file.
#write.csv(Twitter_tweets_API_1, "C:/DESKTOP/Home/Twitter_tweets_API_1.csv") 

#parsing the code
Twitter_tweets_API_1_Col1 <- Twitter_tweets_API_1[,1]
Twitter_tweets_API_1_Col1_Sample <- Twitter_tweets_API_1_Col1[1:1000]

#Generate an annotator for sentences and words to compute annotations
sent_ann <- Maxent_Sent_Token_Annotator()
word_ann <- Maxent_Word_Token_Annotator()

#Generating annotators for common named entities like person, location, organisation, money/currency and time/date
person_ann <- Maxent_Entity_Annotator(kind = "person")
location_ann <- Maxent_Entity_Annotator(kind = "location")
organization_ann <- Maxent_Entity_Annotator(kind = "organization")
date_ann <- Maxent_Entity_Annotator(kind = "date")
money_ann <- Maxent_Entity_Annotator(kind = "money")

#Creating a combination of all words and sentences annotations 
pipeline <- list(sent_ann,
                 word_ann,
                 person_ann,
                 location_ann,
                 organization_ann,
                 date_ann,
                 money_ann)

#Computing annotations from given text and current annotations
bio_annotations <- annotate(Twitter_tweets_API_1_Col1_Sample, pipeline)

#Merging the newly computed annotations with the current ones
bio_doc <- AnnotatedPlainTextDocument(Twitter_tweets_API_1_Col1_Sample, bio_annotations)

#Creating a function - 'entities' to segregate into different named entities
entities <- function(doc, kind) {
  s <- doc$content
  a <- annotations(doc)[[1]]
  if(hasArg(kind)) {
    k <- sapply(a$features, `[[`, "kind")
    s[a[k == kind]]
  } else {
    s[a[a$type == "entity"]]
  }
}

person <- entities(bio_doc, kind = "person")
location <- entities(bio_doc, kind = "location")
organization <- entities(bio_doc, kind = "organization")
date <- entities(bio_doc, kind = "date")
money <- entities(bio_doc, kind = "money")


#Cleaning data for named entity - person
person_API_1 <- do.call("rbind", lapply(person, as.data.frame))
person_API_1 <- sapply(person_API_1,function(row) iconv(row, "latin1", "ASCII", sub=""))
person_API_1 <- gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", person_API_1)
person_API_1 <- gsub("[\n]", "", person_API_1)
person_API_1 <- gsub('"', "", person_API_1)
person_API_1 <- person_API_1[!apply(is.na(person_API_1) | person_API_1 == "", 1, all),]

person <- do.call("rbind", lapply(person_API_1, as.data.frame))
colnames(person)<-c("person")
#View(person)



#Cleaning data for named entity - location
location_API_1 <- do.call("rbind", lapply(location, as.data.frame))
location_API_1 <- sapply(location_API_1,function(row) iconv(row, "latin1", "ASCII", sub=""))
location_API_1 = gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", location_API_1)
location_API_1 = gsub("[\n]", "", location_API_1)
location_API_1<- gsub("[^A-Za-z0-9 ]","",location_API_1)
location_API_1 <- gsub('"', "", location_API_1)
location_API_1 <- location_API_1[!apply(is.na(location_API_1) | location_API_1 == "", 1, all),]

location <- do.call("rbind", lapply(location_API_1, as.data.frame))
colnames(location)<-c("location")
View(location)


#Cleaning data for named entity - organization
organization_API_1 <- do.call("rbind", lapply(organization, as.data.frame))
organization_API_1 <- sapply(organization_API_1,function(row) iconv(row, "latin1", "ASCII", sub=""))
organization_API_1 = gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", organization_API_1)
organization_API_1 = gsub("[\n]", "", organization_API_1)
organization_API_1<- gsub("[^A-Za-z0-9 ]","",organization_API_1)
organization_API_1 <- gsub('"', "", organization_API_1)
organization_API_1 <- organization_API_1[!apply(is.na(organization_API_1) | organization_API_1 == "", 1, all),]

organization <- do.call("rbind", lapply(organization_API_1, as.data.frame))
colnames(organization)<-c("organization")
View(organization)


#Cleaning data for named entity - money/currency
money_API_1 <- do.call("rbind", lapply(money, as.data.frame))
money_API_1 <- sapply(money_API_1,function(row) iconv(row, "latin1", "ASCII", sub=""))
money_API_1 = gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", money_API_1)
money_API_1 = gsub("[0-9]", "", money_API_1)
money_API_1 = gsub("[?]", "", money_API_1)
money_API_1 = gsub("[\n]", "", money_API_1)
money_API_1 = gsub("[$]", "", money_API_1)
money_API_1<- gsub("[^A-Za-z0-9 ]","",money_API_1)
money_API_1 <- gsub('"', "", money_API_1)
money_API_1 <- money_API_1[!apply(is.na(money_API_1) | money_API_1 == "", 1, all),]

money <- do.call("rbind", lapply(money_API_1, as.data.frame))
colnames(money)<-("money")
View(money)

#Cleaning data for named entity - date
date_API_1 <- do.call("rbind", lapply(date, as.data.frame))
date_API_1 <- sapply(date_API_1,function(row) iconv(row, "latin1", "ASCII", sub=""))
date_API_1 = gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", date_API_1)
date_API_1 = gsub("[0-9]", "", date_API_1)
date_API_1 = gsub("[\n]", "", date_API_1)
date_API_1 <- gsub("[.]","",date_API_1) 
date_API_1 <- gsub("[\n]","",date_API_1)
date_API_1 <- gsub("[?]","",date_API_1)
date_API_1 <- str_replace_all(date_API_1, "[[:punct:]]", " ")
date_API_1 <- gsub("[  ]"," ",date_API_1)
date_API_1 <- gsub("[   ]"," ",date_API_1)
date_API_1 <- gsub("  "," ",date_API_1)
date_API_1 <- gsub('[[:digit:]]+', '', date_API_1) 
date_API_1 = date_API_1[date_API_1 != ""]
date_API_1<- gsub("[^A-Za-z0-9 ]","",date_API_1)
date_API_1 <- gsub('"', "", date_API_1)
date_API_1 <- gsub('tcomvvXHD', "", date_API_1)
date <- do.call("rbind", lapply(date_API_1, as.data.frame))
date <- date[!apply(is.na(date) | date == "", 1, all),]
date <- do.call("rbind", lapply(date_API_1, as.data.frame))

colnames(date)<-c("date")
View(date)


#Writing the scripts to a csv file
#write.csv(person, "C:/DESKTOP/Home/person.csv") 
#write.csv(location, "C:/DESKTOP/Home/location.csv") 
#write.csv(organization, "C:/DESKTOP/Home/organization.csv") 
#write.csv(money, "C:/DESKTOP/Home/money.csv") 
#write.csv(date, "C:/DESKTOP/Home/date.csv") 

#Collecting the most frequent named entity in each category
person_entity_final <- tail(names(sort(table(person))), 1)
location_entity_final <- tail(names(sort(table(location))), 1)
organization_entity_final <- tail(names(sort(table(organization))), 1)
money_entity_final <- tail(names(sort(table(money))), 1)
date_entity_final <- tail(names(sort(table(date))), 1)


#Cleaning the data frame from twitter
Twitter_tweets_Sample_API_1 <- do.call("rbind", lapply(Twitter_tweets_API_1_Col1_Sample, as.data.frame))
Twitter_tweets_Sample_API_1 <- sapply(Twitter_tweets_Sample_API_1,function(row) iconv(row, "latin1", "ASCII", sub=""))
Twitter_tweets_Sample_API_1 = gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", Twitter_tweets_Sample_API_1)
Twitter_tweets_Sample_API_1 = gsub("[\n]", "", Twitter_tweets_Sample_API_1)


colnames(Twitter_tweets_Sample_API_1)<-c("tweet")
View(Twitter_tweets_Sample_API_1)


#Collecting all tweets which have the named entities for each category
person_entity_API_1       <- Twitter_tweets_Sample_API_1[grep(person_entity_final, Twitter_tweets_Sample_API_1)]
location_entity_API_1     <- Twitter_tweets_Sample_API_1[grep(location_entity_final, Twitter_tweets_Sample_API_1)]
organization_entity_API_1 <- Twitter_tweets_Sample_API_1[grep(organization_entity_final, Twitter_tweets_Sample_API_1)]
date_entity_API_1         <- Twitter_tweets_Sample_API_1[grep(date_entity_final, Twitter_tweets_Sample_API_1)]
money_entity_API_1        <- Twitter_tweets_Sample_API_1[grep(money_entity_final, Twitter_tweets_Sample_API_1)]


#Converting into a data frame and updating column headers names
person_entity_API_1 <- do.call("rbind", lapply(person_entity_API_1, as.data.frame))
colnames(person_entity_API_1)<-c("person")

location_entity_API_1 <- do.call("rbind", lapply(location_entity_API_1, as.data.frame))
colnames(location_entity_API_1)<-c("location")

organization_entity_API_1 <- do.call("rbind", lapply(organization_entity_API_1, as.data.frame))
colnames(organization_entity_API_1)<-c("organization")

date_entity_API_1 <- do.call("rbind", lapply(date_entity_API_1, as.data.frame))
colnames(date_entity_API_1)<-c("date")

money_entity_API_1 <- do.call("rbind", lapply(money_entity_API_1, as.data.frame))
colnames(money_entity_API_1)<-c("money")


#list of named entities available from API 1
#View(person_entity_API_1)
#View(location_entity_API_1)
#View(organization_entity_API_1)
#View(date_entity_API_1)
#View(money_entity_API_1)

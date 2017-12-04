######################################################################################
######## SENTIMENTAL ANALYSIS FOR NAMED ENTITIES COLLECTED FROM API-1 & API-2 ########
#Reference Source website : https://github.com/rOpenGov/rtimes
######################################################################################

#Importing the common positive and negative words lists into data sets
pos.words = scan('C:/DESKTOP/Home/twitter-sentiment-analysis-tutorial-201107-master/twitter-sentiment-analysis-tutorial-201107-master/data/opinion-lexicon-English/positive-words.txt', what='character', comment.char=';')
neg.words = scan('C:/DESKTOP/Home/twitter-sentiment-analysis-tutorial-201107-master/twitter-sentiment-analysis-tutorial-201107-master/data/opinion-lexicon-English/negative-words.txt', what='character', comment.char=';')

#Adding more common words to positive and negative databases
pos.words=c(pos.words, 'Congrats', 'prizes', 'prize', 'thanks', 'thnx', 'Grt', 'gr8', 'plz', 'trending', 'recovering', 'brainstorm', 'leader')
neg.words = c(neg.words, 'Fight', 'fighting', 'wtf', 'arrest', 'no', 'not')

#list of named entities available from API 1
#View(person_entity_API_1)
#View(location_entity_API_1)
#View(organization_entity_API_1)
#View(date_entity_API_1)
#View(money_entity_API_1)

#list of named entities available from API 2
#View(person_entity_API_2_final)
#View(location_entity_API_2_final)
#View(organization_entity_API_2_final)
#View(money_entity_API_2_final)
#View(date_entity_API_2_final)

# Initialising the variables
sentences <- NULL
sentence <- NULL

#Function to provide score of a sentense as per the frequency of negative and positive words

score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{
  require(plyr)
  require(stringr)
  list=lapply(sentences, function(sentence, pos.words, neg.words)
  {
    sentence = gsub('[[:punct:]]',' ',sentence)
    sentence = gsub('[[:cntrl:]]','',sentence)
    sentence = gsub('\\d+','',sentence)
    sentence = gsub('\n','',sentence)
    
    sentence = tolower(sentence)
    word.list = str_split(sentence, '\\s+')
    words = unlist(word.list)
    pos.matches = match(words, pos.words)
    neg.matches = match(words, neg.words)
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    pp=sum(pos.matches)
    nn = sum(neg.matches)
    score = sum(pos.matches) - sum(neg.matches)
    list1=c(score, pp, nn)
    return (list1)
  }, pos.words, neg.words)
  score_new=lapply(list, `[[`, 1)
  pp1=score=lapply(list, `[[`, 2)
  nn1=score=lapply(list, `[[`, 3)  
  
  scores.df = data.frame(score=score_new, text=sentences)
  positive.df = data.frame(Positive=pp1, text=sentences)
  negative.df = data.frame(Negative=nn1, text=sentences)
  
  list_df=list(scores.df, positive.df, negative.df)
  return(list_df)
}

##########################################################################################################
########################### SENTIMENTAL ANALYSIS FOR NAMED ENTITY FROM API - 1 ###########################
##########################################################################################################


#Assigning the sentiment obtained for each named entity from API-1
person_entity_API_1_result = score.sentiment(person_entity_API_1, pos.words, neg.words)
location_entity_API_1_result = score.sentiment(location_entity_API_1, pos.words, neg.words)
organization_entity_API_1_result = score.sentiment(organization_entity_API_1, pos.words, neg.words)
date_entity_API_1_result = score.sentiment(date_entity_API_1, pos.words, neg.words)
money_entity_API_1_result = score.sentiment(money_entity_API_1, pos.words, neg.words)


#View(person_entity_API_1_result)
#View(location_entity_API_1_result)
#View(organization_entity_API_1_result)
#View(date_entity_API_1_result)
#View(money_entity_API_1_result)


#list of named entities available from API 1
#View(person_entity_API_1)
#View(location_entity_API_1)
#View(organization_entity_API_1)
#View(date_entity_API_1)
#View(money_entity_API_1)

###########################################
###### SENTIMENTAL ANALYSIS FOR PERSON ######
###########################################

#Creating a copy of result data frame
person_entity_API_1_result_Column_1=person_entity_API_1_result[[1]]
person_entity_API_1_result_Column_2=person_entity_API_1_result[[2]]
person_entity_API_1_result_Column_3=person_entity_API_1_result[[3]]


#Creating three different data frames for Score, Positive and Negative
#Storing the first row(Containing the sentiment scores) in variable q
person_entity_API_1_result_Score=person_entity_API_1_result_Column_1[1,]
person_entity_API_1_result_Positive=person_entity_API_1_result_Column_2[1,]
person_entity_API_1_result_Negative=person_entity_API_1_result_Column_3[1,]
person_entity_API_1_result_Score_1=melt(person_entity_API_1_result_Score, ,var='Score')
person_entity_API_1_result_Positive_2=melt(person_entity_API_1_result_Positive, ,var='Positive')
person_entity_API_1_result_Negative_3=melt(person_entity_API_1_result_Negative, ,var='Negative') 
person_entity_API_1_result_Score_1['Score'] = NULL
person_entity_API_1_result_Positive_2['Positive'] = NULL
person_entity_API_1_result_Negative_3['Negative'] = NULL


#Creating data frame
person_entity_API_1_result_table1 = data.frame(Text=person_entity_API_1_result[1], Score=person_entity_API_1_result_Score_1)
person_entity_API_1_result_table2 = data.frame(Text=person_entity_API_1_result[2], Score=person_entity_API_1_result_Positive_2)
person_entity_API_1_result_table3 = data.frame(Text=person_entity_API_1_result[3], Score=person_entity_API_1_result_Negative_3)

#Merging three data frames into one
person_entity_API_1_result_table_final=data.frame(Text=person_entity_API_1_result_table1, Score=person_entity_API_1_result_table1, Positive=person_entity_API_1_result_table2, Negative=person_entity_API_1_result_table3)

#person_entity_API_1_result_table_final
person_entity_API_1_result_table_final=data.frame(Text=person_entity_API_1_result_table1$Text.person.1, Score=person_entity_API_1_result_table1$Score.value, Positive=person_entity_API_1_result_table2$Score.value, Negative=person_entity_API_1_result_table3$Score.value)

#View(person_entity_API_1_result_table_final)


###########################################
###### SENTIMENTAL ANALYSIS FOR LOCATION ######
###########################################

#Creating a copy of result data frame
location_entity_API_1_result_Column_1=location_entity_API_1_result[[1]]
location_entity_API_1_result_Column_2=location_entity_API_1_result[[2]]
location_entity_API_1_result_Column_3=location_entity_API_1_result[[3]]


#Creating three different data frames for Score, Positive and Negative
#Storing the first row(Containing the sentiment scores) in variable q
location_entity_API_1_result_Score=location_entity_API_1_result_Column_1[1,]
location_entity_API_1_result_Positive=location_entity_API_1_result_Column_2[1,]
location_entity_API_1_result_Negative=location_entity_API_1_result_Column_3[1,]
location_entity_API_1_result_Score_1=melt(location_entity_API_1_result_Score, ,var='Score')
location_entity_API_1_result_Positive_2=melt(location_entity_API_1_result_Positive, ,var='Positive')
location_entity_API_1_result_Negative_3=melt(location_entity_API_1_result_Negative, ,var='Negative') 
location_entity_API_1_result_Score_1['Score'] = NULL
location_entity_API_1_result_Positive_2['Positive'] = NULL
location_entity_API_1_result_Negative_3['Negative'] = NULL

#Creating data frame
location_entity_API_1_result_table1 = data.frame(Text=location_entity_API_1_result[1], Score=location_entity_API_1_result_Score_1)
location_entity_API_1_result_table2 = data.frame(Text=location_entity_API_1_result[2], Score=location_entity_API_1_result_Positive_2)
location_entity_API_1_result_table3 = data.frame(Text=location_entity_API_1_result[3], Score=location_entity_API_1_result_Negative_3)

#Merging three data frames into one
location_entity_API_1_result_table_final=data.frame(Text=location_entity_API_1_result_table1, Score=location_entity_API_1_result_table1, Positive=location_entity_API_1_result_table2, Negative=location_entity_API_1_result_table3)

#location_entity_API_1_result_table_final
location_entity_API_1_result_table_final=data.frame(Text=location_entity_API_1_result_table1$Text.location.1, Score=location_entity_API_1_result_table1$Score.value, Positive=location_entity_API_1_result_table2$Score.value, Negative=location_entity_API_1_result_table3$Score.value)

#View(location_entity_API_1_result_table_final)


#################################################
###### SENTIMENTAL ANALYSIS FOR ORGANIZATION ######
#################################################

#Creating a copy of result data frame
organization_entity_API_1_result_Column_1=organization_entity_API_1_result[[1]]
organization_entity_API_1_result_Column_2=organization_entity_API_1_result[[2]]
organization_entity_API_1_result_Column_3=organization_entity_API_1_result[[3]]


#Creating three different data frames for Score, Positive and Negative
#Storing the first row(Containing the sentiment scores) in variable q
organization_entity_API_1_result_Score=organization_entity_API_1_result_Column_1[1,]
organization_entity_API_1_result_Positive=organization_entity_API_1_result_Column_2[1,]
organization_entity_API_1_result_Negative=organization_entity_API_1_result_Column_3[1,]
organization_entity_API_1_result_Score_1=melt(organization_entity_API_1_result_Score, ,var='Score')
organization_entity_API_1_result_Positive_2=melt(organization_entity_API_1_result_Positive, ,var='Positive')
organization_entity_API_1_result_Negative_3=melt(organization_entity_API_1_result_Negative, ,var='Negative') 
organization_entity_API_1_result_Score_1['Score'] = NULL
organization_entity_API_1_result_Positive_2['Positive'] = NULL
organization_entity_API_1_result_Negative_3['Negative'] = NULL

#Creating data frame
organization_entity_API_1_result_table1 = data.frame(Text=organization_entity_API_1_result[1], Score=organization_entity_API_1_result_Score_1)
organization_entity_API_1_result_table2 = data.frame(Text=organization_entity_API_1_result[2], Score=organization_entity_API_1_result_Positive_2)
organization_entity_API_1_result_table3 = data.frame(Text=organization_entity_API_1_result[3], Score=organization_entity_API_1_result_Negative_3)

#Merging three data frames into one
organization_entity_API_1_result_table_final=data.frame(Text=organization_entity_API_1_result_table1, Score=organization_entity_API_1_result_table1, Positive=organization_entity_API_1_result_table2, Negative=organization_entity_API_1_result_table3)

#organization_entity_API_1_result_table_final
organization_entity_API_1_result_table_final=data.frame(Text=organization_entity_API_1_result_table1$Text.organization.1, Score=organization_entity_API_1_result_table1$Score.value, Positive=organization_entity_API_1_result_table2$Score.value, Negative=organization_entity_API_1_result_table3$Score.value)

#View(organization_entity_API_1_result_table_final)



###########################################
###### SENTIMENTAL ANALYSIS FOR MONEY ######
###########################################

#Creating a copy of result data frame
money_entity_API_1_result_Column_1=money_entity_API_1_result[[1]]
money_entity_API_1_result_Column_2=money_entity_API_1_result[[2]]
money_entity_API_1_result_Column_3=money_entity_API_1_result[[3]]


#Creating three different data frames for Score, Positive and Negative
#Storing the first row(Containing the sentiment scores) in variable q
money_entity_API_1_result_Score=money_entity_API_1_result_Column_1[1,]
money_entity_API_1_result_Positive=money_entity_API_1_result_Column_2[1,]
money_entity_API_1_result_Negative=money_entity_API_1_result_Column_3[1,]
money_entity_API_1_result_Score_1=melt(money_entity_API_1_result_Score, ,var='Score')
money_entity_API_1_result_Positive_2=melt(money_entity_API_1_result_Positive, ,var='Positive')
money_entity_API_1_result_Negative_3=melt(money_entity_API_1_result_Negative, ,var='Negative') 
money_entity_API_1_result_Score_1['Score'] = NULL
money_entity_API_1_result_Positive_2['Positive'] = NULL
money_entity_API_1_result_Negative_3['Negative'] = NULL

#Creating data frame
money_entity_API_1_result_table1 = data.frame(Text=money_entity_API_1_result[1], Score=money_entity_API_1_result_Score_1)
money_entity_API_1_result_table2 = data.frame(Text=money_entity_API_1_result[2], Score=money_entity_API_1_result_Positive_2)
money_entity_API_1_result_table3 = data.frame(Text=money_entity_API_1_result[3], Score=money_entity_API_1_result_Negative_3)

#Merging three data frames into one
money_entity_API_1_result_table_final=data.frame(Text=money_entity_API_1_result_table1, Score=money_entity_API_1_result_table1, Positive=money_entity_API_1_result_table2, Negative=money_entity_API_1_result_table3)

#money_entity_API_1_result_table_final
money_entity_API_1_result_table_final=data.frame(Text=money_entity_API_1_result_table1$Text.money.1, Score=money_entity_API_1_result_table1$Score.value, Positive=money_entity_API_1_result_table2$Score.value, Negative=money_entity_API_1_result_table3$Score.value)

#View(money_entity_API_1_result_table_final)



###########################################
###### SENTIMENTAL ANALYSIS FOR DATE ######
###########################################

#Creating a copy of result data frame
date_entity_API_1_result_Column_1=date_entity_API_1_result[[1]]
date_entity_API_1_result_Column_2=date_entity_API_1_result[[2]]
date_entity_API_1_result_Column_3=date_entity_API_1_result[[3]]


#Creating three different data frames for Score, Positive and Negative
#Storing the first row(Containing the sentiment scores) in variable q
date_entity_API_1_result_Score=date_entity_API_1_result_Column_1[1,]
date_entity_API_1_result_Positive=date_entity_API_1_result_Column_2[1,]
date_entity_API_1_result_Negative=date_entity_API_1_result_Column_3[1,]
date_entity_API_1_result_Score_1=melt(date_entity_API_1_result_Score, ,var='Score')
date_entity_API_1_result_Positive_2=melt(date_entity_API_1_result_Positive, ,var='Positive')
date_entity_API_1_result_Negative_3=melt(date_entity_API_1_result_Negative, ,var='Negative') 
date_entity_API_1_result_Score_1['Score'] = NULL
date_entity_API_1_result_Positive_2['Positive'] = NULL
date_entity_API_1_result_Negative_3['Negative'] = NULL

#Creating data frame
date_entity_API_1_result_table1 = data.frame(Text=date_entity_API_1_result[1], Score=date_entity_API_1_result_Score_1)
date_entity_API_1_result_table2 = data.frame(Text=date_entity_API_1_result[2], Score=date_entity_API_1_result_Positive_2)
date_entity_API_1_result_table3 = data.frame(Text=date_entity_API_1_result[3], Score=date_entity_API_1_result_Negative_3)

#Merging three data frames into one
date_entity_API_1_result_table_final=data.frame(Text=date_entity_API_1_result_table1, Score=date_entity_API_1_result_table1, Positive=date_entity_API_1_result_table2, Negative=date_entity_API_1_result_table3)

#date_entity_API_1_result_table_final
date_entity_API_1_result_table_final=data.frame(Text=date_entity_API_1_result_table1$Text.date.1, Score=date_entity_API_1_result_table1$Score.value, Positive=date_entity_API_1_result_table2$Score.value, Negative=date_entity_API_1_result_table3$Score.value)

#View(date_entity_API_1_result_table_final)



##########################################################################################################
########################### SENTIMENTAL ANALYSIS FOR NAMED ENTITY FROM API - 2 ###########################
##########################################################################################################



#Assigning the sentiment obtained for each named entity from API-2
person_entity_API_2_result = score.sentiment(person_entity_API_2, pos.words, neg.words)
location_entity_API_2_result = score.sentiment(location_entity_API_2, pos.words, neg.words)
organization_entity_API_2_result = score.sentiment(organization_entity_API_2, pos.words, neg.words)
date_entity_API_2_result = score.sentiment(date_entity_API_2, pos.words, neg.words)
money_entity_API_2_result = score.sentiment(money_entity_API_2, pos.words, neg.words)


#View(person_entity_API_2_result)
#View(location_entity_API_2_result)
#View(organization_entity_API_2_result)
#View(date_entity_API_2_result)
#View(money_entity_API_2_result)


#list of named entities available from API 1
#View(person_entity_API_2)
#View(location_entity_API_2)
#View(organization_entity_API_2)
#View(date_entity_API_2)
#View(money_entity_API_2)

###########################################
###### SENTIMENTAL ANALYSIS FOR PERSON ######
###########################################


#Creating a copy of result data frame
person_entity_API_2_result_Column_1=person_entity_API_2_result[[1]]
person_entity_API_2_result_Column_2=person_entity_API_2_result[[2]]
person_entity_API_2_result_Column_3=person_entity_API_2_result[[3]]


#Creating three different data frames for Score, Positive and Negative
#Storing the first row(Containing the sentiment scores) in variable q
person_entity_API_2_result_Score=person_entity_API_2_result_Column_1[1,]
person_entity_API_2_result_Positive=person_entity_API_2_result_Column_2[1,]
person_entity_API_2_result_Negative=person_entity_API_2_result_Column_3[1,]
person_entity_API_2_result_Score_1=melt(person_entity_API_2_result_Score, ,var='Score')
person_entity_API_2_result_Positive_2=melt(person_entity_API_2_result_Positive, ,var='Positive')
person_entity_API_2_result_Negative_3=melt(person_entity_API_2_result_Negative, ,var='Negative') 
person_entity_API_2_result_Score_1['Score'] = NULL
person_entity_API_2_result_Positive_2['Positive'] = NULL
person_entity_API_2_result_Negative_3['Negative'] = NULL


#Creating data frame
person_entity_API_2_result_table1 = data.frame(Text=person_entity_API_2_result[1], Score=person_entity_API_2_result_Score_1)
person_entity_API_2_result_table2 = data.frame(Text=person_entity_API_2_result[2], Score=person_entity_API_2_result_Positive_2)
person_entity_API_2_result_table3 = data.frame(Text=person_entity_API_2_result[3], Score=person_entity_API_2_result_Negative_3)

#Merging three data frames into one
person_entity_API_2_result_table_final=data.frame(Text=person_entity_API_2_result_table1, Score=person_entity_API_2_result_table1, Positive=person_entity_API_2_result_table2, Negative=person_entity_API_2_result_table3)

#person_entity_API_2_result_table_final
person_entity_API_2_result_table_final=data.frame(Text=person_entity_API_2_result_table1$Text.person.1, Score=person_entity_API_2_result_table1$Score.value, Positive=person_entity_API_2_result_table2$Score.value, Negative=person_entity_API_2_result_table3$Score.value)

#View(person_entity_API_2_result_table_final)



###########################################
###### SENTIMENTAL ANALYSIS FOR LOCATION ######
###########################################

#Creating a copy of result data frame
location_entity_API_2_result_Column_1=location_entity_API_2_result[[1]]
location_entity_API_2_result_Column_2=location_entity_API_2_result[[2]]
location_entity_API_2_result_Column_3=location_entity_API_2_result[[3]]


#Creating three different data frames for Score, Positive and Negative
#Storing the first row(Containing the sentiment scores) in variable q
location_entity_API_2_result_Score=location_entity_API_2_result_Column_1[1,]
location_entity_API_2_result_Positive=location_entity_API_2_result_Column_2[1,]
location_entity_API_2_result_Negative=location_entity_API_2_result_Column_3[1,]
location_entity_API_2_result_Score_1=melt(location_entity_API_2_result_Score, ,var='Score')
location_entity_API_2_result_Positive_2=melt(location_entity_API_2_result_Positive, ,var='Positive')
location_entity_API_2_result_Negative_3=melt(location_entity_API_2_result_Negative, ,var='Negative') 
location_entity_API_2_result_Score_1['Score'] = NULL
location_entity_API_2_result_Positive_2['Positive'] = NULL
location_entity_API_2_result_Negative_3['Negative'] = NULL

#Creating data frame
location_entity_API_2_result_table1 = data.frame(Text=location_entity_API_2_result[1], Score=location_entity_API_2_result_Score_1)
location_entity_API_2_result_table2 = data.frame(Text=location_entity_API_2_result[2], Score=location_entity_API_2_result_Positive_2)
location_entity_API_2_result_table3 = data.frame(Text=location_entity_API_2_result[3], Score=location_entity_API_2_result_Negative_3)

#Merging three data frames into one
location_entity_API_2_result_table_final=data.frame(Text=location_entity_API_2_result_table1, Score=location_entity_API_2_result_table1, Positive=location_entity_API_2_result_table2, Negative=location_entity_API_2_result_table3)

#location_entity_API_2_result_table_final
location_entity_API_2_result_table_final=data.frame(Text=location_entity_API_2_result_table1$Text.location.1, Score=location_entity_API_2_result_table1$Score.value, Positive=location_entity_API_2_result_table2$Score.value, Negative=location_entity_API_2_result_table3$Score.value)

#View(location_entity_API_2_result_table_final)



#################################################
###### SENTIMENTAL ANALYSIS FOR ORGANIZATION ######
#################################################

#Creating a copy of result data frame
organization_entity_API_2_result_Column_1=organization_entity_API_2_result[[1]]
organization_entity_API_2_result_Column_2=organization_entity_API_2_result[[2]]
organization_entity_API_2_result_Column_3=organization_entity_API_2_result[[3]]


#Creating three different data frames for Score, Positive and Negative
#Storing the first row(Containing the sentiment scores) in variable q
organization_entity_API_2_result_Score=organization_entity_API_2_result_Column_1[1,]
organization_entity_API_2_result_Positive=organization_entity_API_2_result_Column_2[1,]
organization_entity_API_2_result_Negative=organization_entity_API_2_result_Column_3[1,]
organization_entity_API_2_result_Score_1=melt(organization_entity_API_2_result_Score, ,var='Score')
organization_entity_API_2_result_Positive_2=melt(organization_entity_API_2_result_Positive, ,var='Positive')
organization_entity_API_2_result_Negative_3=melt(organization_entity_API_2_result_Negative, ,var='Negative') 
organization_entity_API_2_result_Score_1['Score'] = NULL
organization_entity_API_2_result_Positive_2['Positive'] = NULL
organization_entity_API_2_result_Negative_3['Negative'] = NULL

#Creating data frame
organization_entity_API_2_result_table1 = data.frame(Text=organization_entity_API_2_result[1], Score=organization_entity_API_2_result_Score_1)
organization_entity_API_2_result_table2 = data.frame(Text=organization_entity_API_2_result[2], Score=organization_entity_API_2_result_Positive_2)
organization_entity_API_2_result_table3 = data.frame(Text=organization_entity_API_2_result[3], Score=organization_entity_API_2_result_Negative_3)

#Merging three data frames into one
organization_entity_API_2_result_table_final=data.frame(Text=organization_entity_API_2_result_table1, Score=organization_entity_API_2_result_table1, Positive=organization_entity_API_2_result_table2, Negative=organization_entity_API_2_result_table3)

#organization_entity_API_2_result_table_final
organization_entity_API_2_result_table_final=data.frame(Text=organization_entity_API_2_result_table1$Text.organization.1, Score=organization_entity_API_2_result_table1$Score.value, Positive=organization_entity_API_2_result_table2$Score.value, Negative=organization_entity_API_2_result_table3$Score.value)

#View(organization_entity_API_2_result_table_final)



###########################################
###### SENTIMENTAL ANALYSIS FOR MONEY ######
###########################################

#Creating a copy of result data frame
money_entity_API_2_result_Column_1=money_entity_API_2_result[[1]]
money_entity_API_2_result_Column_2=money_entity_API_2_result[[2]]
money_entity_API_2_result_Column_3=money_entity_API_2_result[[3]]


#Creating three different data frames for Score, Positive and Negative
#Storing the first row(Containing the sentiment scores) in variable q
money_entity_API_2_result_Score=money_entity_API_2_result_Column_1[1,]
money_entity_API_2_result_Positive=money_entity_API_2_result_Column_2[1,]
money_entity_API_2_result_Negative=money_entity_API_2_result_Column_3[1,]
money_entity_API_2_result_Score_1=melt(money_entity_API_2_result_Score, ,var='Score')
money_entity_API_2_result_Positive_2=melt(money_entity_API_2_result_Positive, ,var='Positive')
money_entity_API_2_result_Negative_3=melt(money_entity_API_2_result_Negative, ,var='Negative') 
money_entity_API_2_result_Score_1['Score'] = NULL
money_entity_API_2_result_Positive_2['Positive'] = NULL
money_entity_API_2_result_Negative_3['Negative'] = NULL

#Creating data frame
money_entity_API_2_result_table1 = data.frame(Text=money_entity_API_2_result[1], Score=money_entity_API_2_result_Score_1)
money_entity_API_2_result_table2 = data.frame(Text=money_entity_API_2_result[2], Score=money_entity_API_2_result_Positive_2)
money_entity_API_2_result_table3 = data.frame(Text=money_entity_API_2_result[3], Score=money_entity_API_2_result_Negative_3)

#Merging three data frames into one
money_entity_API_2_result_table_final=data.frame(Text=money_entity_API_2_result_table1, Score=money_entity_API_2_result_table1, Positive=money_entity_API_2_result_table2, Negative=money_entity_API_2_result_table3)

#money_entity_API_2_result_table_final
money_entity_API_2_result_table_final=data.frame(Text=money_entity_API_2_result_table1$Text.money.1, Score=money_entity_API_2_result_table1$Score.value, Positive=money_entity_API_2_result_table2$Score.value, Negative=money_entity_API_2_result_table3$Score.value)

#View(money_entity_API_2_result_table_final)




###########################################
###### SENTIMENTAL ANALYSIS FOR DATE ######
###########################################

#Creating a copy of result data frame
date_entity_API_2_result_Column_1=date_entity_API_2_result[[1]]
date_entity_API_2_result_Column_2=date_entity_API_2_result[[2]]
date_entity_API_2_result_Column_3=date_entity_API_2_result[[3]]


#Creating three different data frames for Score, Positive and Negative
#Storing the first row(Containing the sentiment scores) in variable q
date_entity_API_2_result_Score=date_entity_API_2_result_Column_1[1,]
date_entity_API_2_result_Positive=date_entity_API_2_result_Column_2[1,]
date_entity_API_2_result_Negative=date_entity_API_2_result_Column_3[1,]
date_entity_API_2_result_Score_1=melt(date_entity_API_2_result_Score, ,var='Score')
date_entity_API_2_result_Positive_2=melt(date_entity_API_2_result_Positive, ,var='Positive')
date_entity_API_2_result_Negative_3=melt(date_entity_API_2_result_Negative, ,var='Negative') 
date_entity_API_2_result_Score_1['Score'] = NULL
date_entity_API_2_result_Positive_2['Positive'] = NULL
date_entity_API_2_result_Negative_3['Negative'] = NULL

#Creating data frame
date_entity_API_2_result_table1 = data.frame(Text=date_entity_API_2_result[1], Score=date_entity_API_2_result_Score_1)
date_entity_API_2_result_table2 = data.frame(Text=date_entity_API_2_result[2], Score=date_entity_API_2_result_Positive_2)
date_entity_API_2_result_table3 = data.frame(Text=date_entity_API_2_result[3], Score=date_entity_API_2_result_Negative_3)

#Merging three data frames into one
date_entity_API_2_result_table_final=data.frame(Text=date_entity_API_2_result_table1, Score=date_entity_API_2_result_table1, Positive=date_entity_API_2_result_table2, Negative=date_entity_API_2_result_table3)

#date_entity_API_2_result_table_final
date_entity_API_2_result_table_final=data.frame(Text=date_entity_API_2_result_table1$Text.date.1, Score=date_entity_API_2_result_table1$Score.value, Positive=date_entity_API_2_result_table2$Score.value, Negative=date_entity_API_2_result_table3$Score.value)

#View(date_entity_API_2_result_table_final)





#####################################
#Pie Chart for Sentimental Analysis API-1
#####################################

#Pie Chart for Sentimental Analysis for person_entity_API_1
person_entity_API_1_result_table_final_slices <- c(sum(person_entity_API_1_result_table_final$Positive), sum(person_entity_API_1_result_table_final$Negative))
labels <- c("Positive", "Negative")
pie3D(person_entity_API_1_result_table_final_slices, labels = labels, col=rainbow(length(labels)),explode=0.00, main="Sentiment Analysis")

#Pie Chart for Sentimental Analysis for location_entity_API_1
location_entity_API_1_result_table_final_slices <- c(sum(location_entity_API_1_result_table_final$Positive), sum(location_entity_API_1_result_table_final$Negative))
labels <- c("Positive", "Negative")
pie3D(location_entity_API_1_result_table_final_slices, labels = labels, col=rainbow(length(labels)),explode=0.00, main="Sentiment Analysis")

#Pie Chart for Sentimental Analysis for organization_entity_API_1
organization_entity_API_1_result_table_final_slices <- c(sum(organization_entity_API_1_result_table_final$Positive), sum(organization_entity_API_1_result_table_final$Negative))
labels <- c("Positive", "Negative")
pie3D(organization_entity_API_1_result_table_final_slices, labels = labels, col=rainbow(length(labels)),explode=0.00, main="Sentiment Analysis")

#Pie Chart for Sentimental Analysis for money_entity_API_1
money_entity_API_1_result_table_final_slices <- c(sum(money_entity_API_1_result_table_final$Positive), sum(money_entity_API_1_result_table_final$Negative))
labels <- c("Positive", "Negative")
pie3D(money_entity_API_1_result_table_final_slices, labels = labels, col=rainbow(length(labels)),explode=0.00, main="Sentiment Analysis")

#Pie Chart for Sentimental Analysis for date_entity_API_1
date_entity_API_1_result_table_final_slices <- c(sum(date_entity_API_1_result_table_final$Positive), sum(date_entity_API_1_result_table_final$Negative))
labels <- c("Positive", "Negative")
pie3D(date_entity_API_1_result_table_final_slices, labels = labels, col=rainbow(length(labels)),explode=0.00, main="Sentiment Analysis")

#####################################
#Pie Chart for Sentimental Analysis API-2
#####################################

#Pie Chart for Sentimental Analysis
person_entity_API_2_result_table_final_slices <- c(sum(person_entity_API_2_result_table_final$Positive), sum(person_entity_API_2_result_table_final$Negative))
labels <- c("Positive", "Negative")
pie3D(person_entity_API_2_result_table_final_slices, labels = labels, col=rainbow(length(labels)),explode=0.00, main="Sentiment Analysis")

#Pie Chart for Sentimental Analysis
location_entity_API_2_result_table_final_slices <- c(sum(location_entity_API_2_result_table_final$Positive), sum(location_entity_API_2_result_table_final$Negative))
labels <- c("Positive", "Negative")
pie3D(location_entity_API_2_result_table_final_slices, labels = labels, col=rainbow(length(labels)),explode=0.00, main="Sentiment Analysis")

#Pie Chart for Sentimental Analysis
organization_entity_API_2_result_table_final_slices <- c(sum(organization_entity_API_2_result_table_final$Positive), sum(organization_entity_API_2_result_table_final$Negative))
labels <- c("Positive", "Negative")
pie3D(organization_entity_API_2_result_table_final_slices, labels = labels, col=rainbow(length(labels)),explode=0.00, main="Sentiment Analysis")

#Pie Chart for Sentimental Analysis
money_entity_API_2_result_table_final_slices <- c(sum(money_entity_API_2_result_table_final$Positive), sum(money_entity_API_2_result_table_final$Negative))
labels <- c("Positive", "Negative")
pie3D(money_entity_API_2_result_table_final_slices, labels = labels, col=rainbow(length(labels)),explode=0.00, main="Sentiment Analysis")

#Pie Chart for Sentimental Analysis
date_entity_API_2_result_table_final_slices <- c(sum(date_entity_API_2_result_table_final$Positive), sum(date_entity_API_2_result_table_final$Negative))
labels <- c("Positive", "Negative")
pie3D(date_entity_API_2_result_table_final_slices, labels = labels, col=rainbow(length(labels)),explode=0.00, main="Sentiment Analysis")


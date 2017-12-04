####################################################################################################
#This script needs to be run part by part for each named entity to avoid HTTP ERROR 429 - Too Many Requests #######
#################### This error is due to multiple requests to the NYTimes API #####################
####################################################################################################



############################################################################################################
#################################### Using NY Times API to collect data ###################################
#Reference Source website : https://cran.r-project.org/web/packages/rtimes/vignettes/rtimes_vignette.html
############################################################################################################


#Collecting data from New York Times API for the most frequent named entities discovered from Twitter API
#Data for named entity - person
person_entity_API_2 <- as_search(q = person_entity_final, all_results = TRUE,begin_date = Sys.Date()-1, end_date = Sys.Date(), key = "1d5bcdd3e4ef463695e9f1037781fec6",sleep = 1)
person_entity_API_2_data <- person_entity_API_2$data
person_entity_API_2_final <- person_entity_API_2_data[,2]
colnames(person_entity_API_2_final)<-c("person")
#View(person_entity_API_2_final)
  
#Data for named entity - location
location_entity_API_2 <- as_search(q = location_entity_final, all_results = TRUE, begin_date = Sys.Date()-1, end_date = Sys.Date(), key = "1d5bcdd3e4ef463695e9f1037781fec6",sleep = 1)
location_entity_API_2_data <- location_entity_API_2$data
location_entity_API_2_final <- location_entity_API_2_data[,2]
colnames(location_entity_API_2_final)<-c("location")
#View(location_entity_API_2_final)

#Data for named entity - organization
organization_entity_API_2 <- as_search(q = organization_entity_final, all_results = TRUE, begin_date = Sys.Date()-1, end_date = Sys.Date(), key = "1d5bcdd3e4ef463695e9f1037781fec6",sleep = 1)
organization_entity_API_2_data <- organization_entity_API_2$data
organization_entity_API_2_final <- organization_entity_API_2_data[,2]
colnames(organization_entity_API_2_final)<-c("organization")
#View(organization_entity_API_2_final)

#Data for named entity - money/currency
money_entity_API_2 <- as_search(q = money_entity_final, all_results = TRUE,begin_date = Sys.Date()-1, end_date = Sys.Date(), key = "1d5bcdd3e4ef463695e9f1037781fec6",sleep = 1)
money_entity_API_2_data <- money_entity_API_2$data
money_entity_API_2_final <- money_entity_API_2_data[,2]
colnames(money_entity_API_2_final)<-c("money")
#View(money_entity_API_2_final)

#Data for named entity - date/time
date_entity_API_2 <- as_search(q = date_entity_final, all_results = TRUE,begin_date = Sys.Date()-1, end_date = Sys.Date(), key = "1d5bcdd3e4ef463695e9f1037781fec6",sleep = 1)
date_entity_API_2_data <- date_entity_API_2$data
date_entity_API_2_final <- date_entity_API_2_data[,2]
colnames(date_entity_API_2_final)<-c("date")
#View(date_entity_API_2_final)

#Writing the files to local
#write.csv(person_entity_API_2_final, "C:/DESKTOP/Home/person_entity_API_2_final.csv")
#write.csv(location_entity_API_2_final, "C:/DESKTOP/Home/location_entity_API_2_final.csv")
#write.csv(organization_entity_API_2_final, "C:/DESKTOP/Home/organization_entity_API_2_final.csv")
#write.csv(money_entity_API_2_final, "C:/DESKTOP/Home/money_entity_API_2_final.csv")
#write.csv(date_entity_API_2_final, "C:/DESKTOP/Home/date_entity_API_2_final.csv")



#Renaming the above named entities available from API 2 and changing to single class data.frame
person_entity_API_2 <- as.data.frame(person_entity_API_2_final)
location_entity_API_2 <- as.data.frame(location_entity_API_2_final)
organization_entity_API_2 <- as.data.frame(organization_entity_API_2_final)
money_entity_API_2 <- as.data.frame(money_entity_API_2_final)
date_entity_API_2 <- as.data.frame(date_entity_API_2_final)

#Viewing the list of named entities available from API 2
#View(person_entity_API_2)
#View(location_entity_API_2)
#View(organization_entity_API_2)
#View(money_entity_API_2)
#View(date_entity_API_2)



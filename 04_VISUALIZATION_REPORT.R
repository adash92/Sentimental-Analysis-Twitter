############################################################################################
######## SENTIMENTAL ANALYSIS PLOTS FOR NAMED ENTITIES COLLECTED FROM API-1 & API-2 ########
############################################################################################


######## SENTIMENTAL ANALYSIS PLOTS FOR NAMED ENTITIES - PERSON COLLECTED FROM API-1 ########
person_API_1 <- person_entity_API_1_result_table_final_slices
names(person_API_1) <- c("Positive","Negative")
person_API_1_DF <- as.data.frame(person_API_1)
pdf(file = "C:/DESKTOP/Home/twitter-sentiment-analysis-tutorial-201107-master/twitter-sentiment-analysis-tutorial-201107-master/data/opinion-lexicon-English/Sentimental_Analysis_Visualization.pdf")
grid.text("Table of Sentiment Analysis",y=0.8)
grid.text("Named Entity - ",y=0.75)
grid.text(person_entity_final,y=0.70)
grid.table(person_API_1_DF)
date_entity_API_1_result_table_final_slices
pie3D(date_entity_API_1_result_table_final_slices, labels = labels, col=rainbow(length(labels)),explode=0.00, main=c("Pie Chart of Sentiment Analysis - ",person_entity_final))


######## SENTIMENTAL ANALYSIS PLOTS FOR NAMED ENTITIES - PERSON COLLECTED FROM API-2 ########
grid.newpage()
person_API_2 <- person_entity_API_2_result_table_final_slices
names(person_API_2) <- c("Positive","Negative")
person_API_2_DF <- as.data.frame(person_API_2)
#pdf(file = "C:/DESKTOP/Home/twitter-sentiment-analysis-tutorial-201107-master/twitter-sentiment-analysis-tutorial-201107-master/data/opinion-lexicon-English/Sentimental_Analysis_Visualization.pdf")
grid.text("Table of Sentiment Analysis",y=0.8)
grid.text("Named Entity - ",y=0.75)
grid.text(person_entity_final,y=0.70)
grid.table(person_API_2_DF)
date_entity_API_2_result_table_final_slices
pie3D(date_entity_API_2_result_table_final_slices, labels = labels, col=rainbow(length(labels)),explode=0.00, main=c("Pie Chart of Sentiment Analysis - ",person_entity_final))


######## SENTIMENTAL ANALYSIS PLOTS FOR NAMED ENTITIES - LOCATION COLLECTED FROM API-1 ########
grid.newpage()
location_API_1 <- location_entity_API_1_result_table_final_slices
names(location_API_1) <- c("Positive","Negative")
location_API_1_DF <- as.data.frame(location_API_1)
#pdf(file = "C:/DESKTOP/Home/twitter-sentiment-analysis-tutorial-201107-master/twitter-sentiment-analysis-tutorial-201107-master/data/opinion-lexicon-English/Sentimental_Analysis_Visualization.pdf")
grid.text("Table of Sentiment Analysis",y=0.8)
grid.text("Named Entity - ",y=0.75)
grid.text(location_entity_final,y=0.70)
grid.table(location_API_1_DF)
date_entity_API_1_result_table_final_slices
pie3D(date_entity_API_1_result_table_final_slices, labels = labels, col=rainbow(length(labels)),explode=0.00, main=c("Pie Chart of Sentiment Analysis - ",location_entity_final))


######## SENTIMENTAL ANALYSIS PLOTS FOR NAMED ENTITIES - LOCATION COLLECTED FROM API-2 ########
grid.newpage()
location_API_2 <- location_entity_API_2_result_table_final_slices
names(location_API_2) <- c("Positive","Negative")
location_API_2_DF <- as.data.frame(location_API_2)
#pdf(file = "C:/DESKTOP/Home/twitter-sentiment-analysis-tutorial-201107-master/twitter-sentiment-analysis-tutorial-201107-master/data/opinion-lexicon-English/Sentimental_Analysis_Visualization.pdf")
grid.text("Table of Sentiment Analysis",y=0.8)
grid.text("Named Entity - ",y=0.75)
grid.text(location_entity_final,y=0.70)
grid.table(location_API_2_DF)
date_entity_API_2_result_table_final_slices
pie3D(date_entity_API_2_result_table_final_slices, labels = labels, col=rainbow(length(labels)),explode=0.00, main=c("Pie Chart of Sentiment Analysis - ",location_entity_final))


######## SENTIMENTAL ANALYSIS PLOTS FOR NAMED ENTITIES - ORGANIZATION COLLECTED FROM API-1 ########
grid.newpage()
organization_API_1 <- organization_entity_API_1_result_table_final_slices
names(organization_API_1) <- c("Positive","Negative")
organization_API_1_DF <- as.data.frame(organization_API_1)
#pdf(file = "C:/DESKTOP/Home/twitter-sentiment-analysis-tutorial-201107-master/twitter-sentiment-analysis-tutorial-201107-master/data/opinion-lexicon-English/Sentimental_Analysis_Visualization.pdf")
grid.text("Table of Sentiment Analysis",y=0.8)
grid.text("Named Entity - ",y=0.75)
grid.text(organization_entity_final,y=0.70)
grid.table(organization_API_1_DF)
date_entity_API_1_result_table_final_slices
pie3D(date_entity_API_1_result_table_final_slices, labels = labels, col=rainbow(length(labels)),explode=0.00, main=c("Pie Chart of Sentiment Analysis - ",organization_entity_final))


######## SENTIMENTAL ANALYSIS PLOTS FOR NAMED ENTITIES - ORGANIZATION COLLECTED FROM API-2 ########
grid.newpage()
organization_API_2 <- organization_entity_API_2_result_table_final_slices
names(organization_API_2) <- c("Positive","Negative")
organization_API_2_DF <- as.data.frame(organization_API_2)
#pdf(file = "C:/DESKTOP/Home/twitter-sentiment-analysis-tutorial-201107-master/twitter-sentiment-analysis-tutorial-201107-master/data/opinion-lexicon-English/Sentimental_Analysis_Visualization.pdf")
grid.text("Table of Sentiment Analysis",y=0.8)
grid.text("Named Entity - ",y=0.75)
grid.text(organization_entity_final,y=0.70)
grid.table(organization_API_2_DF)
date_entity_API_2_result_table_final_slices
pie3D(date_entity_API_2_result_table_final_slices, labels = labels, col=rainbow(length(labels)),explode=0.00, main=c("Pie Chart of Sentiment Analysis - ",organization_entity_final))


######## SENTIMENTAL ANALYSIS PLOTS FOR NAMED ENTITIES - MONEY COLLECTED FROM API-1 ########
grid.newpage()
money_API_1 <- money_entity_API_1_result_table_final_slices
names(money_API_1) <- c("Positive","Negative")
money_API_1_DF <- as.data.frame(money_API_1)
#pdf(file = "C:/DESKTOP/Home/twitter-sentiment-analysis-tutorial-201107-master/twitter-sentiment-analysis-tutorial-201107-master/data/opinion-lexicon-English/Sentimental_Analysis_Visualization.pdf")
grid.text("Table of Sentiment Analysis",y=0.8)
grid.text("Named Entity - ",y=0.75)
grid.text(money_entity_final,y=0.70)
grid.table(money_API_1_DF)
date_entity_API_1_result_table_final_slices
pie3D(date_entity_API_1_result_table_final_slices, labels = labels, col=rainbow(length(labels)),explode=0.00, main=c("Pie Chart of Sentiment Analysis - ",money_entity_final))


######## SENTIMENTAL ANALYSIS PLOTS FOR NAMED ENTITIES - MONEY COLLECTED FROM API-2 ########
grid.newpage()
money_API_2 <- money_entity_API_2_result_table_final_slices
names(money_API_2) <- c("Positive","Negative")
money_API_2_DF <- as.data.frame(money_API_2)
#pdf(file = "C:/DESKTOP/Home/twitter-sentiment-analysis-tutorial-201107-master/twitter-sentiment-analysis-tutorial-201107-master/data/opinion-lexicon-English/Sentimental_Analysis_Visualization.pdf")
grid.text("Table of Sentiment Analysis",y=0.8)
grid.text("Named Entity - ",y=0.75)
grid.text(money_entity_final,y=0.70)
grid.table(money_API_2_DF)
date_entity_API_2_result_table_final_slices
pie3D(date_entity_API_2_result_table_final_slices, labels = labels, col=rainbow(length(labels)),explode=0.00, main=c("Pie Chart of Sentiment Analysis - ",money_entity_final))


######## SENTIMENTAL ANALYSIS PLOTS FOR NAMED ENTITIES - DATE COLLECTED FROM API-1 ########
grid.newpage()
date_API_1 <- date_entity_API_1_result_table_final_slices
names(date_API_1) <- c("Positive","Negative")
date_API_1_DF <- as.data.frame(date_API_1)
#pdf(file = "C:/DESKTOP/Home/twitter-sentiment-analysis-tutorial-201107-master/twitter-sentiment-analysis-tutorial-201107-master/data/opinion-lexicon-English/Sentimental_Analysis_Visualization.pdf")
grid.text("Table of Sentiment Analysis",y=0.8)
grid.text("Named Entity - ",y=0.70)
grid.text(date_entity_final,y=0.75)
grid.table(date_API_1_DF)
date_entity_API_1_result_table_final_slices
pie3D(date_entity_API_1_result_table_final_slices, labels = labels, col=rainbow(length(labels)),explode=0.00, main=c("Pie Chart of Sentiment Analysis - ",date_entity_final))


######## SENTIMENTAL ANALYSIS PLOTS FOR NAMED ENTITIES - DATE COLLECTED FROM API-2 ########
grid.newpage()
date_API_2 <- date_entity_API_2_result_table_final_slices
names(date_API_2) <- c("Positive","Negative")
date_API_2_DF <- as.data.frame(date_API_2)
#pdf(file = "C:/DESKTOP/Home/twitter-sentiment-analysis-tutorial-201107-master/twitter-sentiment-analysis-tutorial-201107-master/data/opinion-lexicon-English/Sentimental_Analysis_Visualization.pdf")
grid.text("Table of Sentiment Analysis",y=0.8)
grid.text("Named Entity - ",y=0.70)
grid.text(date_entity_final,y=0.75)
grid.table(date_API_2_DF)
date_entity_API_2_result_table_final_slices
pie3D(date_entity_API_2_result_table_final_slices, labels = labels, col=rainbow(length(labels)),explode=0.00, main=c("Pie Chart of Sentiment Analysis - ",date_entity_final))


dev.off()
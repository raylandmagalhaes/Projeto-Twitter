#Creating a variable that tells the sentiment of the description 

library(syuzhet)
library(tm)
library(tidyverse)

clean.text = function(x){
  x = gsub("RT.*?: ","",x)
  x = gsub("@\\w+", "", x)
  x = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", x)
  x = gsub("[ \t]{2,}", "", x)
  x = gsub(" $", " ", x)
  x = gsub("[[:digit:]]", " ", x)
  x = gsub("^\\s+|\\s+$", "", x)
  x = gsub("http\\w+", "", x)
  x = gsub("[[:punct:]]", " ", x)
  x = gsub("http.*","", x)
  x = gsub(" amp ", " ", x)
  x = gsub("https.*","", x)
  x = gsub("^ ", " ", x)
  x = tolower(x)
  x = gsub(" &amp ", " ", x)
  # x = gsub("[^0-9A-Za-z]","" , x ,ignore.case = TRUE)
  x = gsub("^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]","" , x ,ignore.case = TRUE)
  return(x)
}

#Cleaning text and performing the sentiment analysis

Sentiment <- clean.text(google_retweets) %>% removeWords(., stopwords("portuguese")) %>% 
  get_nrc_sentiment(.,language = "portuguese")

#Removing surprise and antecipation
Sentiment <- Sentiment %>% select(-surprise,-anticipation)

#Selecting the higest score sentiment (choosing randomly in case of a tie)
Sentiment=colnames(Sentiment)[max.col(Sentiment,ties.method="random")]

#Classificating sentiments into positive or negative
sentiment_bin=ifelse(Sentiment%in%c("anger","disgust","fear","sadness","negative"),"Negative","Positive")
summary(as.factor(sentiment_bin))


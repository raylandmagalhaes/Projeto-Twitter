library(tidyverse)

# install.packages("twitteR")
library(twitteR)

# Credenciais:

consumer_key <- 'idBfc3mYzrfBPxRM1z5AhXxAA'
consumer_secret <- 'K50925I1FObqf6LA8MwiUyCBWlOxtrXXpi0aUAFD0wNCFBPQ3j'
access_token <- '1245495541330579457-6EBT7O9j98LgAt3dXxzsTK5FFAA2Lg'
access_secret <- 'jUP2N1nHeC6nzD30F4forjx7WxoOI603b4CqHdUnA6wqL'
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

# Extracting tweets: 

tweets_g <- searchTwitter("#UsoMascaraEleNao", n=20000,lang = "pt-br")
tweets_a <- searchTwitter("#amazon", n=1000,lang = "en")
tweets_f <- searchTwitter("#facebook", n=1000,lang = "en")
tweets_tech <- searchTwitter("#technology", n=1000,lang = "en")

names(tweets_g[[1]])
names(tweets_g[[2]])
tweets_g

google_tweets <- twListToDF(tweets_g)


# selecionando retweets:

google_retweets <- google_tweets %>%
  filter(isRetweet==T) %>% 
  select(text) %>% 
  pull
  

#descobrindo quem postou:

quem_postou <- gsub("|.*@","",gsub(":.*","",google_retweets))

gsub("RT.*?: ","",google_retweets)

#quem retweetou:
quem_retweetou <- google_tweets %>%
  filter(isRetweet==T) %>% 
  select(screenName) %>% 
  pull
load("tweets_g")


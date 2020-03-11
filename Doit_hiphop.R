#install.packages("rJava")
#install.packages("memoise")
#install.packages("stringi")
#install.packages("KoNLP")
#install.packages("jdk")
#install.packages("stringr")
#install.packages("Sejong")
#install.packages("hash")
#install.packages("tau")
#install.packages("RSQLite")

library(KoNLP)
library(stringr)
library(dplyr)

useNIADic()

#?°?´?„° ë¶ˆëŸ¬?˜¤ê¸?
txt <- readLines("hiphop.txt")

head(txt)

#install.packages("stringr")
library(stringr)

#?Š¹?ˆ˜ë¬¸ì ? œê±?
txt <- str_replace_all(txt, "\\W", " ")

extractNoun("??€?•œë¯¼êµ­?˜ ?˜?† ?Š” ?•œë°˜ë„??€ ê·? ë¶€?†?„?„œë¡? ?•œ?‹¤")

# ê°€?‚¬?—?„œ ëª…ì‚¬ ì¶”ì¶œ
nouns <- extractNoun(txt)

# ì¶”ì¶œ?•œ ëª…ì‚¬ listë¥? ë¬¸ì?—´ ë²¡í„°ë¡? ë³€?™˜, ?‹¨?–´ë³? ë¹ˆë„?‘œ ?ƒ?„±
wordcount <- table(unlist(nouns))

# ?°?´?„° ?”„? ˆ?„?œ¼ë¡? ë³€?™˜
df_word <- as.data.frame(wordcount, stringsAsfactors = F)

# ë³€?ˆ˜ëª? ?ˆ˜? •
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

# ?‘ ê¸€? ?´?ƒ ?‹¨?–´ ì¶”ì¶œ
df_word <- filter(df_word, nchar(word) >= 2)

top_20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

top_20

# ?Œ¨?‚¤ì§€ ?„¤ì¹?
#install.packages("wordcloud")

# ?Œ¨?‚¤ì§€ ë¡œë“œ
library(wordcloud)
library(RColorBrewer)

# Dark2 ?ƒ‰?ƒ ëª©ë¡?—?„œ 8ê°? ?ƒ‰?ƒ ì¶”ì¶œ
pal <- brewer.pal(8, "Dark2")

set.seed(1234)

wordcloud(words = df_word$word,   #?‹¨?–´
          freq = df_word$freq,	  #ë¹ˆë„
          min.freq = 2, 		  #ìµœì†Œ ?‹¨?–´ ë¹ˆë„
          max.words = 200, 		  #?‘œ?˜„ ?‹¨?–´ ?ˆ˜
          random.order = FALSE,		  #ê³ ë¹ˆ?„ ?‹¨?–´ ì¤‘ì•™ ë°°ì¹˜
          rot.per = .1,			  #?šŒ? „ ?‹¨?–´ ë¹„ìœ¨
          scale = c(4, 0.3),		  #?‹¨?–´ ?¬ê¸? ë²”ìœ„
          colors = pal)			  #?ƒ‰?ƒ ëª©ë¡

pal <- brewer.pal(9, "Blues")[5:9]	#?ƒ‰?ƒ ëª©ë¡ ?ƒ?„±
set.seed(1234)						#?‚œ?ˆ˜ ê³ ì •

wordcloud(words = df_word$word,			#?‹¨?–´
          freq = df_word$freq,	#ë¹ˆë„
          min.freq = 2,			#ìµœì†Œ ?‹¨?–´ ë¹ˆë„
          max.words = 200,		#?‘œ?˜„ ?‹¨?–´ ?ˆ˜
          randow.order = FALSE,		#ê³ ë¹ˆ?„ ?‹¨?–´ ì¤‘ì•™ ë°°ì¹˜
          rot.per = .1,			#?šŒ? „ ?‹¨?–´ ë¹„ìœ¨
          scale = c(4, 0.3),	#?‹¨?–´ ?¬ê¸? ë²”ìœ„
          colors = pal)			#?ƒ‰?ƒ ëª©ë¡

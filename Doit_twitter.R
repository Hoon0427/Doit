#데이터 로드
twitter <- read.csv("twitter.csv",
                    header = T,
                    stringsAsFactors = F,
                    fileEncoding = "UTF-8")
#install.packages("reshape")
library(reshape)
library(dplyr)

#변수명 수정
twitter <- rename(twitter,
                  no = 번호,
                  id = 계정이름,
                  date = 작성일,
                  tw = 내용)

summary(twitter)
str(twitter)

#install.packages("stringr")
library(stringr)


#특수문자 제거
twitter$tw <- str_replace_all(twitter$tw, "\\W", " ")
head(twitter$tw)

library(KoNLP)
#트윗에서 명사 추출
nouns <- extractNoun(twitter$tw)

#추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))

#데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)

#변수명 수정
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

#두 글자 이상 단어만 추출
df_word <- filter(df_word, nchar(word) >= 2)

#상위 20개 추출
top20 <- df_word %>% 
  arrange(desc(freq)) %>% 
  head(20)

top20

library(ggplot2)

order <- arrange(top20, freq)$word

ggplot(data = top20, aes(x = word, y = freq)) +
  ylim(0, 2500) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limit = order) +
  geom_text(aes(label = freq), hjust = -0.3)

#install.packages("RColorBrewer")
library(RColorBrewer)
pal <- brewer.pal(8, "Dark2")    #색상 목록 생성
set.seed(1234)      #난수 고정

#install.packages("wordcloud")
library(wordcloud)
wordcloud(word = df_word$word,
          freq = df_word$freq,
          min.freq = 10,
          max.words = 200,
          random.order = F,
          rot.per = .1,
          scale = c(6, 0.2),
          colors = pal)

pal <- brewer.pal(9, "Blues")[5:9]  #색상 목록 생성
set.seed(1234)

wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 10,
          max.words = 200,
          random.order = F,
          rot.per = .1,
          scale = c(6, 0.2),
          colors = pal)

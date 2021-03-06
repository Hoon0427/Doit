#install.packages("rJava")
#install.packages("memoise")
#install.packages("KoNLP")

library(KoNLP)
library(dplyr)

useNIADic()

#데이터 불러오기
txt <- readLines("hiphop.txt")

head(txt)

#install.packages("stringr")
library(stringr)

#특수문자 제거
txt <- str_replace_all(txt, "\\W", " ")

extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다")

# 가사에서 명사 추출
nouns <- extractNoun(txt)

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))

# 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsfactors = F)

# 변수명 수정
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)
class(df_word$word)
df_word$word <- as.character(df_word$word)
class(df_word$word)

# 두 글자 이상 단어 추출
df_word <- filter(df_word, nchar(word) >= 2)

top_20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

top_20

# 패키지 설치
#install.packages("wordcloud")

# 패키지 로드
library(wordcloud)
library(RColorBrewer)

# Dark2 색상 목록에서 8개 색상 추출
pal <- brewer.pal(8, "Dark2")

set.seed(1234)

wordcloud(words = df_word$word,   #단어
          freq = df_word$freq,	  #빈도
          min.freq = 2, 		  #최소 단어 빈도
          max.words = 200, 		  #표현 단어 수
          random.order = F,		  #고빈도 단어 중앙 배치
          rot.per = .1,			  #회전 단어 비율
          scale = c(4, 0.3),		  #단어 크기 범위
          colors = pal)			  #색상 목록

pal <- brewer.pal(9, "Blues")[5:9]	#색상 목록 생성
set.seed(1234)						#난수 고정

wordcloud(words = df_word$word,			#단어
          freq = df_word$freq,	#빈도
          min.freq = 2,			#최소 단어 빈도
          max.words = 200,		#표현 단어 수
          random.order = F,		#고빈도 단어 중앙 배치
          rot.per = .1,			#회전 단어 비율
          scale = c(4, 0.3),	#단어 크기 범위
          colors = pal)			#색상 목록

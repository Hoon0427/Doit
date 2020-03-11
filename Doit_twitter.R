#데이터 로드
twitter <- read.csv("twitter.csv",
                    header = T,
                    stringsAsFactors = F,
                    fileEncoding = "UTF-8")
#install.packages("reshape")
library(reshape)

#변수명 수정
twitter <- rename(twitter,
                  no = 번호,
                  id = 계정이름,
                  date = 작성일,
                  tw = 내용)

summary(twitter)
str(twitter)
?rename

#install.packages("stringr")
library(stringr)


#특수문자 제거
twitter$tw <- str_replace_all(twitter$tw, "\\W", " ")
head(twitter$tw)

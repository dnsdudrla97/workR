#
# 작성자: 이소정
# 작성일: 2019-12-11
# 제출일: 2019-12-11
#
setwd('D:/workR')

# 문1)
# 20대 국회 개원 여·야 3당 대표 국회연설문에 대해 
# 각각 워드클라우드를 작성하시오.
# 예제소스 파일은 ‘ex_10-1.txt’, ‘ex_10-2.txt’, ‘ex_10-3.txt’이다.

library(wordcloud)
library(wordcloud2)
library(KoNLP)
library(RColorBrewer)

library(dplyr)
library(ggplot2)


text1 <- readLines('ex_10-1.txt',encoding = 'UTF-8')
text1
text2 <- readLines('ex_10-2.txt',encoding = 'UTF-8')
text2
text3 <- readLines('ex_10-3.txt',encoding = 'UTF-8')
text3

buildDictionary(ext_dic = 'woorimalsam')
pal2 <- brewer.pal(8,'Dark2')

# text1

noun1 <- sapply(text1,extractNoun,USE.NAMES = F)
noun1

noun1_1 <- unlist(noun1)
wordcount <- table(noun1_1)
sort.noun <- sort(wordcount,decreasing = T)
sort.noun
sort.noun <- sort.noun[-1]

wordcloud(names(wordcount),
          freq = wordcount,
          scale = c(6, 0.7), 
          min.freq = 3, 
          random.order = F,
          rot.per = .1,
          colors = pal2)

noun1_1 <- noun1_1[nchar(noun1_1)>1]
noun1_1 <- gsub('비롯', '', noun1_1)
noun1_1 <- gsub('할거', '', noun1_1)
noun1_1 <- gsub('동안', '', noun1_1)
noun1_1 <- gsub('이상', '', noun1_1)
noun1_1 <- gsub('때문', '', noun1_1)
noun1_1 <- gsub('흔쾌', '', noun1_1)
noun1_1 <- gsub('해서', '', noun1_1)
noun1_1 <- gsub('해도', '', noun1_1)
noun1_1 <- gsub('해매', '', noun1_1)
noun1_1 <- gsub('해내', '', noun1_1)
noun1_1 <- gsub('하면', '', noun1_1)
noun1_1 <- gsub('하고', '', noun1_1)
noun1_1 <- gsub('하길', '', noun1_1)
noun1_1 <- gsub('하신', '', noun1_1)
noun1_1 <- gsub('할만', '', noun1_1)
noun1_1 <- gsub('들이', '', noun1_1)

wordcount <- table(noun1_1)

wordcloud(names(wordcount),
          freq = wordcount,
          scale = c(6, 0.7),
          min.freq = 3,
          random.order = F,
          rot.per = .1,
          colors = pal2)
# text2

noun2 <- sapply(text2,extractNoun,USE.NAMES = F)
noun2

noun2_1 <- unlist(noun2)
wordcount2 <- table(noun2_1)
sort.noun2 <- sort(wordcount2,decreasing = T)
sort.noun2
sort.noun2 <- sort.noun2[-1]

wordcloud(names(wordcount2),
          freq = wordcount2,
          scale = c(6, 0.7), 
          min.freq = 3, 
          random.order = F,
          rot.per = .1,
          colors = pal2)

noun2_1 <- noun2_1[nchar(noun2_1)>1]
noun2_1 <- gsub('들이', '', noun2_1)
noun2_1 <- gsub('70', '', noun2_1)
noun2_1 <- gsub('해서', '', noun2_1)
noun2_1 <- gsub('하기', '', noun2_1)
noun2_1 <- gsub('때문', '', noun2_1)
noun2_1 <- gsub('하지', '', noun2_1)
noun2_1 <- gsub('비롯', '', noun2_1)

wordcount2 <- table(noun2_1)

wordcloud(names(wordcount2),
          freq = wordcount2,
          scale = c(6, 0.7),
          min.freq = 3,
          random.order = F,
          rot.per = .1,
          colors = pal2)

# text3

noun3 <- sapply(text3,extractNoun,USE.NAMES = F)
noun3

noun3_1 <- unlist(noun3)
wordcount3 <- table(noun3_1)
sort.noun3 <- sort(wordcount3,decreasing = T)
sort.noun3
sort.noun3 <- sort.noun3[-1]

wordcloud(names(wordcount3),
          freq = wordcount3,
          scale = c(6, 0.7), 
          min.freq = 3, 
          random.order = F,
          rot.per = .1,
          colors = pal2)

noun3_1 <- noun3_1[nchar(noun3_1)>1]
noun3_1 <- gsub('20', '', noun3_1)
noun3_1 <- gsub('때문', '', noun3_1)
noun3_1 <- gsub('하지', '', noun3_1)
noun3_1 <- gsub('동안', '', noun3_1)
noun3_1 <- gsub('들이', '', noun3_1)
noun3_1 <- gsub('하면', '', noun3_1)
noun3_1 <- gsub('하자', '', noun3_1)
noun3_1 <- gsub('해서', '', noun3_1)

wordcount3 <- table(noun3_1)

wordcloud(names(wordcount3),
          freq = wordcount3,
          scale = c(6, 0.7),
          min.freq = 3,
          random.order = F,
          rot.per = .1,
          colors = pal2)

#
# 문2)
# 스티브 잡스의 스탠포드 대학 졸업식 연설문에 대해 
# 워드클라우드를 작성하시오.
# Tip. 예제소스 파일은 ‘ex_10-4.txt’이다.

text4 <- readLines('ex_10-4.txt',encoding = 'UTF-8')
text4

noun4 <- sapply(text4,extractNoun,USE.NAMES = F)
noun4

noun4_1 <- unlist(noun4)
wordcount4 <- table(noun4_1)
sort.noun4 <- sort(wordcount4,decreasing = T)
sort.noun4
sort.noun4 <- sort.noun4[-3]

wordcloud(names(wordcount4),
          freq = wordcount4,
          scale = c(6, 0.7), 
          min.freq = 3, 
          random.order = F,
          rot.per = .1,
          colors = pal2)

noun4_1 <- noun4_1[nchar(noun4_1)>1]
noun4_1 <- gsub('그것', '', noun4_1)
noun4_1 <- gsub('하지', '', noun4_1)
noun4_1 <- gsub('가지', '', noun4_1)
noun4_1 <- gsub('개월', '', noun4_1)
noun4_1 <- gsub('들이', '', noun4_1)
noun4_1 <- gsub('때문', '', noun4_1)
noun4_1 <- gsub('점들', '', noun4_1)
noun4_1 <- gsub('\\d+', '', noun4_1)
noun4_1 <- gsub('번째', '', noun4_1)
noun4_1 <- gsub('그날', '', noun4_1)
noun4_1 <- gsub('년대', '', noun4_1)
noun4_1 <- gsub('동안', '', noun4_1)
noun4_1 <- gsub('이것', '', noun4_1)

wordcount4 <- table(noun4_1)

wordcloud(names(wordcount4),
          freq = wordcount4,
          scale = c(6, 0.7),
          min.freq = 2,
          random.order = F,
          rot.per = .1,
          colors = pal2)

# 문3)
# 오바마 대통령의 데통령 당선 연설문에 대해 워드클라우드를 작성하시오
# Tip. 예제소스 파일은 ‘ex_10-5.txt’이다.

text5 <- readLines('ex_10-5.txt',encoding = 'UTF-8')
text5

noun5 <- sapply(text5,extractNoun,USE.NAMES = F)
noun5

noun5_1 <- unlist(noun5)
wordcount5 <- table(noun5_1)
sort.noun5 <- sort(wordcount5,decreasing = T)
sort.noun5
sort.noun5 <- sort.noun5[-1]

wordcloud(names(wordcount4),
          freq = wordcount4,
          scale = c(6, 0.7), 
          min.freq = 3, 
          random.order = F,
          rot.per = .1,
          colors = pal2)

noun5_1 <- noun5_1[nchar(noun5_1)>1]
noun5_1 <- gsub('들이', '', noun5_1)
noun5_1 <- gsub('때문', '', noun5_1)
noun5_1 <- gsub('동안', '', noun5_1)
noun5_1 <- gsub('이것', '', noun5_1)
noun5_1 <- gsub('말하', '', noun5_1)
noun5_1 <- gsub('//d+', '', noun5_1)
noun5_1 <- gsub('미국은', '미국', noun5_1)

wordcount5 <- table(noun5_1)

wordcloud(names(wordcount5),
          freq = wordcount5,
          scale = c(6, 0.7),
          min.freq = 2,
          random.order = F,
          rot.per = .1,
          colors = pal2)

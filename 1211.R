#
# 2019-12-11
#
# 워드클라우드(Word Cloud)
#
# 한글 워드클라우드 절차
# 1. Java 실행환경 구축
# 2. 자료 수집(Text 자료)
#    2.1 text file형태로 수집
#    2.2 web scraping을 이용하여 수집
# 3. 명사 추출
Sys.setenv( JAVA_HOME = 'C:/Program Files/Java/jre1.8.0_231')

# 필요시 설치#########################################################
install.packages("wordcloud")          # word cloud
install.packages("wordcloud2")         # word cloud2
install.packages("KoNLP")              # 한국어 처리 -> 사전정보가 포함
install.packages("RColorBrewer")       # 색상 선택
######################################################################

library(wordcloud)
library(wordcloud2)
library(KoNLP)
library(RColorBrewer)

library(dplyr)
library(ggplot2)

setwd('D:/workR3')
text <- readLines('mis_document.txt',encoding = 'UTF-8')
text
# text파일 만들때 주의점
# 마지막에 공백줄(1줄 이상) 만들기
# 없으면 오류가 생길 가능성이 커진다.

# '우리말씀 한글사전 로딩
buildDictionary(ext_dic = 'woorimalsam')
pal2 <- brewer.pal(8,'Dark2')                  # 색상 팔레트 생성
noun <- sapply(text,extractNoun,USE.NAMES = F) # 명사 추출
noun
# text파일을 비교하며 빠진 단어가 있는지 확인해 봐야한다.

# 4. 추출된 단어(주로 명사)에 대한 빈도수 계산 및 시각화
noun2 <- unlist(noun) # list -> vector로 변환
wordcount <- table(noun2)
sort.noun <- sort(wordcount,decreasing = T)[1:10] # test하기 위해 일부만을 사용. 원래는 다 사용해야함.
sort.noun
sort.noun <- sort.noun[-1]
barplot(sort.noun, names.arg = names(sort.noun),
        col='steelblue',main='빈도수 높은 단어',
        ylab='단어 빈도수')

df <- as.data.frame(sort.noun)
df
ggplot(df, aes(x=df$noun2, y=df$Freq)) +
  geom_bar(stat = 'identity',
           width = 0.7,
           fill = 'steelblue') +
  ggtitle('빈도수 높은 단어') +
  theme(plot.title = element_text(size = 25, face = 'bold', colour = 'steelblue',
                                  hjust = 0, vjust = 1)) +
  labs(x = '명사', y = '단어빈도수') +
  geom_text(aes(label = df$Freq), hjust = -0.3) + # 빈도표시
  coord_flip()

# 5. word cloud 작성
wordcloud(names(wordcount),        # 단어
          freq = wordcount,        # 단어 빈도
          scale = c(6, 0.7),       # 단어폰트크기(최대,최소)
          min.freq = 3,            # 단어최소빈도
          random.order = F,        # 단어출력위치 / F: 빈도수 높은것을 가운데로 집합, T: 랜덤으로 배치
          rot.per = .1,            # 90도회전단어비율 .1 -> 10%를 의미하는 것
          colors = pal2)           # 단어 색

pal3 <- brewer.pal(9,'Blues')[5:9] # 단색으로 정리
wordcloud(names(wordcount),
          freq = wordcount,
          scale = c(6, 0.7),
          min.freq = 3,
          random.order = F, 
          rot.per = .1, 
          colors = pal3)

# 6. 전처리 과정 수행
#    6.2 생략된 단어를 사전에 등재
buildDictionary(ext_dic = 'woorimalsam',
                user_dic = data.frame('정치','ncn'),     # 'ncn': 명사를 뜻한다./ 정치를 명사로 사전에 등재하겠다.
                replace_usr_dic = T)
noun <- sapply(text,extractNoun,USE.NAMES = F)
noun2 <- unlist(noun)

#    6.1 불필요한 단어 삭제
noun2 <- noun2[nchar(noun2)>1]      # 한글자 단어 삭제
noun2 <- gsub('하지', '', noun2)
noun2 <- gsub('때문', '', noun2)
wordcount <- table(noun2)

# 7. word cloud 작성
pal3 <- brewer.pal(9,'Blues')[5:9]    
wordcloud(names(wordcount),
          freq = wordcount,
          scale = c(6, 0.7),
          min.freq = 3,
          random.order = F,
          rot.per = .1,
          colors = pal3)

#
# 애국가 형태소 분석
#
library(KoNLP)
# KoNLP내에 내장된 사전
useSystemDic()
useSejongDic()
useNIADic()
#
# 애국가 가사:
# https://mois.go.kr/frt/sub/a06/b08/nationalIcon_3/screen.do
#
# 1. 사전 설정
useSejongDic() 

# 2. 텍스트 데이터 가져오기
word_data <- readLines('애국가(가사).txt')
word_data

# 3.명사 추출
word_data2 <- sapply(word_data, extractNoun, USE.NAMES = F)
word_data2
# list형태로 추출

# 3.1 제대로 추출되지 않은 단어를 사용자 사전에 등록
add_words <- c('백두산','남산','철갑','가을','하늘','달','삼천리','구름') # 달, 삼천리, 구름 안됨 ㅠ
                                                                          # 사전에서 변환이 안되는 부분은 직접 리스트로 찾아가서 바꾸기
word_data2

buildDictionary(user_dic = data.frame(add_words, rep('ncn',length(add_words))),
                replace_usr_dic = T)
get_dictionary('user_dic')

# 3.2 단어 추가 후 다시 명사 추출
word_data2 <- sapply(word_data, extractNoun, USE.NAMES = F)
word_data2
# 리스트 내용을 수정하는 법
# https://m.blog.naver.com/PostView.nhn?blogId=dic1224&logNo=80206432328&proxyReferer=https%3A%2F%2Fwww.google.co.kr%2F
word_data2[[2]][1] <- "동해물"
word_data2[[4]][3] <- "삼천리"

word_data2
# 4. 행렬을 벡터로 변환
undata <- unlist(word_data2)
undata

# 5. 사용 빈도 확인
word_table <- table(undata)
word_table

# 6. 필터링: 두 글자 이상 단어만 선별, 공백이나 한 자리 문자를 걸러냄
#
undata2 <- undata[nchar(undata)>=2]
undata2
word_table2 <- table(undata2)
word_table2

# 7. 데이터 정렬
sort(word_table2, decreasing = T)

# 애국가 형태 분석 완료
# 가장 기본적인 전처리만 수행, 100% 정확한 데이터라 볼 수 없음

# 8. word cloud 작성 후 분석
wordcloud2(word_table2)

# 8.1 배경 및 색상 변경
wordcloud2(word_table2,
           color='random-light',
           backgroundColor = 'black')

# 8.2 모양 변경
wordcloud2(word_table2,
           fontFamily = '맑은고딕',
           size = 1.2, color = 'random-light',
           backgroundColor = 'black',
           shape = 'star') # 별, 다이아, 트라이앵글 등의 모양도 사용 가능

# 8.3 선택 색상 반복
wordcloud2(word_table2, size = 1.6,
           color = rep_len(c('red','blue'),nrow(word_table2)))
wordcloud2(demoFreq, size = 1.6,
           color = rep_len(c('red','blue'),nrow(word_table2)))

# 8.4 일정 방향 정렬
wordcloud2(word_table2,
           minRotation = -pi/6,
           maxRotation = -pi/6,
           rotateRatio = 1)
wordcloud2(demoFreq,
           minRotation = -pi/6,
           maxRotation = -pi/6,
           rotateRatio = 1)

# web scraping
# https://search.naver.com/search.naver?sm=top_hty&fbm=1&ie=utf8&query=%EC%A0%9C%EC%A3%BC
#                                      |                         <- 한글이여서         ->     
# WebScraping.R보기
# ExamDataAnalysis.zip도 확인하기
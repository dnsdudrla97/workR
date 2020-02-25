setwd("D:/projectR")

#제주특별자치도_서귀포시_전통시장
store_s <- read.csv(file = "제주특별자치도_서귀포시_전통시장_20190630.csv",sep=',')
store_s

#제주특별자치도_제주시_전통시장
store_j <- read.csv(file = "제주특별자치도_제주시_전통시장_20190402.csv",sep=',')
store_j

#제주특별자치도_시장별소비패턴현황
sobi <- read.csv(file="제주특별자치도_시장별소비패턴현황_2014~2016.csv",sep=',')
sobi
dim(sobi)      # 188개의 데이터가 읽힘(실제 데이터 24개 나머진 NA값) 
st_sobi <- sobi[complete.cases(sobi),]
st_sobi        # NA값 삭제하여 저장
dim(st_sobi)

# 제주도내 제주시, 서귀포시 시장 개수 비교
head(store_s);head(store_j)
# 시장명, 시장유형, 소재지도로명주소, 시장개설주기만 사용
library(dplyr)
# 제주시와 서귀포시의 전통시장 수를 알고싶어서
# 주소 데이터를 서귀포지역은 서귀포시로
# 제주 지역은 제주시로 변환하여
# bind_rows -> 데이터 추가 행렬을 사용함
store_s <- store_s[,c(1:3,5)]
store_s[,3] <- '서귀포시'
store_s
store_j <- store_j[,c(1:3,5)]
store_j[,3] <- '제주시'
store_j
st <- bind_rows(store_s,store_j)
st

loc <- c(st[,3])
loc
class(loc)
tb <- table(loc)
barplot(tb,main= '제주특별자치도 전통시장',xlab = '시 이름', ylab = '시장 개수',col='skyblue',las=1)

money <- st_sobi[,c(1,3,4,5,6)]     # 사용할 데이터만 추출하여 저장
money
mt.money <- split(money,st_sobi$시장명)  # 시장별로 데이터분리
mt.money

# 시장별 기준년월 대비 카드이용금액 설정

par(mfrow=c(2,4))
nb1 <- mt.money$`제주 동문시장` 
nb1
year1 <- c(nb1$기준년월)
um1 <- c(nb1$카드이용금액)
plot(year1,um1,type='b',main='제주 동문시장',lty=1,lwd=1)

nb2 <- mt.money$`제주 서문시장` 
nb2
year2 <- c(nb2$기준년월)
um2 <- c(nb2$카드이용금액)
plot(year2,um2,type='b',main='제주 서문시장',lty=1,lwd=1)

nb3 <- mt.money$`제주 보성시장` 
nb3
year3 <- c(nb3$기준년월)
um3 <- c(nb3$카드이용금액)
plot(year3,um3,type='b',main='제주 보성시장',lty=1,lwd=1)

nb4 <- mt.money$`서귀포 매일올레시장`
nb4
year4 <- c(nb4$기준년월)
um4 <- c(nb4$카드이용금액)
plot(year4,um4,type='b',main='서귀포 매일올레시장',lty=1,lwd=1)

nb5 <- mt.money$`모슬포 중앙시장`
nb5
year5 <- c(nb5$기준년월)
um5 <- c(nb5$카드이용금액)
plot(year5,um5,type='b',main='모슬포 중앙시장',lty=1,lwd=1)

nb6 <- mt.money$`서귀포 향토5일시장`
nb6
year6 <- c(nb6$기준년월)
um6 <- c(nb6$카드이용금액)
plot(year6,um6,type='b',main='서귀포 향토5일시장',lty=1,lwd=1)

nb7 <- mt.money$`제주 민속5일시장` 
nb7
year7 <- c(nb7$기준년월)
um7 <- c(nb7$카드이용금액)
plot(year7,um7,type='b',main='제주 민속5일시장',lty=1,lwd=1)

nb8 <- mt.money$`중문 향토5일시장`

nb8
year8 <- c(nb8$기준년월)
um8 <- c(nb8$카드이용금액)
plot(year8,um8,type='b',main='중문 향토5일시장',lty=1,lwd=1)
par(mfrow=c(1,1))

# 내국인 쇼핑장소
korean <- read.csv(file = "내국인_제주여행_쇼핑장소_20191205141831.csv",sep=',') 
colnames(korean)
sh_k2018 <- korean[2,49:ncol(korean)]
sh_k2018
head(korean,3)
names(sh_k2018) <- c('면세점','시내상점가(로드샵)','토산품판매점','대형마트(이마트 롯데마트 등)',
                     '전통시장','기타','쇼핑하지 않음')
sh_k18 <- as.matrix(sh_k2018)
class(sh_k18)
barplot(sh_k18, names.arg=names(sh_k18),col='skyblue')

# 외국인 쇼핑장소
foreigner <- read.csv(file = "외국인_제주여행_쇼핑장소_20191205142043.csv",sep=',') 
foreigner
colnames(foreigner)
sh_f2018 <- foreigner[2,49:ncol(foreigner)]
sh_f2018
head(foreigner,3)
names(sh_f2018) <- c('전통시장','시내상점가(로드샵)','토산품 판매점','면세점',
                     '대형할인마트(이마트롯데마트 등)','기타','쇼핑하지 않음')
sh_f18 <- as.matrix(sh_f2018)
barplot(sh_f18,col='skyblue')

# 전통시장 이용 - 내국인
head(korean,3)
year <- 2014:2018
us_korean <- c(6696*23.3,4731*24.6,5036*48.5,5406*48.4,6181*60.2)
plot(year,us_korean,main='내국인 - 전통시장',
     type='o',lty=1,lwd=1)
# 전통시장 이용 비율 - 외국인
head(foreigner)
us_foreiger <- c(6972*9.8,6431*8.3,3746*26.9,3640*35,3916*24.9)
plot(year,us_foreiger,main='외국인 - 전통시장',
     type='o',lty=1,lwd=1)

# 두 그래프 합치기
plot(year,us_korean,type='o',lty=1,lwd=1)
lines(year,us_foreiger,type = 'o',col='blue')

# 도입 방문 횟수
library(rJava)
library(xlsx)
visit_14 <- read.xlsx(file = "2014년 제주관광객 현황.xlsx",sheetIndex=12,
                          encoding="UTF-8") 
visit_15 <- read.xlsx(file = "2015년 제주관광객 현황.xlsx",sheetIndex=12,
                      encoding="UTF-8") 
visit_16 <- read.xlsx(file = "2016년 제주관광객 현황.xlsx",sheetIndex=12,
                      encoding="UTF-8") 

# 내국인 수
visit_14[6,7]
visit_15[6,7]
visit_16[6,7]
visit_k <- c(8945601,11040135,11300571)
# 전통시장 이용비율 - 내국인
us_korean <- c(6696*23.3,4731*24.6,5036*48.5)

# 설문 응답과 도입수 상관 분석 - 내국인
tb1 <- data.frame(us_korean,visit_k)
tb1
plot(us_korean~visit_k,data = tb1,main='설문 응답과 내국인 도입 수 관계')

res1 <- lm(us_korean~visit_k,data = tb1)
res1

abline(res1,col='blue')

cor(tb1[,1:2])          # 설문조사 응답자 수와 제주 방문 관광객 수의 상관관계는 없다.
                        # 데이터가 더 많아지면 달라질 수도 있지만,
                        # 현재 데이터를 가지고 상관관계가 있다고 판단하기 어렵다.

# 외국인 제주 방문 횟수
visit_14[14,7]
visit_15[14,7]
visit_16[14,7]
visit_f <- c(3328316,2624260,3376969)
# 전통시장 이용비율 - 외국인
us_foreiger <- c(6972*9.8,6431*8.3,3746*26.9)

# 설문 응답 비율과 상관 분석 - 외국인
tb2 <- data.frame(us_foreiger,visit_f)
tb2
plot(us_foreiger~visit_f,data = tb2,main='설문 응답과 외국인 도입 수 관계')

res2 <- lm(us_foreiger~visit_f,data = tb2)
res2

abline(res2,col='blue')

cor(tb2[,1:2])          # 대체적으로 상관관계가 존재한다.
                        # 하지만 완전한 상관관계를 갖는다고 판단하기는 어렵다.

# 매출액과 내국인 방문자 수

# 매출액 정리한 dataframe인 money사용
class(money)
head(money)
library(dplyr)
money %>% filter(기준년월==2014) %>% 
  summarise(sum_2014=sum(카드이용금액))
money %>% filter(기준년월==2015) %>% 
  summarise(sum_2015=sum(카드이용금액))
money %>% filter(기준년월==2016) %>% 
  summarise(sum_2016=sum(카드이용금액))
tot <- c(26184539270,36289134735,26184539270)

# 입도 내국인 visit_k  + 매출액
tb3 <- data.frame(visit_k,tot)
tb3
plot(visit_k~tot,data = tb3,main='매출액과 내국인 도입수의 상관관계')

res3 <- lm(visit_k~tot,data = tb3)
res3

abline(res3,col='blue')

cor(tb3[,1:2])

# 입도 외국인 visit_f + 매출액
tb4 <- data.frame(visit_f,tot)
tb4
plot(visit_f~tot,data = tb4,main='매출액과 외국인 도입수의 상관관계')

res4 <- lm(visit_f~tot,data = tb4)
res4

abline(res4,col='blue')

cor(tb4[,1:2])

# 내국인 정보 습득 경로
know_korean <- read.csv(file = "내국인_정보_습득경로_20191206033149.csv",sep=',') 
head(know_korean)
know_k <- know_korean[3,4:14]
know_k
names(know_k) <- c('인터넷사이트/앱','여행관련사이트/앱','자국여행사(오프라인)',
                   '관광안내책자','친지 친구 동료','현지 한국 공공기관 및 박람회','과거여행경험',
                   '주요 언론매체(TV 라디오 신문 잡지 등)','항공사 호텔','기타','정보를 얻지 않음')
kn_k1 <- as.matrix(know_k)
class(kn_k1)
barplot(kn_k1, main='내국인 1순위 습득경로')
know_k <- know_korean[3,16:ncol(know_korean)]
know_k
names(know_k) <- c('인터넷사이트/앱','여행관련사이트/앱','자국여행사(오프라인)',
                   '관광안내책자','친지 친구 동료','현지 한국 공공기관 및 박람회','과거여행경험',
                   '주요 언론매체(TV 라디오 신문 잡지 등)','항공사 호텔','기타')
kn_k2 <- as.matrix(know_k)
class(kn_k2)
barplot(kn_k2, main='내국인 2순위 습득경로')

# 외국인 정보 습득 
know_foreigen <- read.csv(file = "외국인_정보습득경로_20191206033234.csv",sep=',') 
head(know_foreigen)
know_f <- know_foreigen[3,4:14]
know_f
names(know_f) <- c('자국의 인터넷 사이트/앱','한국의 여행관련 사이트/앱','자국 여행사(오프라인)',
                   '관광안내책자','친지 친구 동료','현지 한국 공공기관 및 박람회','과거여행경험',
                   '주요 언론매체(TV 라디오 신문 잡지 등)','항공사 호텔','기타','정보를 얻지 않음')
kn_f1 <- as.matrix(know_f)
class(kn_f1)
barplot(kn_f1, main='외국인 1순위 습득경로')
know_f <- know_foreigen[3,16:ncol(know_foreigen)]
know_f
names(know_f) <- c('자국의 인터넷 사이트/앱','한국의 여행관련 사이트/앱','자국 여행사(오프라인)',
                   '관광안내책자','친지 친구 동료','현지 한국 공공기관 및 박람회','과거여행경험',
                   '주요 언론매체(TV 라디오 신문 잡지 등)','항공사 호텔','기타')
kn_f2 <- as.matrix(know_f)
class(kn_f2)
barplot(kn_f2, main='내국인 2순위 습득경로')

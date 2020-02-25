#
#2019-12-02
#

setwd("D:/workR")
df <- read.table(file="airquality.txt",header=T) 
# na.strings = "-" => "-"문자를 결측치로 처리 na로 읽어라
df
# 교재 p.96-97
class(df)
dim(df)
str(df)
head(df,3)
tail(df,3)

# 교재 p.98
install.packages("xlsx")
install.packages("rJava")

# 패키지를 사용하겠다. -> library
library(rJava)
library(xlsx)

df.xlsx <- read.xlsx(file="airquality.xlsx",sheetIndex = 1,
                     # sheetIndex는 sheet가 여러개 있는 xlsx에서 어느 sheet을 참조할 것인지 알기 위해서 사용
                     encoding = "UTF-8") # 원본데이터가 깨질때 encoding이용
df.xlsx
class(df.xlsx)
str(df.xlsx)
head(df.xlsx,3)
tail(df.xlsx,3)

score <- c(76,84,69,50,95,6,82,71,88,84)
# which ->데이터의 위치를 찾아주는 함수
which(score==69)
which(score>=85)
max(score)           # 최대값
which.max(score)     # 최대값이 있는 인덱스
min(score)
which.min(score)

idx <- which(score>=60)
score[idx] <- 61
score

# 조건을 만족하는 행과 열
idx <- which(iris[,1:4]>5.0,arr.ind=TRUE)
idx

#
# 단일변수 (일변량) - 범주형 자료 탐색
#
favorite <- c('WINTER','SUMMER','SPRING',
               'SUMMER','SUMMER','FAIL',
               'FAIL','SUMMER','SPRING','SPRING')
favorite
class(favorite)
table(favorite)
table(favorite)/length(favorite)
ds <- table(favorite)
ds
barplot(ds,main='favorite season')    # 막대그래프

ds.new <- ds[c(2,3,1,4)]              # 순서대로 나열 -> 봄, 여름, 가을, 겨울
ds.new
barplot(ds.new,main='favorite season')

pie(ds,main='favorit season')         # 원형그래프
pie(ds.new,main='favorit season')

# 범주형 -> 값의 범위가 정해져 있는 것
favorite.color <- c(2,3,2,1,1,2,2,
                    1,3,2,1,3,2,1,2)
ds <- table(favorite.color); ds         # 숫자로 된 범주형
barplot(ds, main='favorite season')
colors <- c('green','red','blue')
names(ds) <- colors; ds                 # 문자로 된 범주형
barplot(ds, main='favorite season',
        col=colors)
pie(ds,main='favorite season',
    col=colors)

#
# 단일변수 (일변량) - 연속형 자료 탐색
#
weight <- c(60,62,64,65,68,69); weight
weight.heavy <- c(weight,120); weight.heavy
# 평균
mean(weight); mean(weight.heavy)
# 중앙값
median(weight); median(weight.heavy)
# 절사평균 -> 총 수에서 상위,하위 값(20%)을 제외한 평균값
mean(weight,trim=0.2)
mean(weight.heavy, trim=0.2)
# 사분위수
quantile(weight.heavy)             # 0% -> 최소값, 100% -> 최대값
                                   # 25%->1사분위 , 50%->2사분위 , 75%->3사분위
quantile(weight.heavy,(1:10)/10)
summary(weight.heavy)

# 산포(distribution) - 값이 퍼져있는 정도 파악
# 분산
var(weight)
# 표준편차
sd(weight)
# 값의 범위(최소값과 최대값)
range(weight)
# 최대값과 최솟값의 차이
diff(range(weight))

# histogram: 연속형 자료의 분포를 시각화
# 연속형 자료에서는 구간을 나누고 구간에 속한
# 값들의 개수를 세는 방법으로 사용
str(cars)
dist <- cars[,2]
hist(dist,main='Histogram for 제동거리',
     xlab='제동거리',ylab='빈도수',
     border='blue',col='green',
     las=1,breaks=5)
# las 가로/세로 숫자 방향(0-3)
# breaks 막대수

# 상자그림(boxplot, 상자수염그림)
# 사분위수를 시각화하여 그래프 형태로 표시
# 상자그림은 하나의 그래프로 데이터의 분포
# 형태를 포함한 다양한 정보를 전달
# 자료의 전반적인 분포를 이해하는데 도움
# 구체적인 최소/최대/중앙값을 알기는 어렵다.
boxplot(dist,main="자동차 제동거리")
# boxplot은 대략적인 최소값, 1사분위, 2사분위, 3사분위, 최대값, 이상치를 확인할 수 있다.
# 위의 점은 이상치를 나타내는 것으로
# 이는 대략적인 데이터 분포 범위에서 벗어난 것을 말한다.
boxplot.stats(dist)
boxplot.stats(dist)$stats      # 정상범위 사분위수
boxplot.stats(dist)$n          # 관측치 개수
boxplot.stats(dist)$conf       # 중앙값 신뢰구간
boxplot.stats(dist)$out        # 이상치(특이값)목록

# 일변량중 그룹으로 구성된 자료의 상자그림
boxplot(Petal.Length~Species,                   # 그룹으로 묶기위해 '~'사용
        data=iris, main='품종별 꽃잎의 길이')
boxplot(iris$Petal.Length~iris$Species,
        main='품종별 꽃잎의 길이')

# 한 화면에 여러 그래프 작성
par(mfrow=c(1,3)) # 1X3 가상화면 분할
barplot(table(mtcars$carb),main="Carburetors",
        xlab="carburetors",ylab="freq",
        col="blue")
barplot(table(mtcars$cyl),main="Cyl",
        xlab="cyl",ylab="freq",
        col="red")
barplot(table(mtcars$gear),main="gear",
        xlab="gear",ylab="freq",
        col="green")
par(mfrow=c(1,1)) # 가상화면 분할 해제

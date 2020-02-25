#
#2019-12-04
#
# 결측치 처리
#
# vector의 결측치 처리

# 결측치 처리하기 위해서는 결측치가 있는지 없는지 먼저 확인하기.
z <- c(1,2,3,NA,5,NA,8)
sum(z)
is.na(z)               # is로 시작하는 함수는 결과값이 논리값이다.
sum(is.na(z))          # 원칙적으로 논리형은 sum이 되지 않는다.
                       # False: 0, True:1
sum(z, na.rm = TRUE)   # na.rm -> 결측지 제외 = TRUE

# 결측치 대체 및 제거
# 무조건 지워야하는지 잘 생각하고 결정하기
# -> matrix나 data.frame인 경우 변수들도 다 삭제됨
z1 <- z
z2 <- c(5,8,1,NA,3,NA,7)
z1[is.na(z1)] <- 0                 # 단순대입법 -> 정해진 값으로 대체
z1
z3 <- as.vector(na.omit(z2))       # Lisewise delection -> 결측치 삭제
                                   # na.omit -> 결측치가 포함된 데이터 삭제
z3

# Matrix/ Data Frame 결측치 처리

x <- iris
x[1,2] <- NA
x[1,3] <- NA
x[2,3] <- NA
x[3,4] <- NA
head(x)

# Matrix/Data Frame 열(변수)별 결측치 확인

# 1. for문 이용
for(i in  1:ncol(x)) {
  this.na <- is.na(x[,i])
  cat(colnames(x)[i],
      "\t",sum(this.na),
      "\n")
}

# 2. apply() 이용

# 방법1.
col_na <- function(y) {
  return(sum(is.na(y)))
}
na_count <- apply(x,2,col_na)
na_count

# 방법2.
na_count <- apply(x,2,
                  function(y) sum(is.na(y)))
na_count


barplot(na_count[na_count>0])                   # 결측치 수

install.packages("VIM")                         # R에는 다양한 패키지들이 존재한다.
                                                # 스스로 패키지를 찾아보고 적용시켜보는 연습이 필요하다.
require(VIM)                                    # library와 같은 역할

# 결측치 자료 조합 확인용 시각화 도구
aggr(x,prop=FALSE,numbers=TRUE)                 # 147 -> 결측치가 없는 데이터의 개수
                                                # 결측치가 어디서 발생했는지 시각적으로 확인이 가능하다.

# 두 개의 변수간의 결측치 관계 확인 시각화 도구
marginplot(x[c("Sepal.Width","Petal.Width")],
           pch=20, col=c("darkgray","red","blue"))  #  빨간 점이 결측치 데이터

# Matrix/Data Frame의 행(data)별 결측치 확인
rowSums(is.na(x))             # 1,2,3 번째 행에 결측치가 들어가 있다.
sum(rowSums(is.na(x))>0)      # 결측치가 포함된 행의 수

sum(is.na(x))

# 결측치를 제외한 새로운 데이터셋 생성
head(x)
x[!complete.cases(x), ]          # NA가 포함된 행 출력
y <- x[complete.cases(x),]       # complete.cases-> 결측치가 포함된 행을 제거해서 보여줌.
head(y)

# 특이값, 이상치(outlier)
st <- data.frame(state.x77)
summary(st$Income)
boxplot(st$Income)
boxplot.stats(st$Income)$out

# 특이값 처리 : NA로 변환 후 결측치 처리방법 이용
out.val <- boxplot.stats(st$Income)$out
st$Income[st$Income %in% out.val] <- NA    # %in% -> 포함되어있다면(포함유무)
head(st)
newdata <- st[complete.cases(st),]
head(newdata)

# 데이터 가공
#
# 데이터 정렬
# vector 정렬
v1 <- c(1,7,6,8,4,2,3)
order(v1) # 데이터가 몇번째인지 알려주는 함수
v1 <- sort(v1); v1
v2 <- sort(v1,decreasing = T); v2

# Matrix/Data Frmae 정렬
head(iris)
order(iris$Sepal.Length)
iris[order(iris$Sepal.Length), ] # Ascending
iris[order(iris$Sepal.Length, decreasing = T),] # Descreasing
iris.new <- iris[order(iris$Sepal.Length),]
head(iris.new)
iris[order(iris$Species,decreasing = T,
           iris$Sepal.Length),]                # 정렬 기준을 2개 설정 

# 데이터 분리
sp <- split(iris,iris$Species); sp             # split를 사용해서 iris를 품종별로 분류
summary(sp)
summary(sp$setosa)
sp$setosa

# 데이터 선택
subset(iris,Species=="setosa")
subset(iris,Sepal.Length>7.5)
subset(iris,Sepal.Length>5.1&Sepal.Width>3.9)
subset(iris,Sepal.Length>7.6,
       select=c(Petal.Length,Petal.Width))

# 데이터 Sampling
# 숫자를 임의로 추출(Vector)
x <- 1:100
y <- sample(x, size=10, replace=FALSE)   # replace : 복원/비복원
                                         # 현재 비복원 -> 한 번 추출한 것은 다시 추출하지 말아라.
y

# 행을 임의로 추출
idx <- sample(1:nrow(iris),size = 50,replace = FALSE)
iris.50 <- iris[idx,]
dim(iris.50)
head(iris.50)

sample(1:20,size = 5) # 결과값이 계속 변함
sample(1:20,size = 5)
sample(1:20,size = 5)

set.seed(100)         # 같은 값을 보내주는 것
sample(1:20,size = 5)
set.seed(100)
sample(1:20,size = 5)
set.seed(100)
sample(1:20,size = 5)

# 데이터 조합
combn(1:5,3)         # 조합(범위, 조합할 개수)

x=c("red","green","blue","black","white")
com <- combn(x,2)
com

for(i in 1:ncol(com)) {
  cat(com[,i],"\n")
}

# 데이터 집계
agg <- aggregate(iris[,-5],
                 by=list(iris$Species),         # 집계하는 기준
                 FUN=mean)                      # 집계하면서 할 동작
agg

agg <- aggregate(iris[,-5],
                 by=list(iris$Species),
                 FUN=sd)
agg

head(mtcars)
agg <- aggregate(mtcars,
                 by=list(cyl=mtcars$cyl, vs=mtcars$vs),
                 FUN=max)
agg

# 데이터 병합
x <- data.frame(name=c("a","b","c"),
                mat=c(90,80,40))
y <- data.frame(name=c("a","b","d"),
                korean=c(75,60,90))
z <- merge(x,y,by=c("name"))
z

merge(x,y)
merge(x,y, all.x=T) 
merge(x,y, all.y=T)
merge(x,y, all=T)

x <- data.frame(name=c("a","b","c"),
                mat=c(90,80,40))
y <- data.frame(sname=c("a","b","d"),
                korean=c(75,60,90))
merge(x,y,by.x=c("name"),by.y = c("sname"))

#
# dplyr package
#

install.packages("dplyr") # 가장 많이 사용하는 패키지
                          # pipe연산자 -> 단축키: (왼쪽 Ctrl + 왼쪽 Shift + M)
library(dplyr)

df <- data.frame(var1=c(1,2,1),
                 var2=c(2,3,2))
df

# rename(): 이름 변경
df <- rename(df,v1=var1,v2=var2)
df

# 파생변수 추가
df$sum <- df$v1+df$v2
df

df[2,1] <- 5
df

df <- data.frame(id=c(1,2,3,4,5,6),
                 class=c(1,1,1,1,2,2),
                 math=c(50,60,45,30,25,50),
                 english=c(98,97,86,98,80,89),
                 science=c(50,60,78,58,65,98))
df

# filter(): 행 추출 -> filter은 조건식만 주면 된다.
#                      df는 파이프로 받아온다.
df %>% filter(class==1)
df %>% filter(class==2)
df %>% filter(class != 1)
df %>% filter(class != 2)

df %>% filter(science>70)
df %>% filter(math<50)

df %>% filter(class==1&math>=50)
df %>% filter(math>=50|english>=90)
df %>% filter(class %in% c(1,3,5))       # class에 1,3,5가 포함된것을 추출해라.

class1 <- df %>% filter(class==1)
class2 <- df %>% filter(class==2)
class1
class2

# select(): 변수 추출
df %>% select(math)
df %>% select(science)

df %>% select(class,math,science)

df %>% select(-math)

# dplyr 함수 조합
df %>%  
  filter(class==1) %>% 
  select(science)

df %>% 
  select(id,science) %>% 
  head

df %>% 
  select(id,science) %>% 
  sum

df %>% 
  select(id,science) %>% 
  max

# arrange(): 정렬
df %>% arrange(science)          # 오름차순
df %>% arrange(desc(science))    # 내림차순

# mutate(): 파생변수 추가
df %>% 
  mutate(total=math+english+science) %>% 
  head

df %>% 
  mutate(total=math+english+science,
         average=(math+english+science)/3) %>% 
  head

df %>% 
  mutate(grade=ifelse(science>=60,'pass','fail')) %>% 
  head

df %>% 
  mutate(total=math+english+science,
         average=(math+english+science)/3) %>% 
  mutate(grade=ifelse(average>=90,'pass',
                      ifelse(average<60,'fail','normal'))) %>% 
  head

df %>% 
  mutate(total=math+english+science,
         average=(math+english+science)/3) %>% 
  arrange(desc(average)) %>% 
  head

df.sort <- df %>% 
  mutate(total=math+english+science,
         average=(math+english+science)/3) %>% 
  arrange(desc(average))

df.sort

# summarise(): 집단별 요약
# group_by(): 집단별 나누기
df %>% summarise(mean_math=mean(math))

df %>% 
  group_by(class) %>% 
  summarise(mean_math=mean(math),
            mean_english=mean(english),
            mean_science=mean(science),
            n=n())                       #n(): 빈도수를 계산해주는 함수

install.packages("ggplot2")
library(ggplot2)
str(ggplot2::mpg)
dim <- data.frame(ggplot2::mpg)
dim(mpg)
str(mpg)
head(mpg)
View(mpg)  # V대문자로 써야함. *주의*

mpg %>% 
  group_by(manufacturer,drv) %>% 
  summarise(mean_cty=mean(cty)) %>% 
  head(10)

mpg %>% 
  group_by(manufacturer) %>% 
  filter(class=='suv') %>% 
  mutate(tot=(cty+hwy)/2) %>% 
  summarise(mean_tot=mean(tot)) %>% 
  arrange(desc(mean_tot)) %>% 
  head(5)

# 데이터 합치기
# left_join(): 가로로 합치기 ( 변수 추가 )
# inner_join(): 가로로 합치기 ( 변수 추가 )
# full_join(): 가로로 합치기 ( 변수 추가 )
# bind_rows(): 세로로 합치기 ( data 추가 )

df1 <- data.frame(id=c(1,2,3,4,5),
                  midterm=c(60,80,70,90,85))
df2 <- data.frame(id=c(1,2,3,4,5),
                  final=c(60,80,70,90,85))
total <- left_join(df1,df2,by='id')
total

df1 <- data.frame(id=c(1,2,3),
                  address=c('서울','부산','제주'),
                  stringsFactors=F)        # stringsFactors: 문자열이 Factor로 만들어질 가능성을 막아주는 것
df2 <- data.frame(id=c(1,2,4),
                  gender=c('남','여','남'))

df_left <- left_join(df1,df2,by='id'); df_left
df_inner <- inner_join(df1,df2,by='id'); df_inner
df_full <- full_join(df1,df2,by='id'); df_full

df1 <- data.frame(id=c(1,2,3,4,5),
                  test=c(60,80,70,90,85))
df2 <- data.frame(id=c(1,2,3,4,5),
                  test=c(60,80,70,90,85))

df_all <- bind_rows(df1,df2)
df_all

install.packages("psych")
library(psych)

summary(mtcars)
describe(mtcars) # summary함수와 유사, but 더 많은 내용을 보여줌

install.packages("descr")
require(descr)

df <- data.frame(id=c(1,2,4),
                  gender=c('남','여','남'))
table(df$gender)

freq(df$gender)       # 도수분포표와 그래프를 동시에
freq(df$gender,plot=F)
# 교재 172~p.223





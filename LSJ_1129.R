# 제출자: 이소정
# 작성일: 2019.11.29-30
# 제출일: 2019.12.02
# 문1)

#.1 => 수정
score <- matrix(c(10,21,
                 40,60,
                 60,70,
                 20,30),
                nrow=4,ncol=2,byrow=T)
score

# 가능하면 dataframe사용하는 것을 권장
m <- c(10,40,60,20)
f <- c(21,60,70,30)
score <- data.frame(m,f)
score

#.2
colnames(score) <- c('male','female')
score

#.3
score[2, ]

#.4
score[ ,'female']

#.5
score[3,2]

# 문2)

#.1
st <- data.frame(state.x77)
class(st)

#.2
st

#.3 => 추가
colnames(st)
names(st)         # 방법2

#.4
rownames(st)

#.5
nrow(st); ncol(st) # 각각의 개수
dim(st)            # 행/열의 개수

#.6
str(st)

#.7
rowSums(st)
rowMeans(st)

#.8 => 추가
colSums(st)
apply(st,1,sum)         #apply함수 활용하는 방법
colMeans(st)
apply(st,1,mean)        #apply함수 활용하는 방법

#.9
st['Florida', ]

#.10
st[1:50,'Income']

#.11
st['Texas','Area']

#.12
st['Ohio',c('Population','Income')]

#.13
st.1 <- subset(st,Population>=5000)
st.1

#.14 => 수정
st.2 <- subset(st,Income>=4500)
st.2[ ,c('Population','Income','Area')]

subset( st, Income >= 4500, select = c( 'Income','Area' ) ) # 방법1
subset( st, Income >= 4500 )[ , c( 'Income', 'Area' ) ] # 방법2

#.15
nrow(st.2)

#.16
st.3 <- subset(st,Area>=100000&Frost>=120)
st.3

#.17
st.4 <- subset(st,Population<2000&Murder<12)
st.4

#.18 => 수정
st.5 <- subset(st,Illiteracy>=2.0)
mean(st.5[,'Income'])

#방법 1
tmp <- subset( st, Illiteracy >= 2.0 )
tmp <- tmp$Income
mean( tmp )

# 방법 2
mean( subset( st, Illiteracy >= 2.0 )$ Income )

#.19 => 수정
# 문맹률이 2.0이상인 주->st.5
st.6 <- subset(st,Illiteracy<2.0)
st.5_1 <- mean(st.5[,'Income'])
st.6_1 <- mean(st.6[,'Income'])
abs(st.5_1-st.6_1)

# 방법 1
tmp1 <- subset( st, Illiteracy < 2.0 )
tmp1 <- tmp1$Income
tmp2 <- subset( st, Illiteracy >= 2.0 )
tmp2 <- tmp2$Income
abs( mean( tmp1 ) - mean( tmp2 ) )

# 방법 2
abs( mean( subset( st, Illiteracy < 2.0 )$Income ) - mean( subset( st, Illiteracy >= 2.0 )$Income ) )

#.20 => 수정
st.7 <- subset(st,Life.Exp==max(st[ ,'Life.Exp']))
rownames(st.7)

#.21
st.8 <- subset(st,Income>st['Pennsylvania','Income'])
rownames(st.8)

# 조건을 변수로 지정
pen.income <- st[ 'Pennsylvania','Income' ]
rownames( subset( st, Income > pen.income ) )

# 문3)

#.1
class(mtcars)

#.2
dim(mtcars)

#.3
str(mtcars)

#.4
car.1 <- subset(mtcars,mpg==max(mtcars[,'mpg']))
rownames(car.1)

#.5
car.2 <- subset(mtcars,gear==4)
car.2_1 <- subset(car.2,mpg==min(car.2[,'mpg']))
rownames(car.2_1)

#.6
mtcars['Honda Civic',c('mpg','gear')]

#.7
car3 <- subset(mtcars,mpg>mtcars['Pontiac Firebird','mpg'])
rownames(car3)

#.8 => 추가
mean(mtcars[,'mpg'])

mean( mtcars$mpg )

#.9 => 추가
unique(mtcars[,'gear'])

unique(mtcars$gear)

# 문4)

#.1
class(airquality)

#.2
head(airquality)

#.3
air.1 <- subset(airquality,Temp==max(airquality[,'Temp']))
air.1[ ,c('Month','Day')]

#.4
air.2 <- subset(airquality,Month==6)
max(air.2[,'Wind'])

#.5
air.3 <- subset(airquality,Month==7)
mean(air.3[,'Temp'])

#.6
air.4 <- subset(airquality,Ozone>100)
nrow(air.4)

# 문5)

class(state.x77)
st <- data.frame(state.x77)
setwd("C:/workR")

#.1
st.1 <- subset(st,Income>=5000)
write.csv(st.1[,c('Income','Population','Area')],"rich_state.csv")

#.2
ds <- read.csv(file="rich_state.csv",sep=',')
ds



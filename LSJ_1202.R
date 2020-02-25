# 제출자: 이소정
# 작성일: 2019.12.02
# 제출일: 2019.12.02

# 문1)

#.1
gender <- c('F','F','F','M','M',
            'F','F','F','M','M')
gender

#.2
gen <- table(gender); gen

#.3
barplot(gen,main='GENDER',xlab='성별',ylab='빈도')    

#.4
pie(gen,main='GENDER')    

# 문2)

#.1
season <- c('여름','겨울','봄','가을','여름',
            '가을','겨울','여름','여름','가을')
season

#.2
s <- table(season); s
s.new <- s[c(3,4,1,2)]; s.new

#.3
barplot(s.new,main='선호계절',xlab='계절',ylab='빈도')

#.4
pie(s.new,main='선호계절')

# 문3)

#.1
score <- c(90,85,73,80,85,65,78,50,68,96)
names(score) <- c('KOR','ENG','ATH','HIST','SOC',
                  'MUSIC','BIO','EARTH','PHY','ART')

#.2
score

#.3
mean(score); median(score)

#.4
sd(score)

#.5 -> 인덱스의 값 같이 출력됨
names(which.max(score))
names( score[ score == max( score ) ] ) # 방법2

#.6
# boxplot은 데이터 분포가 어떻게 되어 있는지 알기위해 사용
boxplot(score)
boxplot.stats(score)$out # 이상치 존재하지 않는다.

#.7
hist(score,main='학생 성적',
     col='purple')

# 문4)

# 직접 데이터를 가져올 때 필수적으로 해야 할 과정
dim( mtcars )
str( mtcars )
head( mtcars )
tail( mtcars )


#.1
wt <- mtcars$wt
mean(wt)
median(wt)
mean(wt,trim=0.15)
sd(wt)

#.2
summary(wt)

#.3
cyl <- table(mtcars$cyl); cyl

#.4
barplot(cyl,main = "Cylender", xlab = '#of cyl', ylab = 'freq' )

#.5 -> 수정
hist(table(wt),main = 'Weight', xlab = 'weight', ylab = 'freq' )

#.6
boxplot(wt,main='중량') # 이상치가 왜 들어갔는지 알아봐야함
boxplot.stats(wt)
# 최소값: 1.5130, 1사분위: 2.5425, 2사분위: 3.3250, 3사분위: 3.6500, 최대값: 5.2500
# 관측치 개수: 32
# 중앙값 신뢰구간 3.015667~3.634333
# 이상치: 5.424, 5.345

#.7
boxplot(mtcars$disp)
boxplot.stats(mtcars$disp)
# 최소값: 71.10, 1사분위: 120.65, 2사분위: 196.30, 3사분위: 334.00, 최대값: 472.00
# 관측치 개수: 32
# 중앙값 신뢰구간 136.7098 ~ 255.8902
# 이상치: 없다.

#.8
boxplot(mtcars$mpg~mtcars$gear,
        main='mtcars')
st <- boxplot(mtcars$mpg~mtcars$gear); st
#summary이용
summary(mtcars$mpg[mtcars$gear==3])
summary(mtcars$mpg[mtcars$gear==4])
summary(mtcars$mpg[mtcars$gear==5])

#[3]번 그룹
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 10.40   14.50   15.50   16.11   18.40   21.50 
# 관측치 개수: 15
# 중앙값 신뢰구간 13.90898~17.09102
# 이상치: 없다

#[4]번 그룹
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 17.80   21.00   22.80   24.53   28.07   33.90 
# 관측치 개수: 12
# 중앙값 신뢰구간 19.21956~26.38044
# 이상치: 없다

#[5]번 그룹
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 15.00   15.80   19.70   21.38   26.00   30.40 
# 관측치 개수: 5
# 중앙값 신뢰구간 12.49271~26.90729
# 이상치: 없다

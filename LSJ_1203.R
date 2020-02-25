# 제출자: 이소정
# 작성일: 2019.12.03
# 제출일: 2019.12.03

# 문1) -> 추가
income <- c(121,99,41,35,40,29,35,24,50,60)
edu <- c(19,20,16,16,18,12,14,12,16,17)
re <- data.frame(income,edu)
plot(income~edu,data=re)
# 교육기간이 길수록 수입이 커지는 것을 알 수 있다.

###################################
res <- lm( income~edu, data = re )
abline( res )

cor( income, edu )
# 수입과 교육기간 사이에 상관관계는 강하다.

# 문2) -> 추가
score <- c(77.5,60,50,95,55,85,72.5,80,92.5,87.5)
view <- c(14,10,20,7,25,9,15,13,4,21)
re2 <- data.frame(view,score)
plot(score~view,data=re2)
# 대체적으로 TV시청시간이 적을수록 점수가 높다.

###############################
res <- lm( score~view, data = re2 )
abline( res )

cor( score, view )
# 비교적 강한 음의 상관관계를 갖는 것을 알 수 있다.

# 문3)
par(mfrow=c(2,5))
for(i in 2:11) {
  plot(mtcars[,i]~mtcars[,1],
  main=colnames(mtcars)[i],
  xlab='mpg',ylab=colnames(mtcars)[i])
}
par(mfrow=c(1,1))

head(mtcars)
cor(mtcars)        # 모든 변수에 대한 상관관계
cor(mtcars)[1,]    # 첫 줄만 출력
# mpg와의 상관계수가 높은 것은 
# cyl, disp, hp, drat, wt, vs, am, card가 있다.
# 이 중 가장 상관성이 높은 것은 wt이다.
pairs(mtcars,main="mtcars")


# 문4)
# 시계열 분석 -> 시간데이터가 x축에 오게된다.
year <- 2015:2026
people <- c(51014,51245,51446,51635,51811,51973,
            52123,52261,52388,52504,52609,52704)
plot(year,people,main='예상 인구수',
     type='l',lty=1,lwd=1,              
     xlab='YEAR',ylab='PEOPLE', col='blue')

# 문5)

# 데이터를 받게되면 한 번 해보는 것이 좋음
class(trees)
dim(trees)
str(trees)
head(trees)
tail(trees)

#.1 -> 추가
dt <- data.frame(trees$Girth,trees$Height)
plot(trees$Girth~trees$Height,data=dt)
#######################################
res <- lm( trees.Girth~trees.Height, data = dt )
abline( res )
cor( trees$Girth, trees$Height )
# 상관계수는 0.5192801로 나무의 지름과 높이는 상관관계가 있다.

#.2
plot(trees)                                # 이변량일 때 주로 사용
pairs(trees,main='나무길이의 상관관계')    # 다변량일 때 주로 사용
cor(trees)
# 상관관계가 가장 큰 것은 나무의 지름(Girth), 나무의 부피(Volume)이다.
# 하지만 전부 상관계수가 전부 0.5이상인 것으로 보아
# 각 변수들이 서로 밀접한 연관이 있다는 것을 알 수 있다.
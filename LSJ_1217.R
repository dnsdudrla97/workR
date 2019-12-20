#
# 작성자: 이소정
# 작성일: 2019-12-17
# 제출일: 2019-12-17
#
# 문1)
# trees 데이터셋에 대해 다음의 문제를 해결하는 R 코드를 작성하시오.

# (1) 나무 둘레(Girth)와 나무의 키(Height)로 나무의 볼륨을 예측하는
# 다중선형 회귀모델을 만드시오.

str(trees)
head(trees)

model <- lm(Volume~.,data = trees)
model

coef(model)

# (2) 다중선형 회귀모델을 이용하여 trees 데이터셋의
# 나무 둘레(Girth)와 나무의 키(Height)로 나무의 볼륨을 예측하시오.

pred <- predict(model)
pred

# (3) (2)에서 예측한 볼륨과 실제 trees 데이터셋의 볼륨(Volume)이
# 얼마나 차이가나는지 보이시오. (예측값, 실제값, 예측값-실제값을 나타낸다.)

# 예측값
fitted(model)
# 실제값
trees$Volume
# 잔차
residuals(model)

# 문2)
# mtcars 데이터셋에서 다른 변수들을 이용하여 연비(mpg)를 예측하는 다중 회귀모델을 만드시오.

# (1) 전체 변수를 이용하여 연비(mpg)를 예측하는 회귀모델을 만들고
# 회귀식을 나타내시오.

str(mtcars)
head(mtcars)

model2 <- lm(mpg~.,data = mtcars)
model2

h0 <- coef(model2)[1]
h1 <- coef(model2)[2]
h2 <- coef(model2)[3]
h3 <- coef(model2)[4]
h4 <- coef(model2)[5]
h5 <- coef(model2)[6]
h6 <- coef(model2)[7]
h7 <- coef(model2)[8]
h8 <- coef(model2)[9]
h9 <- coef(model2)[10]
h10 <- coef(model2)[11]

mpg = h0 + h1*mtcars$cyl + h2*mtcars$disp + h3*mtcars$hp + 
  h4*mtcars$drat + h5*mtcars$wt + h6*mtcars$qsec + 
  h7*mtcars$vs + h8*mtcars$am + h9*mtcars$gear + h10*mtcars$carb

# (2) 연비(mpg)를 예측하는 데 도움이 되는 변수들만 사용하여 예측하는 
# 회귀모델을 만들고 회귀식을 나타내시오.

summary(model2)

library(MASS)
model2_1 <-  stepAIC(model2)
summary(model2_1)

mpg = h0 + h5*mtcars$wt + h6*mtcars$qsec + h8*mtcars$am

# (3) (1), (2)에서 만든 예측모델의 설명력(Adjusted R-squared)을 비교하시오.

summary(model2) # 0.8066
summary(model2_1) # 0.8336
# model2_1이 필요한 변수만을 사용하여 선형에 가깝게 나온다.

# 문3) 
# UCLA 대학원의 입학 데이터를 불러와서 mydata에 저장한 후 다음 물음에 답하시오.

mydata <- read.csv( "https://stats.idre.ucla.edu/stat/data/binary.csv" )

# (1) gre, gpa, rank를 이용해 합격 여부(admit)를 예측하는 로지스틱 모델을 만드시오(0: 불합격, 1:합격).

str(mydata)
head(mydata)

new_data <- mydata
head(new_data)

new_model <- glm(admit~.,data = new_data)
new_model
coef(new_model)

# (2) mydata에서 합격 여부(admit)를 제외한 데이터를 예측 대상 데이터로 하여 (1)에서 만든 모델에 입력하여 
# 합격 여부를 예측하고 실제값과 예측값을 나타내시오.

known <- mydata[ ,-1]

pred <- predict(new_model,known)
pred
pred <- round(pred,0)
pred # 예측값
real <- mydata$admit
real # 실제값

# (3) 만들어진 모델의 예측 정확도를 나타내시오.

test <- mydata[ ,2:4]

pred <- predict(new_model,test)
pred <- round(pred,0)

answer <- mydata$admit
pred == answer
acc <- mean(pred == answer)
acc

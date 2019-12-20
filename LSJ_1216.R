#
# 작성자: 이소정
# 작성일: 2019-12-16
# 제출일: 2019-12-16
#

# 문1)
# state.x77 데이터셋에서 문맹률(Illiteracy)을 이용해 범죄율(Murder)을 예측
# 하는 단순선형 회귀모델을 만드시오. 그리고 문맹률이 0.5, 1.0, 1.5일 때 범
# 죄율을 예측하여 보시오.

st <- data.frame(state.x77)
st_model <- lm(Murder~Illiteracy,data=st)
st_model

df <- data.frame(Illiteracy = c(0.5, 1.0, 1.5))
predict(st_model,df)
plot(df$Illiteracy,predict(st_model,df),col='red',cex=2,pch=20)
abline(st_model)

# 문2)
# trees 데이터셋에서 나무둘레(Girth)로 나무의 볼륨(Volume)을 예측하는 단
# 선형 회귀모델을 만드시오. 그리고 나무 둘레가 8.5, 9.0, 9.5일 때, 나무의
# 볼륨(Volume)을 예측하여 보시오.

trees_model <- lm(Volume~Girth,data=trees)
trees_model

df <- data.frame(Girth = c(8.5,9.0,9.5))
predict(trees_model,df)
plot(df$Girth,predict(trees_model,df),col='red',cex=2,pch=20)
abline(trees_model)

# 문3) 
# pressure 데이터셋에서 온도(temperature)로 기압(pressure)을 예측하는 단
# 순선형 회귀모델을 만드시오. 그리고 온도가 65, 95, 155일 때 기압을 예측
# 하여 보시오.

pr_model <- lm(pressure~temperature,data=pressure)
pr_model

df <- data.frame(temperature=c(65,95,155))
predict(pr_model,df)
plot(df$temperature,predict(pr_model,df),col='red',cex=2,pch=20)
abline(pr_model)

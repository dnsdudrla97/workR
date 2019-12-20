# 2019-12-18
#
# 군집화(clustering), qnsfb(classification)
#
# 군집화(clustering)
# 주어진 대상 데이터들을 유사성이 높은 것끼리 묶어주는 기술
# (군집, 범주, 그룹)
#
# k-means(평균) 군집화 알고리즘
mydata <- iris[ ,1:4]
fit <- kmeans(x=mydata, centers = 3)
fit

fit$cluster # 군집번호
fit$centers # 군집된 점의 좌표

library(cluster)
clusplot(mydata,        # 군집대상
         fit$cluster,   # 군집번호
         color = TRUE,  # 원의 색
         shade = TRUE,  # 원의 빗급표시 유무
         labels = 2,    # 관측값 출력 형태 (1: 모양, 2: 숫자)
         lines = 1)     # 중심선 연결 표시

subset(mydata, fit$cluster == 2)

# 대상 데이터 표준화 후 군집화
#
# 데이터와 데이터의 거리를 계산할 때 발생하는 문제
# 모든 변수가 거리 계산에 동등한 영향을 갖도록하기 위해서
# 모든 변수의 자료 범위를 0~1사이로 표준화한 후 거리 계산을 한다.
#
# (x - min(A)) / (max(A) - min(A))
# x: 변수 A의 임의의 관측값
# max(A), min(A)는 변수 A 관측값중 최대/최소값

std <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}
mydata <- apply(iris[ ,1:4], 2, std)
fit <- kmeans(x = mydata, centers = 3)
fit

#
# KNN(K-Nearest Neighbor, K-최근접 이웃) 분류 알고리즘
#
library(class)
# 훈련용/테스트용 데이터 준비
tr.idx <- c(1:25,51:75,101:125)
ds.tr <- iris[ tr.idx,1:4 ]   # 훈련용
ds.ts <- iris[ -tr.idx,1:4 ]  # 테스트용
cl.tr <- factor(iris[tr.idx,5])  # 훈련용 그룹정보
cl.ts <- factor(iris[-tr.idx,5]) # 테스트 그룹정보
pred <- knn(ds.tr,ds.ts,cl.tr,k=3,prob=TRUE)
pred
acc <- mean(pred==cl.ts)
acc
table(pred, cl.ts)

#
# 교차 검증 방법(K-flod cross validation)
#
install.packages("cvTools")
library(cvTools)

k=10
folds <- cvFolds(nrow(iris),K=k)

acc <- c()
for(i in 1:k){
  ts.idx <- folds$which == 1
  ds.tr <- iris[-ts.idx,1:4]
  ds.ts <- iris[ts.idx,1:4]
  cl.tr <- factor(iris[-ts.idx,5])
  cl.ts <- factor(iris[ts.idx,5])
  pred <- knn(ds.tr, ds.ts, cl.tr, k=5)
  acc[1] <- mean(pred == cl.ts)
}
acc
mean(acc)

# p. 의사결정트리: 511-, 교차검정: 519, 527, Random Forest: 532, 신경망: 537, 554-556, sns연관: 594
# p. 605-
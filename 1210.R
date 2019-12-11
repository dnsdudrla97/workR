#
# 2019-12-10
#
# https://www.rdocumentation.org/packages/vcd/versions/1.4-4/topics/mosaic

# mosaic plot
# 다중변수 범주형 데이터에 대한 각 변수의 그룹별 비율을 면적으로 표시
str(mtcars)
head(mtcars)
mosaicplot(~gear + vs,  # 대상 변수/ ~x축 +y축
           data=mtcars, # 데이터 셋
           color=TRUE,  # y축 변수의 그룹별 음영 다르게
           main = "Gear and Vs") # 제목

mosaicplot(~gear + vs, data=mtcars,
           color=c("green","blue"),
           main="Gear and Vs")

tb1 <- table(mtcars$gear, mtcars$vs)
tb1 # 교차표 형태로 저장된 것
mosaicplot(tb1, color = T, main = "Gear amd Vs")

#
# 차원 축소 (dimension reduction)
# 관계 분석을 할때 내가 원하는 것보다 차원이 높으면 내가 원하는 차원으로 축소하는 것
install.packages("Rtsne")
library(Rtsne)
library(ggplot2)

ds <- iris[,-5]
# 변수 4개를가지고 산점도를 그리자.
# -> 4차원 -> 우리가 그릴 수 있는 차원으로 변환하자.

# 차원 축소
# 중복데이터 제거
dup=which(duplicated(ds))
dup
ds <- ds[-dup, ]
ds.y <- iris$Species[-dup]

# 차원 축소 수행 - t-SNE 실행
tsne <- Rtsne(ds, # 차원 축소 대상 데이터셋
              dim=2, # 축소할 차원 2/3차원
              perplexity=10) # 차원 축소 과정에서 데이터 샘플링을 수행하는 데 샘플의 갯수
                             # (대상데이터수)/3보다 작게 지정
tsne

# 차원축소 결과 시각화
df.tsne <- data.frame(tsne$Y)
head(df.tsne)

ggplot(df.tsne,aes(x=X1,y=X2,color=ds.y)) +
  geom_point(size=2)

install.packages(c("rgl","car"))
library(car)
library(rgl)
library(mgcv)

tsne <- Rtsne(ds, dims=3, perplexity=10)
df.tsne <- data.frame(tsne$Y)
head(df.tsne)

scatter3d(x=df.tsne$X1, y=df.tsne$X2, z=df.tsne$X3) # 회귀면을 포함하고 있는 것

points <- as.integer(ds.y)
color <- c('red','green','blue')
scatter3d(x=df.tsne$X1, y=df.tsne$X2, z=df.tsne$X3,
          point.col=color[points], surface = FALSE)  # 회귀면을 빼고 만든것

# https://skyeong.net/186
# 차원축소에 대한 블로그

# https://cloud.google.com/maps-platform/#get-started
# 로그인해야 사용 가능

#
# 공간 시각화
#
# google map 사용
#
# 절차
# 1. R 최신버전 설치
# 2. ggplot2 최신버전 설치
# 3. ggmap 설치
# 4. 구글맵을 사용하기 위한 API key획득
# 5. 구글맵을 이용한 공간 시각화 수행
library(ggmap)
register_google(key = 'AIzaSyAco-ow34QfCr_nHE2jGsfAy8PL4kuhIBc') # 내 google API key

gc <- geocode(enc2utf8("제주")) # geocode: 원하는 지점의 경도와 위도정보를 알아와주는 함수
gc

cen <- as.numeric(gc) # 경도/위도를 숫자로 변환
cen

# 지도 표시
map <- get_googlemap(center=cen) # 지도 중심점 좌표
ggmap(map)


gc <- geocode(enc2utf8("한라산"))
cen <- as.numeric(gc)
map <- get_googlemap(center = cen, # 지도 중심점 좌표
                     zoom=10, # 지도 확대 정도
                     size= c(640,640), # 지도 크기
                     maptype="roadmap") # 지도 유형 ( x: 위성사진, roadmap :지도에 그린형태, hybrid :조금 섞여있는 모양)
ggmap(map)

cen <- c(126.561099,33.253077) # 경도, 위도
map <- get_googlemap(center = cen,
                     zoom=12,  # 12, 15, 20 비교해보기
                     maptype="roadmap")
ggmap(map)

# 지도 위 마커 표시
gc <- geocode(enc2utf8("제주"))
cen <- as.numeric(gc)
map <- get_googlemap(center = cen,
                     maptype = "roadmap",
                     marker = gc)
ggmap(map)

# 제주 관광지를 지도위에 표시
names <- c("용두암","성산일출봉","정방폭포","중문관광단지","한라산1100고지","차귀도")
addr <- c("제주시 용두암길 15", "서귀포시 성산읍 성산리", "서귀포시 동홍동 299-3",
          "서귀포시 중문동 2624-1","서귀포시 색달동 산1-2","제주시 한경면 고산리 125")
gc <- geocode(enc2utf8(addr))
gc

# 관광지 명칭과 좌표값으로 Data Frame 생성
df <- data.frame(name=names,lon=gc$lon,lat=gc$lat)
df

cen <- c(mean(df$lon),mean(df$lat))

map <- get_googlemap(center=cen,
                     maptype = "roadmap",
                     zoom = 10,
                     size=c(640,640),
                     marker=gc)
ggmap(map)

# 지도에 관광지 이름 추가
gmap <- ggmap(map)
gmap +
  geom_text(data = df, # 데이터셋
            aes(x=lon,y=lat), # 텍스트 위치
            size=5, # 텍스트 크기
            label=df$name) # 텍스트 이름

# 지도에 데이터 표시
dim(wind)
str(wind)

sp <- sample(1:nrow(wind),50)
df <- wind[sp,]
head(df)

cen <- c(mean(df$lon),mean(df$lat))
gc <- data.frame(lon=df$lon,lat=df$lat)
head(gc)

# 지도에 마커 표시
map <- get_googlemap(center = cen,
                     maptype = "roadmap",
                     zoom=6,
                     marker=gc)
ggmap(map)

# 지도에 풍속을 원의 크기로 표시
map <- get_googlemap(center = cen,
                     maptype = "roadmap",
                     zoom = 6)
gmap <- ggmap(map)
gmap +
  geom_point(data = df,
             aes(x = lon, y = lat, size = spd),
             alpha=0.5, col="blue") +
  scale_size_continuous(range = c(1,14)) # 원크기 조절

# 단계 구분도 -> stage_diagram.R 에 자세한 내용 있음#
install.packages("ggiraphExtra")
library(ggiraphExtra)

dim( USArrests)
str(USArrests)
head(USArrests)

library(tibble)
crime <- rownames_to_column(USArrests, var = "state")
crime$state <- tolower(crime$state)
str(crime)

library(ggplot2)
install.packages("mapproj")
library(mapproj)

state_map <- map_data("state")
str(state_map)

# 국내지도 표현이 잘 안됨.
ggChoropleth(data=crime,
             aes(fill=Murder, map_id=state),
             map=state_map)

# https://rpubs.com/cardiomoon/222145
# 우리나라 자료

install.packages("devtools")
# 지도에 있는 좌표값을 github에서 받아오는 것이다.
devtools::install_github("cardiomoon/kormaps2014")
devtools::install_github("cardiomoon/moonBook2")

library(kormaps2014)
library(moonBook2)

areacode # 한글 데이터 깨짐

str(kormap1)

theme_set(theme_gray(base_family="NanumGothic"))

ggplot(korpop1,aes(map_id=code,fill=총인구_명))+
  geom_map(map=kormap1,colour="black",size=0.1)+
  expand_limits(x=kormap1$long,y=kormap1$lat)+
  scale_fill_gradientn(colours=c('white','orange','red'))+
  ggtitle("2015년도 시도별 인구분포도")+
  coord_map()
# kormap1 : 2014년 한국행정지도(시도별)
# kormap2 : 2014년 한국행정지도(시군구별)
# kormap3 : 2014년 한국행정지도(읍면동별)

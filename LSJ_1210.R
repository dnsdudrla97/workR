#
# 작성자: 이소정
# 작성일: 2019-12-10
# 제출일: 2019-12-1
#

# 문1)
# R에서 제공하는 state.x77 데이터셋을 차원 축소하여 
# 2차원 산점도와 3차원 산점도를 작성하시오. 
# (state.x77은 매트릭스 타입이기 때문에 데이터프레임으로 변환하여 실습한다.)

library(Rtsne)
library(ggplot2)

st <- data.frame(state.x77)

dup=which(duplicated(st))
dup

tsne <- Rtsne(st, dim = 2, perplexity = 10)
tsne

df.tsne <- data.frame(tsne$Y)
head(df.tsne)

ggplot(df.tsne,aes(x=X1,y=X2)) +
  geom_point(size=2,color='red')

library(car)
library(rgl)
library(mgcv)

tsne <- Rtsne(st, dims = 3, perplexity = 10)
df.tsne <- data.frame((tsne$Y))
head(df.tsne)

scatter3d(x=df.tsne$X1, y=df.tsne$X2, z=df.tsne$X3 )
# surface = FALSE : 회귀선을 생략해주는 것

# 문2)
# R에서 제공하는 swiss 데이터셋을 차원 축소하여 
# 2차원 산점도와 3차원 산점도를 작성하시오.

str(swiss)
head(swiss)
sw <- swiss

dup=which(duplicated(sw))
dup

tsne <- Rtsne(sw, dim=2, perplexity=10)
tsne

df.tsne <- data.frame(tsne$Y)
head(df.tsne)

ggplot(df.tsne,aes(x=X1, y=X2)) +
  geom_point(size=2)

tsne <- Rtsne(sw, dim=3, perplexity=10)
df.tsne <- data.frame(tsne$Y)
head(df.tsne)

scatter3d(x=df.tsne$X1,y=df.tsne$X2,z=df.tsne$X3)

# 문3) 
# R을 이용하여 지도를 출력하시오.

library(ggmap)
register_google(key = 'AIzaSyAco-ow34QfCr_nHE2jGsfAy8PL4kuhIBc') # 내 google API key

#(1) 서울시청을 중심으로 지도 크기는 600x600,
# 지도 유형은 roadmap인 지도를 출력하시오.
gc <- geocode(enc2utf8("서울시청"))
gc

cen <- as.numeric(gc)
cen

map <- get_googlemap(center = cen,
                     zoom=15,
                     size = c(600,600),
                     maptype = "roadmap")
ggmap(map)

#(2) 금강산 지역을 근방으로 지도 크기는 500x500,
# 지도 유형은 hybrid, zoom은 8인 지도를 출력하시오.

gc <- geocode(enc2utf8("금강산"))
gc

cen <- as.numeric(gc)
cen

map <- get_googlemap(center = cen,
                     zoom=8,
                     size = c(500,500),
                     maptype = "hybrid")
ggmap(map)

#(3) 강남역 근방으로 지도 크기는 640x640,
# 지도 유형은 roadmap, zoom은 16인 지도를 출력하시오.

gc <- geocode(enc2utf8("강남역"))
gc

cen <- as.numeric(gc)
cen

map <- get_googlemap(center = cen,
                     zoom=16,
                     size = c(640,640),
                     maptype = "roadmap")
ggmap(map)

#(4) 지도 유형은 roadmap, zoom은 9인 경도 127.397692, 위도 36.337058
# 지역의 지도를 출력하시오.

cen <- c(127.397692,36.337058)

map <- get_googlemap(center = cen,
                     zoom=9,
                     size = c(640,640),
                     maptype = "roadmap")
ggmap(map)

#(5) 지도 유형은 roadmap, zoom은 10인 경도 135.502330, 위도 34.693594
# 지역의 지도를 출력하시오.

cen <- c(135.502330,34.693594)

map <- get_googlemap(center = cen,
                     zoom=10,
                     size = c(640,640),
                     maptype = "roadmap")
ggmap(map)

# 문4)
# R을 이용하여 서울시 한강 이남의 구청들의 위치에 마커와
# 구청 이름을 지도 위에 표시하시오.

names <- c("강서구청","양천구청","금천구청","동작구청","서초구청","강남구청","송파구청","강동구청")
# addr <- c("서울특별시 강서구 화곡6동 화곡로 302","서울특별시 양천구 신정동 목동동로 105",
#           "서울특별시 금천구 시흥1동 시흥대로73길 70","서울특별시 동작구 노량진2동 장승배기로 161",
#           "서울특별시 서초구 서초2동 남부순환로 2584","서울특별시 강남구 삼성2동 학동로 426",
#           "서울특별시 송파구 잠실6동 올림픽로 326","서울특별시 성내동")
gc <- geocode(enc2utf8(names))
gc

df <- data.frame(name=names,lon=gc$lon,lat=gc$lat)
df

cen <- c(mean(df$lon),mean(df$lat))

map <- get_googlemap(center=cen,
                     maptype = "roadmap",
                     zoom = 10,
                     size=c(640,640),
                     marker=gc)
ggmap(map)

gmap <- ggmap(map)
gmap +
  geom_text(data = df,
            aes(x=lon,y=lat),
            size=5,
            label=df$name)

# 문5)
# R을 이용하여 대한민국의 광역시를 지도 위에 출력하시오. 
# 단, 마커와 광역시 이름을 함께 표시하시오.

names <- c("광주광역시","인천광역시","부산광역시","대구광역시","대전광역시","울산광역시")
# addr <- c("광주광역시 서구 치평동 시청로","인천광역시 남동구 구월1동 정각로 29",
#           "부산광역시 연제구 연산동 중앙대로 1001","대구광역시 중구 동인동1가 공평로 88",
#           "대전광역시 서구 둔산동 둔산로 100","울산광역시 남구 신정1동 중앙로 201")
gc <- geocode(enc2utf8(names))
gc

df <- data.frame(name=names,lon=gc$lon,lat=gc$lat)
df

cen <- c(mean(df$lon),mean(df$lat))

map <- get_googlemap(center=cen,
                     maptype = "roadmap",
                     zoom = 7,
                     size=c(640,640),
                     marker=gc)
ggmap(map)

gmap <- ggmap(map)
gmap +
  geom_text(data = df,
            aes(x=lon,y=lat),
            size=5,
            label=df$name)

# 문6)
# R을 이용하여 서울, 경기, 강원 지역의 국립공원 위치를 지도 상에 
# 마커로 표시하되 국립공원의 이름을 함께 표시하시오.

names <- c("북한산국립공원","태백산국립공원","오대산국립공원",
           "치악산국립공원","설악산국립공원")
# addr <- c("서울특별시 우이동","강원도 태백시 혈동 태백산로 4778",
#           "강원도 평창군 진부면 오대산로 2","강원도 원주시 소초면 무쇠점2길 26",
#           "강원도 속초시 설악동")
gc <- geocode(enc2utf8(names))
gc

df <- data.frame(name=names,lon=gc$lon,lat=gc$lat)
df

cen <- c(mean(df$lon),mean(df$lat))

map <- get_googlemap(center=cen,
                     maptype = "roadmap",
                     zoom = 8,
                     size=c(640,640),
                     marker=gc)
ggmap(map)

gmap <- ggmap(map)
gmap +
  geom_text(data = df,
            aes(x=lon,y=lat),
            size=5,
            label=df$name)

# 문7) 
# ‘2018년도 시군구별 월별 교통사고 자료’로부터
# 서울시의 각 구별 1년 교통사고 발생건수를 
# 지도상에 원의 크기로 나타내시오.


setwd("d:/workR3")
report <- read.csv(file = "Report.csv",sep=',')
head(report)
str(report)
re1 <- subset(report,시도=="서울")
re1 <- re1[,2:4] # 합계만 출력
dim(re1)
re2 <- re1[4:78,] # 구들만 출력
re2
re3 <- subset(re2,기준년도=="발생건수") # 발생건수만 저장
re3

re <- as.vector(re3[,1])
is.vector(re)
gc <- geocode(enc2utf8(re))
gc

df <- data.frame(name=re3[,1],lon=gc$lon,lat=gc$lat)
df

cen <- c(mean(df$lon),mean(df$lat))
cen

map <- get_googlemap(center = cen,
                     maptype = "roadmap",
                     zoom = 11)
gmap <- ggmap(map)

dim(re3)
str(re3)

re_3 <- as.numeric(as.character(re3[,3]))
re_3

gmap +
  geom_point(data = df,
             aes(x = lon, y = lat, size = re_3),
             alpha=0.5, col="blue") +
  scale_size_continuous(range = c(1,14))

# 방법2
ds.tot <- read.csv( 'Report.csv',sep=',' )
# ds.tot <- read.csv( '도로교통공단_시도_시군구별_월별_교통사고(2018).csv' )
ds.seoul <- subset( ds.tot, 시도 == '서울' )
ds.year <- aggregate( ds.seoul[ , '발생건수' ],
                      by = list( 시군구 = ds.seoul$시군구 ), FUN = sum )
ds.year
gc <- geocode( enc2utf8( as.vector( ds.year$시군구 ) ) ) 
gc
cen <- colMeans( as.matrix( gc ) )
map <- get_googlemap( center = cen,
                      size = c( 640, 640 ),
                      zoom = 11,
                      maptype = 'roadmap' )
gmap <- ggmap(map)
gmap +
  geom_point( data = data.frame(gc),
              aes( x = lon, y = lat, size = ds.year$x ),
              alpha = 0.5,
              col = "red" ) +
  scale_size_continuous( range = c(1, 14 ) )

# 문8)
# 7번과 동일한 자료를 이용하여 제주시 1년 교통사고 발생건수를
# 지도상에 원의 크기로 나타내시오.

head(report)
str(report)
re_j1 <- subset(report,시도=="제주")
re_j1 <- re_j1[,2:4]
dim(re_j1)
re_j2 <- re_j1[4:9,] # 구들만 출력
re_j2
re_j3 <- subset(re_j2,기준년도=="발생건수") # 발생건수만 저장
re_j3
str(re_j3)

re_j <- as.vector(re_j3[,1])
is.vector(re_j)
gc <- geocode(enc2utf8(re_j))
gc

df <- data.frame(name=re_j3[,1],lon=gc$lon,lat=gc$lat)
df

cen <- c(mean(df$lon),mean(df$lat))
cen

map <- get_googlemap(center = cen,
                     maptype = "roadmap",
                     zoom = 10)
gmap <- ggmap(map)

dim(re_j3)
str(re_j3)

re_j_3 <- as.numeric(as.character(re_j3[,3]))
re_j_3


gmap +
  geom_point(data = df,
             aes(x = lon, y = lat, size = re_j_3),
             alpha=0.5, col="blue") +
  scale_size_continuous(range = c(1,14))

# 방법2
ds.jeju <- subset( ds.tot, 시도 == '제주' )
ds.year <- aggregate( ds.jeju[ , '발생건수' ],
                      by = list( 시군구 = ds.jeju$시군구 ), FUN = sum )
ds.year
gc <- geocode( enc2utf8( as.vector( ds.year$시군구 ) ) )
gc
cen <- colMeans( as.matrix( gc ) )
map <- get_googlemap( center = cen,
                      size = c( 640, 640 ),
                      zoom = 11,
                      maptype = 'roadmap' )
gmap <- ggmap(map)
gmap +
  geom_point( data = data.frame(gc),
              aes( x = lon, y = lat, size = ds.year$x ),
              alpha = 0.5,
              col = "red" ) +
  scale_size_continuous( range = c(1, 14 ) )

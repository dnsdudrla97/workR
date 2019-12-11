#
# 2019-12-09
# 
install.packages("tidyverse")
# https://www.tidyverse.org/packages/
library(tidyverse)
# tibble : dataframe을 개선한 것

dim(mpg)
str(mpg)
head(mpg)
View(mpg)

# ggplot() + geom_내가 그리려는 함수
ggplot(data = mpg) +                               # 시각화를 할 대상
  geom_point(mapping = aes(x = displ, y = hwy ))   # 산점도를 그리는 함수

month <- c(1,2,3,4,5,6)
rain <- c(55,50,45,50,60,70)
df <- data.frame(month,rain)
df

ggplot(df,aes(x=month,y=rain)) +       # aes 는 매핑할 때 사용하는 함수, ggplot 이나 geom_ 에 쓰면 된다.
  geom_bar(stat='identity',            # 막대 높이를 누구 껄로 할것이냐
           width = 0.7,
           fill="steelblue")

ggplot(df,aes(x=month,y=rain)) +
  geom_bar(stat='identity',
           width = 0.7,
           fill="steelblue") +
  ggtitle("월별 강수량")+              # 타이틀을 사용하고자 할 때
  theme(plot.title=element_text(size=25, face="bold", colour="steelblue")) +     # 형식을 나타내는 것
  labs(x="월",y="강수량") +
  coord_flip()                         # 그래프를 가로로 뉘어라

ggplot(iris,aes(x=Petal.Length)) +
  geom_histogram(binwidth = 0.5)       # 연속couont기준을 정하는것 -> binwidth // 0.5단위로 카운트하여라

ggplot(iris,aes(x=Sepal.Width,fill=Species,color=Species)) +    # 잎의 폭을 기준으로
                                                                # 색상을 종으로 한다면 범주형이 문자 데이터여도 ->  (0,1,2) factor로 인식
                                                                # fill: 채우는 색, color: 경계선 색
  geom_histogram(binwidth = 0.5,position = "dodge") +           # position = "dodge": 품종별로 각각 그려라.
  theme(legend.position = "top")                                # 범례의 위치

# ggplot2 Scatter chart
ggplot(data = iris,mapping = aes(x=Petal.Length,y=Petal.Width)) +
  geom_point()

ggplot(data = iris) +
  geom_point(mapping = aes(x=Petal.Length,y=Petal.Width))

ggplot(data = iris,mapping = aes(x=Petal.Length,y=Petal.Width,color=Species,shape=Species)) +
                                                                          # 산점도 상의 표현되는 모양을 범주형으로 나타낸것
  geom_point(size=3) +
  ggtitle("꽃잎의 길이와 폭") +
  theme(plot.title=element_text(size= 25, face="bold",colour="red"))

# ggplot Box plot
ggplot(data = iris, mapping = aes(y=Petal.Length)) +   # 범위를 나타내는 것이 중요하므로 y를 지정
  geom_boxplot(fill="yellow")                          # 상자수염그래프를 그려줌

ggplot(data = iris, mapping = aes(y=Petal.Length, fill=Species)) +
  geom_boxplot()

# ggplot Line chart
# 시계열: 시간정보데이터를 사용할 때 이용
year <- 1937:1960
cnt <- as.vector(airmiles)
df <- data.frame(year,cnt)
head(df)

ggplot(df,aes(x=year,y=cnt)) +
  geom_line(col="red")

# ggplot 작성 graph 꾸미기( 공통 )
str(economics)

# 사선
ggplot(economics,aes(x=date,y=psavert)) +
  geom_line()  +
  geom_abline(intercept = 12.18671, slope = -0.0005444)
# intercept: y 절편값
# slope: 기울기
# => 회귀식에 의해 나온 값을 이용한다.

# 평행선
ggplot(economics,aes(x=date,y=psavert)) +
  geom_line()  +
  geom_hline(yintercept = mean(economics$psavert))

# 수직선
x_inter <- filter(economics,psavert==min(economics$psavert))$date
ggplot(economics,aes(x=date,y=psavert)) +
  geom_line()  +
  geom_vline(xintercept = x_inter)

# 텍스트 추가
ggplot(airquality, aes(x=Day,y=Temp)) +
  geom_point() +
  geom_text(aes(label=Temp, vjust=0, hjust=0))  # text를 출력하고 싶을때
                                                # vjust, hjust는 텍스트 위치 좌표 0은 우측상단, +1,-1 ....
# 영역 지정 및 화살표 표시
ggplot(mtcars,aes(x=wt,y=mpg)) +
  geom_point() +
  annotate("rect", xmin = 3, xmax = 4, ymin = 12, ymax = 21, alpha = 0.5, fill="skyblue") +
                # <-          상자의 크기                ->
                                                          # 상자의 투명도(0.1~1), 1에 가까울 수록 불투명
  annotate("segment", x=2.5, xend=3.7, y=10, yend=17, color="red", arrow=arrow()) +
# 더 강조할 점을 표시하기 위해서 사용
                                                                 # 화살표를 그려주는 함수
  annotate("text", x=2.5, y=10, label="point")

# https://ggplot2.tidyverse.org/


# tree map: 어떤 기준에 대해 전체적으로 보여주고 싶을 때 사용하는 시각화 도구
# https://rpubs.com/brandonkopp/creating-a-treemap-in-r
install.packages("treemap")
library(treemap)

data(GNI2014)
dim(GNI2014)
str(GNI2014)
head(GNI2014)
View(GNI2014)

treemap(GNI2014, 
        index = c("continent","iso3"), # 계층구조
        vSize = "population",          # 타일 크기
        vColor = "GNI",                # 타일 컬러
        type = "value",                # 타일 컬러링 방법
        bg.labels = "yellow",          # 레이블 배경색
        title = "World's GNI")         # 제목

st <- data.frame(state.x77)
st <- data.frame(st,stname=rownames(st))
treemap(st,
        index=c("stname"),
        vSize = "Area",
        vColor = "Income",
        type = "value",
        title="미국 주별 수입")

# 산점도에 Bubble 추가(Bubble chart)
symbols(st$Illiteracy, st$Murder,           # 원의 x,y좌표
        circles = st$Population,            # 원의 반지름
        inches = 0.3,                       # 원크기 조절값
        fg = "white",                       # 원 테두리 색
        bg = "lightgray",                   # 원 바탕색
        lwd = 1.5,                          # 원 테두리선 두께
        xlab = "rate of Illiteracy",
        ylab = "crime(murder) rate",
        main = "Illteracy and Crime")
text(st$Illiteracy, st$Murder,              # 텍스트출력 x,y좌표
     rownames(st),                          # 출력할 text
     cex=0.6,                               # 폰트크기
     col="brown")                           # 폰트컬러

# https://www.r-graph-gallery.com/index.html
# 여러가지 유형의 다양한 그래프들이 있다.

# Libraries
library(ggplot2)
library(dplyr)
library(plotly)
library(viridis)
library(hrbrthemes)

# The dataset is provided in the gapminder library
library(gapminder)
data <- gapminder %>% filter(year=="2007") %>% dplyr::select(-year)

# Interactive version
p <- data %>%
  mutate(gdpPercap=round(gdpPercap,0)) %>%
  mutate(pop=round(pop/1000000,2)) %>%
  mutate(lifeExp=round(lifeExp,1)) %>%
  
  # Reorder countries to having big bubbles on top
  arrange(desc(pop)) %>%
  mutate(country = factor(country, country)) %>%
  
  # prepare text for tooltip
  mutate(text = paste("Country: ", country, "\nPopulation (M): ", pop, "\nLife Expectancy: ", lifeExp, "\nGdp per capita: ", gdpPercap, sep="")) %>%
  
  # Classic ggplot
  ggplot( aes(x=gdpPercap, y=lifeExp, size = pop, color = continent, text=text)) +
  geom_point(alpha=0.7) +
  scale_size(range = c(1.4, 19), name="Population (M)") +
  scale_color_viridis(discrete=TRUE, guide=FALSE) +
  theme_ipsum() +
  theme(legend.position="none")

# turn ggplot interactive with plotly
pp <- ggplotly(p, tooltip="text")
pp

# save the widget
# library(htmlwidgets)
# saveWidget(pp, file=paste0( getwd(), "/HtmlWidget/ggplotlyBubblechart.html"))

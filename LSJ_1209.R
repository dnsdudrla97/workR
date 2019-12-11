#
# 작성자: 이소정
# 작성일: 2019-12-09
# 제출일: 2019-12-09
#

#문1)
#R에서 제공하는 mtcars 데이터셋에서 gear(기어의 수)에 대해 ggplot으로
#막대그래프를 작성하시오. 단, 제목과 x축 레이블은 ‘기어의 수’, y축 레이블
#은 ‘빈도수’로 나타내시오.

library(ggplot2)

ggplot(data=mtcars, mapping=aes(x=gear)) +
  geom_bar(fill="green") +
  ggtitle("기어의 수") +
  theme(plot.title=element_text(size=25, face="bold", colour="green")) +
  labs(x="기어의 수",y="빈도수")

# 방법2
# data 지정 방식에서 차이가 있다.
tmp <- table( mtcars$gear )
df <- data.frame( tmp )
df

ggplot( df, aes( x = Var1, y = Freq ) ) + 
  geom_bar( stat = "identity", width = 0.7, fill = "steelblue" ) +           # stat = "identity" -> 빈도수 만큼 출력하여라.
  ggtitle( "기어의 수" ) + 
  theme( plot.title = element_text( size = 25, face = "bold", colour = "steelblue" ) ) +
  labs( x = "기어의수", y = "빈도수" ) 


# 문2)
#R에서 제공하는 mtcars 데이터셋에서 cyl(실린더의 수)에 대해 막대 색이
#초록색인 막대그래프를 ggplot으로 작성하시오.

ggplot(data=mtcars, mapping=aes(x=cyl)) +
  geom_bar(fill="green") +
  labs(x="실린더의 수")

# 방법 2
# stat= 'identity'를 사용하려면 y함수도 지정해야함
tmp <- table( mtcars$cyl )
df <- data.frame( tmp )
df
ggplot( df, aes( x = Var1,y = Freq ) ) + 
  geom_bar( stat = "identity", width = 0.7, fill = "green" ) +
  ggtitle( "실린더 수" ) + 
  theme( plot.title = element_text( size = 25, face = "bold", colour = "steelblue" ) ) +
  labs( x = "실린더수", y = "빈도수" )


# 문3)
#R에서 제공하는 mtcars 데이터셋에서 mpg(연비)에 대해 구간 간격이 5.0
#인 히스토그램을 ggplot으로 작성하시오.

ggplot(data=mtcars,mapping=aes(x=mpg)) +
  geom_histogram(binwidth = 5.0) +
  labs(x="연비")

# 문4)
#R에서 제공하는 trees 데이터셋의 Girth(나무 둘레)에 대해 ggplot으로
#히스토그램을 작성하시오. 여기에서는 히스토그램의 제목, x축 레이블, y축
#레이블을 한글로 표시하시오. (구간 간격은 3.0, 막대의 색은 steelblue로 한다.)
ggplot(data=trees,mapping=aes(x=Girth)) +
  geom_histogram(binwidth = 3.0, fill="steelblue") +
  labs(x="나무의 둘레",y="개수")

# 문5)
#R에서 제공하는 mtcars 데이터셋에서 mpg(연비)를 x축으로 하고, wt(중
#량)를 y축으로 하는 산점도를 ggplot으로 작성하시오. (단, 점의 색은 gear의
#수에 따라 다르게 표시한다.)
str(mtcars)
gr <- as.factor(mtcars$gear)
ggplot(data=mtcars, mapping=aes(x=mpg,y=wt,color=gr)) +
  geom_point(size=3) +
  labs(x="연비", y="중량")

# 문6)
#R에서 제공하는 mtcars 데이터셋에서 mpg(연비)에 대해 ggplot으로 상
#자그림을 작성하되, cyl(실린더 수)에 따라 그룹을 나누어 작성하시오.
str(mtcars)
cyl_s <- as.factor(mtcars$cyl)
ggplot(data = mtcars, mapping = aes(y=mpg, fill=cyl_s)) +
  geom_boxplot()

# 방법2
ggplot( data = mtcars, aes( y = mpg, fill = factor( mtcars$cyl ) ) ) +
  geom_boxplot() +
  guides( fill = guide_legend( title = "실린더수" ) )

# 문7)
#다음은 2015년부터 2026년도까지의 예상 인구수 추계 자료이다. 연도를
#x축으로 하여 ggplot으로 선그래프를 작성하시오.
year <- 2015:2026
Population <- c(51014,51245,51446,51635,51811,51973,52123,52261,52388,52504,52609,52704)
df <- data.frame(year,Population)
df
ggplot(data=df,mapping=aes(x=year,y=Population)) +
  geom_line(col="blue")

# 문8)
#다음과 같이 데이터셋 us를 생성한 후 물음에 답하시오. 여기서 state.x77
#은 미국 50개 주의 통계정보가, state.division은 미국 50개 주의 지역 구분
#(예: 북부, 중부, 남부……) 정보가 저장된 데이터셋이다.
#
us <- data.frame(state.x77, state.division)
us <- data.frame(us,usname=rownames(us))
head(us)
dim(us)
str(us)
head(us)
View(us)
library(treemap)
#
#(1) 미국 50개 주에 대해 각각의 주들이 지역구분별로 묶인 트리맵을 작성하시오.
#또한, 타일의 면적은 Population(인구수), 타일의 색은 Income(소득)으로 나타내고,
#각각의 타일에는 주의 이름을 표시하시오. 마지막으로 이 트리맵에서 관찰할 수 있
#는 것이 무엇인지 설명하시오.
treemap(us,
        index = c("state.division","usname"),
        vSize="Population",
        vColor="Income",
        type="value")
# 비교적 수입이 높은 지역으로는 East North Central, Middle Atlantic, Pacific등이 있는 것으로 확인
# 비교적 수입이 낮은 지역으로는 West South Central, East South Central등으로 확인

#(2) 미국 50개 주에 대해 각각의 주들이 지역구분별로 묶인 트리맵을 작성하시오.
#또한, 타일의 면적은 HS.Grad(고등학교 졸업률), 타일의 색은 Murder(범죄률)로 나타
#내고, 각각의 타일에는 주의 이름을 표시하시오. 마지막으로 이 트리맵에서 관찰할
#수 있는 것이 무엇인지 설명하시오.
treemap(us,
        index = c("state.division","usname"),
        vSize="HS.Grad",
        vColor="Murder",
        type="value")
# 가장 범죄율이 높은것은 East South Central 중 Alabama인 것으로 보임
# 비교적 범죄율이 낮은 지역으로는 New England, West North Central인 것으로 보임

#(3) us 데이터셋에 대해 x축은 Income(소득), y축은 Illiteracy(문맹률), 원의 크기는
#Population(인구수), 원의 색은 green(초록색), 원 내부에는 주의 이름을 표시한 버
#블차트를 작성하시오. 또한 이 버블차트에서 관찰할 수 있는 것이 무엇인지 설명하
#시오.
symbols(us$Income, us$Illiteracy,
        circles = us$Population,
        inches = 0.3,
        fg = "green",
        bg = "green",
        lwd = 1.5,
        xlab = "소득",
        ylab = "문맹률",
        main = "Income and Illiteracy")
text(us$Income, us$Illiteracy, 
     rownames(us), 
     cex=0.6)
# 문맹률이 소득과 비례하지 않는 것을 보인다.

#(4) us 데이터셋에 대해 x축은 Illiteracy(문맹률), y축은 Murder(범죄률), 원의 크기
#는 Area(면적), 원의 색은 green(초록색), 원 내부에는 주의 이름을 표시한 버블차트
#를 작성하시오. 또한 이 버블차트에서 관찰할 수 있는 것이 무엇인지 설명하시오.
symbols(us$Illiteracy, us$Murder,
        circles = us$Area,
        inches = 0.3,
        fg = "green",
        bg = "green",
        lwd = 1.5,
        xlab = "문맹률",
        ylab = "범죄률",
        main = "Illiteracy and Murder")
text(us$Illiteracy, us$Murder,
     rownames(us), 
     cex=0.6)
# 문맹률이 낮은 곳에서 보다 높은 곳에서 범죄의 비율이 더 높은 것을 확인 할 수 있다.

# 제출자 : 이소정
# 작성일 : 2019-12-04
# 제출일 : 2019-12-05
#
# 문1)

ds <- state.x77
ds[2,3] <- NA; ds[3,1] <- NA; ds[2,4] <- NA; ds[4,3] <- NA

#.1

# apply함수 사용
na_count <- apply(ds,2,function(y) sum(is.na(y)))
na_count

# for문 사용
for ( i in 1:ncol( ds ) ) {
  cat( 'column [ ', i, ' ] : ', sum( is.na( ds[ , i ] ) ), '\n' )
}

#.2
ds[!complete.cases(ds), ] 

# 방법2
idx <- c()
for ( i in 1:nrow( ds ) ) {
  if ( sum( is.na( ds[ i, ] ) ) > 0 ) {
    idx <- c( idx, i )
  }
}
ds[ idx, ]

#.3
sum(rowSums(is.na(ds))>0)

# 방법2
cnt <- 0
for ( i in 1:nrow( ds ) ) {
  if ( sum( is.na( ds[ i, ] ) ) > 0 ) {
    cnt <- cnt + 1
  }
}
cnt

#.4
ds.new <- ds[complete.cases(ds), ] 
head(ds.new)

# 방법2
idx <- c()
for ( i in 1:nrow( ds ) ) {
  if ( sum( is.na( ds[ i, ] ) ) > 0 ) {
    idx <- c( idx, i )
  }
}
ds.new <- ds[ -idx, ]
ds.new

# 문2)

st <- data.frame(state.x77)

#.1

par(mfrow=c(2,4))
for (i in 1:ncol(st)) {
  boxplot(st[,i],main=colnames(st)[i])
}
par(mfrow=c(1,1))
# Population, Income, Area는 특이값 존재
boxplot.stats(st)$out

#.2
for (i in 1:ncol(st)) {
  out.val <- boxplot.stats(st[,i])$out
  if(length(out.val)>0) {
    st[,i][st[,i] %in% out.val] <- NA
  }
}
sum(is.na(st))

#.3
st2 <- st[complete.cases(st),]
sum(is.na(st2))
boxplot(st2)

# 문3)

#.1
AQ <- airquality

#.2
na_count <- apply(AQ, 2, function(st) sum(is.na(st)))
na_count

#.3
sum(rowSums(is.na(AQ))>0) 

#.4
AQ[complete.cases(AQ),]

#.5

AQ$Ozone[is.na(AQ$Ozone)] <- mean(AQ[,1],na.rm = TRUE)
AQ$Solar.R[is.na(AQ$Solar.R)] <- mean(AQ[,2],na.rm = TRUE)
AQ[,1]
AQ[,2]
AQ2 <- AQ
AQ2

# 방법2
colmean <- colMeans( AQ, na.rm = T )
colmean

AQ2 <- AQ
for ( i in 1:ncol( AQ2 ) ) {
  AQ2[ is.na( AQ2[ , i ] ), i ] <- colmean[ i ]
}
AQ2

# 문4)

library(dplyr)
st <- data.frame(state.x77)

#.1
st %>% arrange(Population)

# order사용
state.x77[ order( state.x77[ , 'Population' ] ) ]

#.2
st %>% arrange(desc(Income))

# order사용
state.x77[ order( state.x77[ , 'Income' ], decreasing = T ), ]

#.3
st %>% 
  mutate(city = rownames(st)) %>% 
  select(city,Illiteracy) %>% 
  arrange(Illiteracy) %>%  
  head(10)

# 방법2
tmp <- state.x77[ order( state.x77[ , 'Illiteracy' ] ), ]
tmp[ 1:10, 'Illiteracy' ]

# 문5)

#.1
mt.gear <- split(mtcars,mtcars$gear); mt.gear

#.2
mt.gear$`4`

#.3
library(ggplot2)
mt.gear.35 <- bind_rows(mt.gear$`3`,mt.gear$`5`)
mt.gear.35

# 방법2
mt.gear.35 <- rbind( mt.gear$'3', mt.gear$'5' )      # Matirx  할 때 사용했던 함수
mt.gear.35 

#.4
library(dplyr)
mtcars %>% filter(wt>1.5&wt<3.0)

# 방법2
subset( mtcars, wt >= 1.5 & wt < 3.0 )

# 문6)

authors <- data.frame( surname = c( "Twein", "Venables", "Tierney", "Ripley", "McNeil" ),
                       nationality = c( "US", "Australia", "US", "UK", "Australia" ),
                       retired = c( "yes", rep( "no", 4 ) ) )
books <- data.frame( name = c( "Johns", "Venables", "Tierney", "Ripley", "Ripley", "McNeil" ),
                     title = c( "Exploratory Data Analysis", 
                                "Modern Applied Statistics ...",
                                "LISP-STAT",
                                "Spatial Statistics", "Stochastic Simulation",
                                "Interactive Data Analysis" ),
                     other.author = c( NA, "Ripley", NA, NA, NA, NA ) )

authors <- rename(authors, name=surname)


#.1
in_j <- inner_join(authors,books,by='name'); in_j

# 방법2
merge( authors, books, by.x = c( 'surname' ), by.y = c( 'name' ) )

#.2
l_j1 <- left_join(authors,books,by='name'); l_j1

# 방법2
merge( authors, books, by.x = c( 'surname' ), by.y = c( 'name' ), all.x = T )

#.3
l_j2 <- left_join(books,authors,by='name'); l_j2

# 방법2
merge( authors, books, by.x = c( 'surname' ), by.y = c( 'name' ), all.y = T )

#.4
f_j <- full_join(authors,books,by='name'); f_j

# 방법2
merge( authors, books, by.x = c( 'surname' ), by.y = c( 'other.author' ) )

#
# mylib.R
#
# 최댓값 구하는 함수
my_max <- function( x, y ) {       # 함수 정의
num.max <- x
if( y > num.max ) {
  num.max <-  y
}
return( num.max )
}


# 나눗샘 함수
my_div <- function( x, y = 2 ) {           # y=2 -> y의 기본값은 2, y값이 안들어오면 기본값으로
  result <- x / y
  
  return ( result )
}
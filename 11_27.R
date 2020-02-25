#
# R 프로그래밍 1일차
#
# first.R
#
# 작성자: 이소정
#
# 최초작성일: 2019.11.26
#
#
print("Hello, World!!")

##2019-11-27

number <- 10 #왼쪽 alt를 누르면서 -하면 <- 자동　생성
number2 = 100

number3 <-  number

#R은 대소문자 구분
numberValue <-  1         # camel 표기법
str_Value<-"R Language"   # sanke 표기법
booleanvalue <- TRUE

numberValue <- "R script"
numberValue <- 1

#읽기기능1 - 변수명이 바뀌지 않으면
print(numberValue)
print(str_Value)
print(booleanvalue)
#읽기기능2
cat("Numeric number : ",numberValue,"\n")
cat("String : ",str_Value,"\n")
cat("Boolean Value : ",booleanvalue,"\n")
#쓰기기능 - 변수명이 바뀌면
numberValue<-scan()
cat("Numeric number : ",numberValue,"\n")

#교재 42-44

#산술연산 => 결과가 숫자
number1 <-  10
number2 <-  20
resultAdd <- number1 + number2
resultSub <- number1 - number2
resultMul <- number1 * number2
resultDiv <- number1 / number2
resultRem <- number2 %% number1 #나머지
resultSec <- number2 ** 5 #거듭제곱 -> ^ or **

print(resultAdd)
print(resultSub)
print(resultMul)
print(resultDiv)
print(resultRem)
print(resultSec)

#연산우선순위
 #누적
number1 <- 0
number1 <- number1 + 10
number1
number1 <- number1 + 10
number1
number1 <- number1 + 10
number1
 #치환
number2 <-  100
number1 <-  number2 + 10
number1
number2

#연산 결합 방향
print( number1 + 10 * number2 / 2)

#runtime error
number300 <- number300 + 10
number300
#누적을 할 때 주의점
#반드시 초기값 설정이 되어있어야함.

#수정
number300 <- 10
number300 <- number300 + 10
number300

#치환은 초기값이 필요 없다.
number301 <- number300 + 2
number301

#관계연산 =>결과는 논리형
number1 <-  10.5
number2 <-  10
print(number1 > number2)
print(number1 >= number2)
print(number1 < number2)
print(number1 <= number2)
print(number1 == number2)
print(number1 != number2)

#논리연산
print(number1 > 10 & number2 > 10) #AND
print(number1 > 10 | number2 > 10) #OR
print( !(number1 > 10) )           #NOT

#숫자 + 문자 연산은 불가능
#R에서는 산술연산은 숫자끼리만 가능하다.
number <-  100 # "100" 로 바꿔도 안된다.
str <-  "R lanuage"
result = number + str
print(result)

# 교재 p. 113

#
# 제어구조 - 선택구조
#

#양자택일구조
job.type <-  'A'

if ( job.type == 'B'){
  bonus <-  200             #참 일때
}  else {
    bonus <-  100           #거짓 일때
}
cat( "job type : ",job.type, "\t\tbonus : ",bonus)

#단일구조
job.type <- 'B'

if( job.type == 'A' ){
  bonus <- 200
}
cat( "job type : ",job.type, "\t\tbonus : ",bonus)

#다중선택구조

score <- 85

if ( score >= 90 ){
  grade <-  'A'
} else if ( score >=80 ){
  grade <- 'B'
} else if ( score >=70 ){
  grade <-'C'
} else if ( score >=60){
  grade <- 'D'
} else{
  grade <- 'F'
}
cat( "score : ",score, "\t\tgrade : ",grade)

##문제
number <-  15
#number 15는 홀수이다. => 출력

if ( number%%2 == 0 ){
  fin <- "짝수"
} else{
  fin <- "홀수"
}
cat( "number : ",number,"는", fin, "이다.")

#결과
#remider <- number %% 2
#즉 변수를 사용하는 방법도 있음

#0이 어느곳에도 포함되지 않게하기 - 응용1
num <- scan()
if ( num == 0){
   re1 <- "짝수도 홀수도 아니다."
} else if (num %% 2 == 0){
  re1 <- "짝수이다."
} else{
  re1 <- "홀수이다."
}
cat("num : ",num, "은",re1)

#a <- 10
#a <- 4
a <- 5
b <- 20

if ( a > 5 & b > 5) {
  cat( a, " > 5 and ", b, " > 5 ")
} else{                             #else를 한칸 띄어쓰면 error
  cat( a, " <= 5 or ", b, " <= 5 ")
}

a <- 10
b <- 20

if ( a > b ) {
  c <- a
} else {
  c <- b
}
cat("a = ",a,"\tb = ",b,"\tc = ",c)

c <- ifelse ( a > b, a, b)          #ifelse(test, yes, no)
cat("a = ",a,"\tb = ",b,"\tc = ",c)

#문제2
a <- 10
b <- 30
c <- 20
#제일 큰 수를 max,에 저장후 max를 출력

#내가 푼 방법
if( a > b){
  if( a > c){
    max <- a
  } else{
    max <- c
  }
} else if( a < b){
  if( b > c){
    max <- b
  } else{
    max <- c
  }
}
cat("a = ", a, "\tb = ", b, "\tc = ", c,"\tmax = ", max)  

#선생님 방법
max <- a
if( b > max) {
  max <- b
}
if( c > max) {
  max <- c
}
cat("a = ", a, "\tb = ", b, "\tc = ", c,"\tmax = ", max)  

#
# 반복 (for문, while문)
#
# for문 -> 범위가 명확할 때
for ( i in 1:10 ) {
  print( '*' )
}

multiple = 2
for ( i in 2:9 ) {
  cat( multiple, ' x ', i, ' = ', multiple * i, '\n')
}
  
# while문 -> 범위가 명확하지 않을 때
i <- 1         #i는 반복제어변수
while ( i <= 10 ) {      #조건이 참인 변수만 반복
  print( i )
  i <- i + 1
}

multiple <- 2
i <- 2
while ( i <= 9 ) {
  cat(multiple, 'X', i, ' = ', multiple * i, '\n' )
  i <- i+1
}

#문제
#1~100까지 한 줄에 10개씩 출력

# 1.
for(i in 1:100){
  cat( i, '\t' )
  if( i %% 10 == 0){
    cat( '\n' )
  }
}
  
# 2.
lineCount <- 1                   # 초기화
for( i in 1:100) {
  cat (i, '\t')
  lineCount <- lineCount + 1
  if( lineCount > 10 ) {
    cat('\n')
    lineCount <-  1              # Reset
  }
}

# 교재 p. 115-124

# 과제









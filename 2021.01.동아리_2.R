# facet_wrap : 화면을 자름
# facet_grid : 표 형식으로 나옴
  # 두 변수의 범위를 각각 정해 줄 수 있음

#Data transformation

install.packages("nycflights13")
  #-> 뉴욕의 비행기
library(nycflights13)
library(tidyverse)
install.packages('egg')
library(egg) #그래프를 한번에 보여줄 수 있음

View(flights)

jan1<- flights %>% 
  filter(month == 1 & day == 1)

dec25 <- flights %>% 
  filter(month == 12 & day == 25)

ggjan1 <- ggplot(data = jan1,
       aes(x = dep_delay))+
  geom_histogram()

ggdec25 <- ggplot(data = dec25,
       aes(x = dep_delay))+
  geom_histogram()

apr1 <- flights %>% 
  filter(month == 4 & day == 1)

ggapr1<- ggplot(data = apr1,
       aes(x = dep_delay))+
  geom_histogram()

  #그래프 3개 한번에 보기
ggarrange(ggjan1,
         ggdec25,
         ggapr1)

#히스토그램으로 그리면 이상치의 값을 확인하기 힘듦
#-> 박스플롯을 그리면 더 낫다.
#히스토그램으로 먼저 파악하고 그래프를 그리자

jandecapr <-  filter(flights,month %in% c(1,4,12))

#exercise

#1
flights %>% 
  filter(arr_delay >= 120,
         dep_delay <= 0)

#arrnage

flights %>% 
  arrange(-(arr_delay), -dep_delay)

  #문자일때는 알파벳 순
flights %>% 
  arrange(carrier)


#select

flights_date <- flights %>% 
  select(c(year, month, day))
  # = select(year : day)

flights %>% 
  select(-distance : -time_hour)

flights %>% 
  select(chulbalsigan = dep_time,
         yesansigan = sched_dep_time)

  #내가 보고 싶은 컬럼만 앞으로 땡기고 나머지는 그대로
flights %>% 
  select(dest, everything())

  #끝 혹은 시작 단어가 들어있는 컬럼들 추출
flights %>% 
  select(ends_with('delay'))

flights %>% 
  select(starts_with('arr'))

flights %>% 
  select(starts_with('sched'))

#mutate : 변수 생성
flights_small <- select(flights,
                        year:day,
                        ends_with('delay'),
                        distance,
                        air_time)

flights_small %>% 
  mutate(gain = dep_delay - arr_delay,
         speed = distance / air_time)

#exercise
#1

flights %>% 
  mutate(air_time2 = arr_time - dep_time) %>% 
  select(c(air_time2, air_time))
  #air_time은 하늘에 뜬 시간이고 air_time2는 비행기가 나온 시간

#+
flights_small%>% 
  mutate(ind = ifelse((arr_delay - dep_delay) < 0,'FALSE',
                      ifelse((arr_delay = dep_delay) > 0, 'TRUE',
                             'same'))) %>% 
  filter(ind)

flights_small %>% 
  mutate(ind = arr_delay > dep_delay) %>% 
  filter(ind)

#flights_small %>% 
# filter(arr_delay > dep_delay)
  #filter는 항상 TRUE 값만 나옴
  #만약 TRUE가 아닌 값을 추출하고 싶다면 filter(!(변수))
  

#Exercise-1

View(flights)
?flights
#1-1
flights %>% 
  filter(arr_delay >= 120)

#1-2
flights %>% 
  filter(dest == 'IAH' | dest == 'HOU')

#1-3
flights %>% 
  filter(carrier == 'UA' | carrier == 'AA' | carrier == 'DL')

#1-4
flights %>% 
  filter(month == 7|month == 8 | month == 9)

#1-5
flights %>% 
  filter(arr_delay <= 120 & dep_delay <= 0)

#1-6
flights %>% 
  filter(dep_delay >= 60 & air_time >= 30)

#1-7
flightstime<- flights %>% 
  filter(dep_time ==2400 | dep_time <= 0600)

#2

#3
flights %>% 
  filter(is.na(dep_time))

#4

#Exercise-2

#1

#2
flightsdep<- flights %>% 
  arrange(desc(dep_delay))

#3
flights %>% 
  arrange(arr_time)

#4
flights %>% 
  arrange(desc(distance))
flights %>% 
  arrange(distance)

#Execise-3

#1
flights %>% 
  select(c(dep_time,dep_delay,arr_time,arr_delay))

#2
#선택한 여러 변수들이 나옴

#3
vars <- c('year','month','day','dep_delay','arr_delay')

 
flights %>% 
  select(any_of(vars))

#4
flights %>% 
  select(contains('TIME'))

#Exercise-4

#1

#2
#dep_time, sched_dep_time,dep_delay
#->dep_time = sched_dep_time + dep_delay

#3
1:3 + 1:10
#객체가 배수관계일때만 위의 식이 가능함

#4
#삼각함수


#Exercise-5

#1
flights %>% 
  group_by(carrier,dest) %>% 
  summarise(n())

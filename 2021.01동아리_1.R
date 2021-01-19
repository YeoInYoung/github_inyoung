print("aaa")
library(tidyverse)
install.packages(c("nycflights","Lahman","gapminer"))
install.packages("maps")

data(mpg)

ggplot(data = mpg)+
  geom_point(aes(x = displ,
                 y = hwy,
                 color = class))+
  facet_wrap(~class,
             nrow = 2)

ggplot(data = mpg) +
  geom_point(aes(x = displ,
                 y = hwy,
                 color = class))+
  geom_smooth()
#error : 해결방법은 geom_point(aes)이하를 ggplot안으로 이동

ggplot(mpg,aes(x = displ,
               y = hwy))+
  geom_point()+
  geom_smooth(method = "lm")

#diamonds
#100프로를 전체로 잡고 각각의 비율을 볼 수 있음
ggplot(data = diamonds,
       aes(x = cut))+
  geom_bar(aes(fill = clarity),
           position = "fill")
#but 각각 안에서의 비율은 볼 수 있지만 전체적인 것은 비교 x

ggplot(data = diamonds,
       aes(x = cut))+
  geom_bar(aes(fill = clarity),
           position = "dodge")

#지도 그리기

nz <- map_data("nz")

ggplot(nz, aes(x = long,y = lat,group = group))+
  geom_polygon(fill = "White", colour = "black")


#3.2.4 exercises
#1 Run ggpot(data = mpg). What do you see?

ggplot(data = mpg)
#-> 하얀 화면

#2 How many rows are in mpg? How many columns?
View(mpg)
#-> rows = 234, columns = 11

#3 What does the drv variable describe? Read the help for mpg to find out
?mpg
#-> the type of drive train, where f = front-wheel drive, r = rear wheel drive, 4 = 4wd

#4 Make a scatterplot of hwy vs cyl
ggplot(data = mpg,
       aes(x = hwy,
           y = cyl))+
  geom_point()

# 5 What happens if you make a scatterplot of class vs drv? why is the plot not useful?
ggplot(data = mpg,
       aes(x = class,
           y = drv))+
  geom_point()
#-> 두개 모두 범주형 변수이기 때문에 데이터가 퍼져있는지를 보는 산점도로는 시각화가 유용하지 않다.


#3.3.1 exxercises

#1 What's gone wrong with this code? Why are the points not blue?
# ggplot(data = mpg)+
#    geom_point(mapping = aes(x = displ,
#                             y = hwy,
#                             color = "blue"))
ggplot(data = mpg,
       aes(x = displ,
           y = hwy))+
  geom_point(color = "blue")
#그래프의 색을 바꾸려면 aes밖에 color를 써줘야 함

#2 mpg의 어느 변수가 범주형, 연속형?
?mpg
#범주형 : manufacturer,model,trans,drv,fl,class
#연속형 : displ, year, cyl, cty, hwy

#3 연속형 변수 하나를 color, size, shape로 매핑하라. 이러한 심미성
#은 범주형, 연속형 변수에 따라 어떻게 다르게 작동하는가?
ggplot(data = mpg,
       aes(x = displ,
           y = hwy))+
  geom_point(color = "red", size = 2, shape = 17)
#범주형 변수를 색, 크기, 모양 별로 나눌때는 aes괄호 안에 들어가야하고
#연속형 변수를 바꿀때는 aes괄호 밖에서 바꿔줘야한다.

#4 하나의 변수를 여러 심미성에 매핑하면 어떻게 되는가?

#5 stroke 심미성의 역할은? 어떤 모양과 함께 작동하는가?
ggplot(data = mpg,
       aes(x = displ,
           y = hwy))+
  geom_point(color = 'purple', size = 3, shape = 16)

#stroke는 점그래프를 그리는 도형의 테두리 선의 굵기를 정하는 것이다.
#stroke는 테투리로 이루어진 도형(0~14), 혹은 안을 채울 수 있는 도형(21~25)
#까지 작용하고 애초에 테두리가 없는 도형(15~20)은 stroke를 사용하여도 
#크기를 키우는 것과 같은 효과이다.

#6 aes(color = displ<5)처럼 심미성을 변수 이름이 아닌 다른 것에 매핑하면 어떻게 되는가?

ggplot(data = mpg,
       aes(x = displ,
           y = hwy))+
  geom_point(aes(color = displ<5))
#연속형 변수인 displ이 5보다 작은 것과 큰 것으로 색이 나뉘어진다.


#1.5.1 연습문제

#1 연속형 변수로 화면분할하면 어떻게 되는가
ggplot(data = mpg)+
  geom_point(aes(x = displ,
                 y = hwy,
                 color = class))+
  facet_wrap(~displ)

#2 
ggplot(data = mpg)+
  geom_point(aes(x = drv, y = cyl))+
  facet_grid(drv ~ cyl)
#빗 플롯은 해당되는 값이 없는 것이다.

#3
ggplot(data = mpg)+
  geom_point(aes(x = displ,
                 y = hwy))+
  facet_grid(drv~.)

ggplot(data = mpg)+
  geom_point(aes(x = displ,
                 y = hwy))+
  facet_grid(.~cyl)

#.은 가로 혹은 세로로 화면 분할을 하고 싶을 때
#(.~x)는 가로, (x~.)는 세로이다.

#4
ggplot(data = mpg)+
  geom_point(aes(x = displ,
                 y = hwy))+
  facet_wrap(~class, nrow = 2)
#->심미성을 쓰지 않는 다면 빠르게 파악할 수 있지만
#다른 많은 정보까지 파악하기엔는 힘들다

#5
?facet_wrap

#6


#1.6.1

#1 geom_line, geom_boxplot, geom_histogram

#2
ggplot(data = mpg,
       aes(x = displ,
           y = hwy,
           color = drv))+
  geom_point()+
  geom_smooth(se = FALSE)

#3
ggplot(data = mpg)+
  geom_smooth(aes(x = displ,
              y = hwy,
              color = drv),
              show.legend = FALSE)
#show.legend는 오른쪽에 변수별 색, 모양등을 나타내주는 것을 없애주는 것이다.

#4 표준오차를 나타내고 싶지 않을 때 se = FALSE를 사용

#5
ggplot(data = mpg,
       aes(x = displ,
           y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg,
             aes(x = displ,
                 y = hwy)) + 
  geom_smooth(data = mpg,
              aes(x = displ,
                  y = hwy))

#->두그래프는 같다. 위의 그래프는 x,y를 미리 지정해놓는 것이고,
#밑의 그래프는 각각 x,y를 지정해 주는 것인데 모두 같으므로 두 그래프는 같게 나온다.

#1.7.1

#1. stat_summary()는 geom_boxplot과 같다.

#2 geom_col은 평규을 사용해서 만드는 막대 그래프,
#geom_bar는 빈도를 보는 막대그래프

#3

#4 stat_smooth는 회귀선을 그림, y변수를 계산

#5
data("diamonds")

ggplot(data = diamonds)+
  geom_bar(aes(x = cut,
               y = ..prop..,
               group = group))
#group을 쓰지 않는다면 각 x별 백분율이 나오고
#group을 쓴다면 전체의 백분율에서 각 변수별 비율이 나온다.



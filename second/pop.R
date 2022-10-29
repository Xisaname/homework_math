library(ggplot2)
library(ggprism)
library(scales)
data <- read.csv("SexComposition.csv", encoding="UTF-8")
area<-data[,1]
MR<-data[,3]
FR<-data[,4]
pop=c(MR,FR)
datanew=data.frame(area,pop)
colnames(datanew) = c('地区','pop')
group = c(rep('male',31),rep('female',31))
datanew$MF=rep(group,1)
p<-ggplot(datanew, aes(x=地区,y=pop,fill=MF))+
    labs(title="中国各省市性别比",subtitle="无台湾数据",caption = "2020年数据")+
    theme_prism(axis_text_angle = 45,
                base_size=8,
                base_line_size=0.8)+
    geom_bar(stat='identity',position='dodge')+
    ggtitle("中国各省性别比")+
    labs(x="地区",y="人数/万")
ggsave("pop.png",p)
show_col(rainbow(10),labels=T)
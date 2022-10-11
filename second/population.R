library(ggplot2)
library(ggprism)
data <- read.csv("SexComposition.csv", encoding="UTF-8")
area<-data[,1]
MR<-data[,5]
FR<-data[,6]
percent=c(MR,FR)
datanew=data.frame(area,percent)
colnames(datanew) = c('地区','percent')
group = c(rep('male',31),rep('female',31))
datanew$MF=rep(group,1)
datanew
p<-ggplot(datanew, aes(x=地区,weight=percent,fill=MF))+
    theme_prism(axis_text_angle = 45,
                base_size=8,
                base_line_size=0.8)+
    geom_bar(position="stack")+
    ggtitle("中国各省性别比")+
    labs(x="地区",y="比例")+
    geom_hline(aes(yintercept=0.5),colour="#990000",linetype="dashed")
ggsave("test.png",p)
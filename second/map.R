library(geojsonsf)
library(sf)
library(ggplot2)
library(RColorBrewer)

## 1.全国
China = st_read(dsn = paste0("quanguo.json"), 
                stringsAsFactors=FALSE) 
st_crs(China) = 4326

# 2.国境线
China_line = st_read(dsn = paste0("quanguo_Line.geojson"), 
                     stringsAsFactors=FALSE) 
st_crs(China_line) = 4326

gjx <- China_line[China_line$QUHUADAIMA == "guojiexian",]

# 3.读取省份地理中心

# 4.着色数据+全国地图
province <- read.csv("province.csv")
zhuose_data <- read.csv("your_data.csv")
SC <- read.csv("SexComposition.csv")
SC_NEW <- merge(SC,zhuose_data,by='地区')
print(SC_NEW)
head(zhuose_data)
SC_NEW$QUHUADAIMA <- as.character(SC_NEW$QUHUADAIMA) # 因China数据中QUHUADAIMA是chr类型
CHINA <- dplyr::left_join(China,SC_NEW,by= "QUHUADAIMA")

###----全国地图完整（无右下角小地图）----------###
p<-ggplot()+
  # 绘制主图
  geom_sf(data = CHINA,aes(fill = 性别比)) +
  scale_fill_gradient(low="#00FFFFFF",high="#FF9900FF")+

  # 绘制国境线及十/九段线
  geom_sf(data = gjx)+
  geom_text(data = province,aes(x=dili_Jd,y=dili_Wd,label=地区),
            position = "identity",size=3,check_overlap = TRUE) +
  labs(title="中国各省市性别比(男:女)",subtitle="无台湾数据",caption = "2020年数据")+
  theme(
    plot.title = element_text(color="red", size=16, face="bold",vjust = 0.1,hjust = 0.5),
    plot.subtitle = element_text(size=8,vjust = 0.1,hjust = 0.5),
    legend.title=element_blank(),
    legend.position = c(0.2,0.2),
    panel.grid=element_blank(),
    panel.background=element_blank(),
    axis.text=element_blank(),
    axis.ticks=element_blank(),
    axis.title=element_blank()
  )
ggsave("map.png",p)
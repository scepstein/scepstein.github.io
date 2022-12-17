#Distance from manhattan calculation

#Set standard of manhattan 
manhattan = subset(NYS, NAME == "New York")

#Compare distances in NYS
NYS$Manhattan_dist = c(0)
for (x in 1:length(NYS$NAME)){
    NYS$Manhattan_dist[x] = st_distance(manhattan, NYS[x,])[1,1]
}

PA$Manhattan_dist = c(0)
for (x in 1:length(PA$COUNTY_NAM)){
  PA$Manhattan_dist[x] = st_distance(manhattan, PA[x,])[1,1]
}

CT$Manhattan_dist = c(0)
for (x in 1:length(CT$NAME)){
  CT$Manhattan_dist[x] = st_distance(manhattan, CT[x,])[1,1]
}

CT$Zone = c(0)
CT$Zone[CT$Manhattan_dist<100000] = "< 100 km"
CT$Zone[CT$Manhattan_dist>100000] = "> 100 km"
test1 = subset(CT, Manhattan_dist < 100000)
test2 = subset(CT, Manhattan_dist > 100000)

library(ggplot2)
ggplot()+
  geom_point(data=CT, aes(x=Manhattan_dist, y=Blumenthal_v_Biden, color=Zone))+
  scale_color_manual(values=c("#f03b20", "#2c7fb8"))+
  theme_light()+
  xlab("Approximate Distance from Manhattan (m)")+
  ylab("Blumenthal (CT SEN) Performance Relative to Biden (%)")+
  ggtitle("CT Towns: Blumenthal Performance by Distance from Manhattan")+
  annotate("text", 50000, y = 0, color = "#f03b20", size = 6, label = paste("r = ", round(cor(test1$Manhattan_dist, test1$Blumenthal_v_Biden), 2), sep =""))+
  annotate("text", 150000, y = -12.5, color = "#2c7fb8", size = 6, label = paste("r = ", round(cor(test2$Manhattan_dist, test2$Blumenthal_v_Biden), 2), sep =""))+
  annotate("text", 100000, y = -15, color = "Black", size = 6, label = paste("r_total = ", round(cor(CT$Manhattan_dist, CT$Blumenthal_v_Biden), 2), sep =""))
filepath1 = " "
ggsave(filepath1, last_plot(), width = 8, height = 5, dpi = 600)


library(ggplot2)
ggplot()+
  geom_point(data=CT, aes(x=Manhattan_dist, y=Lamont_v_Biden, color=Zone))+
  scale_color_manual(values=c("#f03b20", "#2c7fb8"))+
  theme_light()+
  xlab("Approximate Distance from Manhattan (m)")+
  ylab("Lamont (CT GOV) Performance Relative to Biden (%)")+
  ggtitle("CT Towns: Lamont Performance by Distance from Manhattan")+
  annotate("text", 50000, y = 0, color = "#f03b20", size = 6, label = paste("r = ", round(cor(test1$Manhattan_dist, test1$Lamont_v_Biden), 2), sep =""))+
  annotate("text", 150000, y = -12.5, color = "#2c7fb8", size = 6, label = paste("r = ", round(cor(test2$Manhattan_dist, test2$Lamont_v_Biden), 2), sep =""))+
  annotate("text", 100000, y = -15, color = "Black", size = 6, label = paste("r_total = ", round(cor(CT$Manhattan_dist, CT$Lamont_v_Biden), 2), sep =""))
filepath1 = " "
ggsave(filepath1, last_plot(), width = 8, height = 5, dpi = 600)


ggplot()+
  geom_point(data=PA, aes(x=Manhattan_dist, y=Fetterman_v_Biden), color = "#2c7fb8")+
  theme_light()+
  xlab("Approximate Distance from Manhattan (m)")+
  ylab("Fetterman (PA SEN) Performance Relative to Biden (%)")+
  ggtitle("PA Counties: Fetterman Performance by Distance from Manhattan")+
  annotate("text", 300000, y = 11, color = "#2c7fb8", size = 6, label = paste("r = ", round(cor(PA$Manhattan_dist, PA$Fetterman_v_Biden), 2), sep =""))
filepath1 = " "
ggsave(filepath1, last_plot(), width = 8, height = 5, dpi = 600)


ggplot()+
  geom_point(data=PA, aes(x=Manhattan_dist, y=Shapiro_v_Biden), color = "#2c7fb8")+
  theme_light()+
  xlab("Approximate Distance from Manhattan (m)")+
  ylab("Shapiro (PA GOV) Performance Relative to Biden (%)")+
  ggtitle("PA Counties: Shapiro Performance by Distance from Manhattan")+
  annotate("text", 300000, y = 22, color = "#2c7fb8", size = 6, label = paste("r = ", round(cor(PA$Manhattan_dist, PA$Shapiro_v_Biden), 2), sep =""))
filepath1 = " "
ggsave(filepath1, last_plot(), width = 8, height = 5, dpi = 600)



ggplot()+
  geom_point(data=NYS, aes(x=Manhattan_dist, y=Schumer_v_Biden), color = "#f03b20")+
  theme_light()+
  xlab("Approximate Distance from Manhattan (m)")+
  ylab("Schumer (NY SEN) Performance Relative to Biden (%)")+
  ggtitle("NY Counties: Schumer Performance by Distance from Manhattan")+
  annotate("text", 250000, y = -11, color = "#f03b20", size = 6, label = paste("r = ", round(cor(NYS$Manhattan_dist, NYS$Schumer_v_Biden), 2), sep =""))
filepath1 = " "
ggsave(filepath1, last_plot(), width = 8, height = 5, dpi = 600)



ggplot()+
  geom_point(data=NYS, aes(x=Manhattan_dist, y=Hochul_v_Biden), color = "#f03b20")+
  theme_light()+
  xlab("Approximate Distance from Manhattan (m)")+
  ylab("Hochul (NY GOV) Performance Relative to Biden (%)")+
  ggtitle("NY Counties: Hochul Performance by Distance from Manhattan")+
  annotate("text", 250000, y = -22, color = "#f03b20", size = 6, label = paste("r = ", round(cor(NYS$Manhattan_dist, NYS$Hochul_v_Biden), 2), sep =""))
filepath1 = " "
ggsave(filepath1, last_plot(), width = 8, height = 5, dpi = 600)


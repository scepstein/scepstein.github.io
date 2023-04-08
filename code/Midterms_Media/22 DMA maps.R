#DMA Map 

#Simplify topology
NYunion = st_union(NYS)
NYS = st_simplify(NYS, preserveTopology = FALSE, dTolerance = 1000)
NYS = st_transform(NYS, "EPSG:4269")

#Remove extra markets
dma_mini = dma_mini[-c(4, 6, 10, 17), ]
dma_NYC = subset(dma_mini, NAME == "New York NY")

#Color schemes
NYS$SenatevBiden = NYS$Schumer_v_Biden
PA$SenatevBiden = PA$Fetterman_v_Biden
CT$SenatevBiden = CT$Blumenthal_v_Biden
NYS$GovernorvBiden = NYS$Hochul_v_Biden
PA$GovernorvBiden = PA$Shapiro_v_Biden
CT$GovernorvBiden = CT$Lamont_v_Biden

#Zoomed out DMA Map
library(ggplot2)
ggplot()+
  geom_sf(data=NYS, color="black", fill = "blue", alpha = 0.5)+
  geom_sf(data=PA,  color="black", fill = "red", alpha = 0.5)+
  geom_sf(data=CT, color="black", fill = "green", alpha = 0.5)+
  geom_sf(data=dma_mini, size = 1.5, color="black", alpha = 0)+
  geom_sf(data=dma_NYC, size = 1.5, color="purple", alpha = 0)+
  theme_light()+
  ggtitle("New York City Designated Market Area (DMA)")+
  labs(subtitle = "New York City media market is highlighted (purple). Rest in black.")

filepath1 = ""
ggsave(filepath1, last_plot(), width = 6, height = 6, dpi = 600)

#Zoomed out DMA Map
ggplot()+
  geom_sf(data=NYS, color="black", fill = "blue", alpha = 0.5)+
  geom_sf(data=PA,  color="black", fill = "red", alpha = 0.5)+
  geom_sf(data=CT, color="black", fill = "green", alpha = 0.5)+
  geom_sf(data=dma_mini, size = 1.5, color="black", alpha = 0)+
  geom_sf(data=dma_NYC, size = 1.5, color="purple", alpha = 0)+
  xlim(-76.5, -72)+
  ylim(39,42.5)+
  theme_light()
filepath1 = ""
ggsave(filepath1, last_plot(), width = 6, height = 6, dpi = 600)

#US Senate spread map
ggplot()+
  geom_sf(data=NYS, color="black", aes(fill = SenatevBiden), alpha = 0.5)+
  geom_sf(data=PA,  color="black", aes(fill = SenatevBiden), alpha = 0.5)+
  geom_sf(data=CT, color="black", aes(fill = SenatevBiden), alpha = 0.5)+
  scale_fill_gradient2(low = "red", mid = "white", high = "blue")+
  geom_sf(data=dma_mini, size = 1.5, color="black", alpha = 0)+
  geom_sf(data=dma_NYC, size = 1.5, color="purple", alpha = 0)+
  xlim(-76.5, -72)+
  ylim(39,42.5)+
  theme_light()+
  labs(fill = "Dem Sen. candidate \nperformance \nrelative to Biden (%)")+
  ggtitle("Dem Sen. candidates '22 vs. Biden '20")+
  labs(subtitle = "New York City media market is centered (purple)")
filepath1 = ""
ggsave(filepath1, last_plot(), width = 8, height = 6, dpi = 600)

#Governor spread map
ggplot()+
  geom_sf(data=NYS, color="black", aes(fill = GovernorvBiden), alpha = 0.5)+
  geom_sf(data=PA,  color="black", aes(fill = GovernorvBiden), alpha = 0.5)+
  geom_sf(data=CT, color="black", aes(fill = GovernorvBiden), alpha = 0.5)+
  scale_fill_gradient2(low = "red", mid = "white", high = "blue")+
  geom_sf(data=dma_mini, size = 1.5, color="black", alpha = 0)+
  geom_sf(data=dma_NYC, size = 1.5, color="purple", alpha = 0)+
  xlim(-76.5, -72)+
  ylim(39,42.5)+
  theme_light()+
  labs(fill = "Dem Gov. candidate \nperformance \nrelative to Biden (%)")+
  ggtitle("Dem Gov. candidates '22 vs. Biden '20")+
  labs(subtitle = "New York City media market is centered (purple)")
filepath1 = ""
ggsave(filepath1, last_plot(), width = 8, height = 6, dpi = 600)

#CT Box plots
CT = st_transform(CT, "EPSG:4269")
dma_NYC = st_transform(dma_NYC, "EPSG:4269")

CT$MediaMarket <- st_intersects(CT, dma_NYC) %>% lengths > 0
CT$MediaMarket[CT$MediaMarket==TRUE] = "New York City"
CT$MediaMarket[CT$MediaMarket==FALSE] = "Hartford and New Haven"
  
ggplot(data = CT, aes(x=MediaMarket, y=Blumenthal_v_Biden))+
  geom_boxplot(aes(fill = MediaMarket))+
  geom_jitter(position=position_jitter(0.1))+
  theme_light()+
  xlab("Media Market")+
  labs(fill = "Media Market")+
  ylab("U.S. Senate performance '22 relative to Biden '20 (%)")+
  ggtitle("Blumenthal (Senate) '22 vs. Biden '20")+
  labs(subtitle = "Distribution among CT towns based on media market.")
filepath1 = ""
ggsave(filepath1, last_plot(), width = 6, height = 6, dpi = 600)


ggplot(data = CT, aes(x=MediaMarket, y=Lamont_v_Biden))+
  geom_boxplot(aes(fill = MediaMarket))+
  geom_jitter(position=position_jitter(0.1))+
  theme_light()+
  xlab("Media Market")+
  labs(fill = "Media Market")+
  ylab("Gubernatorial performance '22 relative to Biden '20 (%)")+
  ggtitle("Lamont (Governor) '22 vs. Biden '20")+
  labs(subtitle = "Distribution among CT towns based on media market.")
filepath1 = ""
ggsave(filepath1, last_plot(), width = 6, height = 6, dpi = 600)


  

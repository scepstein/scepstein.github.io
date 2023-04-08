library(ggplot2)
ggplot()+
  geom_sf(data=NYS, aes(fill = Hochul_v_Biden))+
  scale_fill_gradient2(low = "red", mid = "white", high = "blue")+
  theme_void()+
  theme(legend.position = "none")
filepath1 = " "  
ggsave(filepath1, last_plot(), width = 6, height = 6, dpi = 600)

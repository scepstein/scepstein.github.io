schumercounties = subset(NYS, Schumer_v_Biden > 0)

NYS = st_transform(NYS, "EPSG:4269")

library(ggplot2)
main.plot = ggplot()+
  geom_sf(data=NYS, aes(fill = Schumer_v_Biden), size = 1.5)+
  scale_fill_gradient2(low = "red", mid = "white", high = "blue")+
  theme_light()+
  ggtitle("Schumer '22 vs. Biden '20 (Difference in percent of vote acquired)")+
  labs(subtitle = "Comparison of Schumer U.S. Senate results '22 to Biden presidential results '20.")+
  labs(caption = "Schumer underperformed Biden in all counties.")+
  labs(fill = "Schumer performance \nrelative to Biden (%)")+
  geom_sf(data=schumercounties, alpha = 0, size = 1.5, color = "blue")+
  theme(axis.text = element_text(size = 12))+
  theme(plot.title = element_text(size = 20))+
  theme(plot.caption = element_text(size = 14))+
  theme(plot.subtitle = element_text(size = 14))

inset.plot = ggplot()+
  geom_sf(data=NYS, aes(fill = Schumer_v_Biden), size = 1.5, show.legend = FALSE)+
  scale_fill_gradient2(low = "red", mid = "white", high = "blue")+
  theme_light()+
  theme(panel.grid.major = element_blank())+
  theme(axis.text = element_blank())+
  xlim(-74.3, -73.5) + ylim (40.5,41)+
  theme(plot.title = element_text(size = 12))+
  ggtitle("NYC metropolitan area")

library(cowplot)

final_plot = ggdraw() +
  draw_plot(main.plot) +
  draw_plot(inset.plot, x = 0.05, y = 0.11, width = 0.3, height = 0.25)

filepath1 = " "

#Troubleshoot at low resolution for fast turnaround
#ggsave(filepath1, final_plot, width = 9, height = 6, dpi = 60)

ggsave(filepath1, final_plot, width = 9, height = 6, dpi = 600)

rm(schumercounties)

#DONE

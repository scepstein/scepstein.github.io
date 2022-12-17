bidencounties = subset(PA, Fetterman_v_Biden < 0)

library(ggplot2)
ggplot()+
  geom_sf(data=PA, aes(fill = Fetterman_v_Biden), size = 1.5)+
  scale_fill_gradient2(low = "red", mid = "white", high = "blue")+
  xlim(-81.5, -74) + ylim(39.5,42.5)+
  theme_light()+
  ggtitle("Fetterman '22 vs. Biden '20 (Difference in percent of vote acquired)")+
  labs(subtitle = "Comparison of Fetterman U.S. Senate results '22 to Biden presidential results '20.")+
  labs(caption = "Counties where Fetterman underperformed Biden are outlined in red.")+
  labs(fill = "Fetterman performance \nrelative to Biden (%)")+
  geom_sf(data=bidencounties, alpha = 0, size = 1.5, color = "red")+
  theme(axis.text = element_text(size = 12))+
  theme(plot.title = element_text(size = 20))+
  theme(plot.caption = element_text(size = 14))+
  theme(plot.subtitle = element_text(size = 14))

rm(bidencounties)

filepath1 = " "

ggsave(filepath1, last_plot(), width = 12, height = 6, dpi = 600)

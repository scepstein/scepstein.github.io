library(ggplot2)
ggplot(data = yearbyyear)+
  geom_density(aes(x=TO18_19, color="2018-2019", fill="2018-2019", linetype = "2018-2019"), alpha = 0.1)+
  geom_density(aes(x=TO19_20, color="2019-2020", fill="2019-2020", linetype = "2019-2020"), alpha = 0.1)+
  geom_density(aes(x=TO20_21, color="2020-2021", fill="2020-2021", linetype = "2020-2021"), alpha = 0.1)+
  geom_density(aes(x=TO21_22, color = "2021-2022", fill="2021-2022", linetype = "2021-2022"), alpha = 0.3)+
  scale_color_manual(name='Time Span',
                     breaks=c('2018-2019', '2019-2020', '2020-2021', '2021-2022'),
                     values=c('2018-2019'='red', '2019-2020'='red', '2020-2021'='red', "2021-2022"="blue"))+
  scale_fill_manual(name='Time Span',
                     breaks=c('2018-2019', '2019-2020', '2020-2021', '2021-2022'),
                     values=c('2018-2019'='red', '2019-2020'='red', '2020-2021'='red', "2021-2022"="blue"))+
  scale_linetype_manual(name='Time Span',
                    breaks=c('2018-2019', '2019-2020', '2020-2021', '2021-2022'),
                    values=c('2018-2019'='solid', '2019-2020'='dashed', '2020-2021'='dotted', "2021-2022"="solid"))+
  geom_vline(xintercept=0)+
  theme(legend.spacing.y = unit(0.33, 'cm'))+
  guides(color = guide_legend(byrow = TRUE))+
  guides(fill = guide_legend(byrow = TRUE))+
  guides(linetype = guide_legend(byrow = TRUE))+
  xlab("Percent Change in Price Over Time")+
  ylab("Density")+
  theme_bw()

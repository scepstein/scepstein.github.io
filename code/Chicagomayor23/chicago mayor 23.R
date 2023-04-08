#Set Working Directory
# Get the directory path of the current script
library(rstudioapi)
setwd(file.path(dirname(rstudioapi::getSourceEditorContext()$path)))

#Import Round 1 data
votes_r1 = read.csv("dataexport round1.csv", header = TRUE)

  #Re-format data
  votes_r1$Votes = gsub(",", "", votes_r1$Votes)
  votes_r1$Votes = as.numeric(votes_r1$Votes)
  votes_r1$JA.MAL.GREEN.p = votes_r1$JA.MAL.GREEN / votes_r1$Votes
  votes_r1$SOPHIA.KING.p = votes_r1$SOPHIA.KING / votes_r1$Votes
  votes_r1$KAM.BUCKNER.p = votes_r1$KAM.BUCKNER / votes_r1$Votes
  votes_r1$WILLIE.L..WILSON.p = votes_r1$WILLIE.L..WILSON / votes_r1$Votes
  votes_r1$BRANDON.JOHNSON.p = votes_r1$BRANDON.JOHNSON / votes_r1$Votes
  votes_r1$PAUL.VALLAS.p = votes_r1$PAUL.VALLAS / votes_r1$Votes
  votes_r1$LORI.E..LIGHTFOOT.p = votes_r1$LORI.E..LIGHTFOOT / votes_r1$Votes
  votes_r1$RODERICK.T..SAWYER.p = votes_r1$RODERICK.T..SAWYER / votes_r1$Votes
  votes_r1$JESUS..CHUY..GARCIA.p = votes_r1$JESUS..CHUY..GARCIA. / votes_r1$Votes

#Algorithm to calculate maximum vote-getter
votes_r1_dummy = subset(votes_r1, select = c(-1, -2, -3))
votes_r1$winner = c("")
for (x in 1:length(votes_r1$Votes)){
  votes_r1$winner[x] = colnames(votes_r1_dummy[x,])[which(votes_r1_dummy[x,] == max(votes_r1_dummy[x,]), arr.ind=TRUE)[2]]
}
rm(x, votes_r1_dummy)

#Creates a correlation matrix for all first round candidates 
matrix = data.frame(votes_r1$JA.MAL.GREEN.p, votes_r1$SOPHIA.KING.p, votes_r1$KAM.BUCKNER.p, votes_r1$WILLIE.L..WILSON.p, votes_r1$BRANDON.JOHNSON.p, votes_r1$PAUL.VALLAS.p, votes_r1$LORI.E..LIGHTFOOT.p, votes_r1$RODERICK.T..SAWYER.p, votes_r1$JESUS..CHUY..GARCIA.p)
colnames(matrix) = c("J.Green", "S.King", "K.Buckner", "W.Wilson", "B.Johnson", "P.Vallas", "L. Lightfoot", "R.Sawyer", "C.Garcia")
cor_matrix = cor(matrix)
library(ggcorrplot)
ggcorrplot(cor_matrix, type = "full", hc.order = TRUE, lab = FALSE)
rm(cor_matrix, matrix)

#Creates a correlation matrix for the top four first round candidates 
matrix = data.frame(votes_r1$JESUS..CHUY..GARCIA.p, votes_r1$LORI.E..LIGHTFOOT.p, votes_r1$BRANDON.JOHNSON.p, votes_r1$PAUL.VALLAS.p )
colnames(matrix) = c("C.Garcia", "L.Lightfoot", "B.Johnson", "P.Vallas")
cor_matrix = cor(matrix)
library(ggcorrplot)
ggcorrplot(cor_matrix, type = "upper", hc.order = FALSE, lab = TRUE)
rm(cor_matrix, matrix)
ggsave("round1matrix.png", last_plot(), width = 4, height = 4, dpi = 600)

#Creates a scatter plot of Vallas:Johnson constituencies 
my_palette <- c("#1f77b4", "#d62728", "#2ca02c", "#9467bd", "#ff7f0e", "#7f7f7f")

library(ggplot2)
ggplot() +
  geom_point(data=votes_r1, aes(x=PAUL.VALLAS.p, y=BRANDON.JOHNSON.p, color=winner)) +
  scale_color_manual(values = my_palette, 
                     breaks = c(unique(votes_r1$winner)[1], unique(votes_r1$winner)[6], unique(votes_r1$winner)[5], unique(votes_r1$winner)[3], unique(votes_r1$winner)[2], unique(votes_r1$winner)[4]),
                     labels = c("B.Johnson", "J.Green", "C.Garcia", "L.Lightfoot", "P.Vallas", "W.Wilson")) +
  geom_abline(slope = 1, intercept = 0) +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_rect(color = "grey", fill = NA, size = 1))+
  xlab("Paul Vallas vote share (% norm.)") +
  ylab("Brandon Johnson vote share (% norm.)") +
  ggtitle("Chicago Mayoral Election, Round I (Feb. 28, 2023)") +
  labs(color = "Precinct Winner") +
  annotate("text", x=0.45, y=0.48, angle = 37.5, label="Johnson preference")+
  annotate("text", x=0.47, y=0.45, angle = 37.5, label="Vallas preference")
ggsave("round1scatter.png", last_plot(), width = 9, height = 4.5, dpi = 600)

#Import Round 1 data
votes_r2 = read.csv("dataexport (1)_round2.csv", header = TRUE)

#Re-format data
  votes_r2$Votes = gsub(",", "", votes_r2$Votes)
  votes_r2$Votes = as.numeric(votes_r2$Votes)
  votes_r2 = subset(votes_r2, select = c(1,2,3,4,6))
  votes_r2$Vallas.p = votes_r2$PAUL.VALLAS / votes_r2$Votes
  votes_r2$Johnson.p = votes_r2$BRANDON.JOHNSON / votes_r2$Votes
  votes_r2$Turnout.ratio = votes_r2$Votes / votes_r1$Votes

#Combined datasets
library(dplyr)
  votes_all <- inner_join(votes_r1, votes_r2, by = c("Ward", "Precinct"))
  
#GGplot Vallas Round I (Feb. 28, 2023) vs. Runoff (Apr. 4, 2023)
ggplot() +
  geom_point(data=votes_all, aes(x=PAUL.VALLAS.p, y=Vallas.p, color=winner)) +
  scale_color_manual(values = my_palette, 
                     breaks = c(unique(votes_r1$winner)[1], unique(votes_r1$winner)[6], unique(votes_r1$winner)[5], unique(votes_r1$winner)[3], unique(votes_r1$winner)[2], unique(votes_r1$winner)[4]),
                     labels = c("B.Johnson", "J.Green", "C.Garcia", "L.Lightfoot", "P.Vallas", "W.Wilson")) +
  geom_abline(slope = 1, intercept = 0) +
  theme_minimal() +
  xlab("Paul Vallas vote share, Round I (% norm.)") +
  ylab("Paul Vallas vote share, Runoff (% norm.)") +
  ggtitle("Chicago Mayoral Election, Paul Vallas: \nRound I (Feb. 28, 2023) vs. Runoff (Apr. 4, 2023)") +
  labs(color = "Round I \nPrecinct Winner") +
  geom_segment(aes(x = 0.5, y = 0.5, xend = 0, yend = 1), arrow = arrow(length = unit(1, "cm")))+
  coord_fixed(ratio = 1)+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_rect(color = "grey", fill = NA, size = 1))
ggsave("2roundscatter_Vallas.png", last_plot(), width = 6, height = 4.5, dpi = 600)

#GGplot johnson Round I (Feb. 28, 2023) vs. Runoff (Apr. 4, 2023)
ggplot() +
  geom_point(data=votes_all, aes(x=BRANDON.JOHNSON.p, y=Johnson.p, color=winner)) +
  scale_color_manual(values = my_palette, 
                     breaks = c(unique(votes_r1$winner)[1], unique(votes_r1$winner)[6], unique(votes_r1$winner)[5], unique(votes_r1$winner)[3], unique(votes_r1$winner)[2], unique(votes_r1$winner)[4]),
                     labels = c("B.Johnson", "J.Green", "C.Garcia", "L.Lightfoot", "P.Vallas", "W.Wilson")) +
  geom_abline(slope = 1, intercept = 0) +
  theme_minimal() +
  xlab("Brandon Johnson vote share, Round I (% norm.)") +
  ylab("Brandon Johnson vote share, Runoff (% norm.)") +
  ggtitle("Chicago Mayoral Election, Brandon Johnson: \nRound I (Feb. 28, 2023) vs. Runoff (Apr. 4, 2023)") +
  labs(color = "Round I \nPrecinct Winner") +
  geom_segment(aes(x = 0.5, y = 0.5, xend = 0, yend = 1), arrow = arrow(length = unit(1, "cm")))+
  coord_fixed(ratio = 1)+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_rect(color = "grey", fill = NA, size = 1))
ggsave("2roundscatter_Johnson.png", last_plot(), width = 4.5, height = 4.5, dpi = 600)

#Creates a correlation matrix for the top four first round candidates and Runoff
matrix = data.frame(votes_all$JESUS..CHUY..GARCIA.p, votes_all$LORI.E..LIGHTFOOT.p, votes_all$BRANDON.JOHNSON.p, votes_all$PAUL.VALLAS.p, votes_all$Vallas.p, votes_all$Johnson.p)
colnames(matrix) = c("C.Garcia R1", "L.Lightfoot R1", "B.Johnson  R1", "P.Vallas  R1", "P.Vallas R2", "B.Johnson R2")
matrix = na.omit(matrix)
cor_matrix = cor(matrix)
library(ggcorrplot)
ggcorrplot(cor_matrix, type = "upper", hc.order = FALSE, lab = TRUE)
rm(cor_matrix, matrix)
ggsave("corrmatrix2.png", last_plot(), width = 6, height = 6, dpi = 600)

#Mapping

votes_all$ward_precinct = c("NA")
for (x in 1:length(votes_all$Ward)){
  if (votes_all$Precinct[x] < 10 & votes_all$Ward[x] < 10)
  {votes_all$ward_precinct[x] = paste("0", votes_all$Ward[x], "0", "0", votes_all$Precinct[x], sep ="")}
  if (votes_all$Precinct[x] > 9 & votes_all$Ward[x] < 10)
  {votes_all$ward_precinct[x] = paste("0", votes_all$Ward[x], "0", votes_all$Precinct[x], sep ="")}
  if (votes_all$Precinct[x] < 10 & votes_all$Ward[x] > 9)
  {votes_all$ward_precinct[x] = paste( votes_all$Ward[x], "0", "0", votes_all$Precinct[x], sep ="")}
  if (votes_all$Precinct[x] > 9 & votes_all$Ward[x] > 9)
  {votes_all$ward_precinct[x] = paste(votes_all$Ward[x], "0", votes_all$Precinct[x], sep ="")}
}
rm(x)

#Combined datasets
library(dplyr)
map <- inner_join(map, votes_all, by = c("ward_precinct"))

#Geospatial plotting
library(geojsonio)
map <- geojsonsf::geojson_sf("Boundaries - Ward Precincts (2023-).geojson")
library(ggplot2)
ggplot()+
  geom_sf(data=map, aes(fill = winner))+
  ggtitle("Chicago Mayoral Election, Round I (Feb. 28, 2023)") +
  labs(fill = "Precinct Winner") +
  scale_fill_manual(values = my_palette, 
                     breaks = c(unique(votes_r1$winner)[1], unique(votes_r1$winner)[6], unique(votes_r1$winner)[5], unique(votes_r1$winner)[3], unique(votes_r1$winner)[2], unique(votes_r1$winner)[4]),
                     labels = c("B.Johnson", "J.Green", "C.Garcia", "L.Lightfoot", "P.Vallas", "W.Wilson"))+
  theme_minimal()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_rect(color = "grey", fill = NA, size = 1))

ggsave("round1map.png", last_plot(), width = 8, height = 8, dpi = 600)

#New fields for vote reassigning
map$Johnson_gain = map$Johnson.p - map$BRANDON.JOHNSON.p
map$Vallas_gain = map$Vallas.p - map$PAUL.VALLAS.p
  
library(ggplot2)
ggplot()+
  geom_sf(data=map, aes(fill = Johnson_gain))+
  ggtitle("Chicago Mayoral Election, Runoff (Apr. 4, 2023)") +
  labs(subtitle = "Brandon Johnson Vote Share Increase (R1 -> RO)") +
  labs(fill = "Johnson Vote Share \nRunoff - Round I")+
  scale_fill_gradient(low = "white", high = "black", limits = c(0, 1), labels = c("0%", "25%", "50%", "75%", "100%"))+
  theme_minimal()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_rect(color = "grey", fill = NA, size = 1))
ggsave("johnson_diff_map.png", last_plot(), width = 5.5, height = 4.5, dpi = 600)

ggplot()+
  geom_sf(data=map, aes(fill = Vallas_gain))+
  ggtitle("Chicago Mayoral Election, Runoff (Apr. 4, 2023)") +
  labs(subtitle = "Paul Vallas Vote Share Increase (R1 -> RO)") +
  labs(fill = "Vallas Vote Share \nRunoff - Round I")+
  scale_fill_gradient(low = "white", high = "black", limits = c(0, 1), labels = c("0%", "25%", "50%", "75%", "100%"))+
  theme_minimal()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_rect(color = "grey", fill = NA, size = 1))
ggsave("vallas_diff_map.png", last_plot(), width = 5.5, height = 4.5, dpi = 600)

ggplot()+
  geom_sf(data=map, aes(fill = Johnson_gain))+
  scale_fill_gradient(low = "white", high = "black", limits = c(0, 1), labels = c("0%", "25%", "50%", "75%", "100%"))+
  theme_void()+
  theme(legend.position = "none")+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),)
ggsave("icon.png", last_plot(), width = 5, height = 5, dpi = 600)

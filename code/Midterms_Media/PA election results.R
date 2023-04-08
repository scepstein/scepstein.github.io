#PA election results organization 

filepath1 = " "

library(rjson)
PAvotes <- fromJSON(file = filepath1)

#Source
#https://static01.nyt.com/elections-assets/2022/data/2022-11-08/results-pennsylvania.json

County = c(0)
for (x in 2:68){
  County[x-1] = PAvotes[["races"]][[1]][["reporting_units"]][[x]][["name"]]
}
rm(x)
PA_Senate = data.frame(County)
rm(County)

PA_Senate$Winner_votes = c(0)
PA_Senate$Loser_votes = c(0)
PA_Senate$Winner = c(0)
PA_Senate$Loser = c(0)

for (x in 2:68){
  PA_Senate$Winner_votes[x-1] = PAvotes[["races"]][[1]][["reporting_units"]][[x]][["candidates"]][[1]][["votes"]][["total"]]
  PA_Senate$Loser_votes[x-1] = PAvotes[["races"]][[1]][["reporting_units"]][[x]][["candidates"]][[2]][["votes"]][["total"]]
  PA_Senate$Winner[x-1] = PAvotes[["races"]][[1]][["reporting_units"]][[x]][["candidates"]][[1]][["nyt_id"]]
  PA_Senate$Loser[x-1] = PAvotes[["races"]][[1]][["reporting_units"]][[x]][["candidates"]][[2]][["nyt_id"]]
}
rm(x)

PA_Senate$Fetterman_votes = c(0)
PA_Senate$Oz_votes = c(0)

for (x in 1:length(PA_Senate$County)){
  if(PA_Senate$Winner[x] == "fetterman-j"){
    PA_Senate$Fetterman_votes[x] = PA_Senate$Winner_votes[x]
    PA_Senate$Oz_votes[x] = PA_Senate$Loser_votes[x]
  }
  if(PA_Senate$Winner[x] == "oz-m"){
    PA_Senate$Oz_votes[x] = PA_Senate$Winner_votes[x]
    PA_Senate$Fetterman_votes[x] = PA_Senate$Loser_votes[x]
  }
}
rm(x)

PA_Senate$Total_votes = PA_Senate$Fetterman_votes + PA_Senate$Oz_votes
PA_Senate$Fetterman_margin = (PA_Senate$Fetterman_votes - PA_Senate$Oz_votes) *100 / PA_Senate$Total_votes
PA_Senate$Turnout = PA_Senate$Total_votes * 100 / sum(PA_Senate$Total_votes)


County = c(0)
for (x in 2:68){
  County[x-1] = PAvotes[["races"]][[2]][["reporting_units"]][[x]][["name"]]
}
rm(x)
PA_Governor = data.frame(County)
rm(County)

PA_Governor$Winner_votes = c(0)
PA_Governor$Loser_votes = c(0)
PA_Governor$Winner = c(0)
PA_Governor$Loser = c(0)

for (x in 2:68){
  PA_Governor$Winner_votes[x-1] = PAvotes[["races"]][[2]][["reporting_units"]][[x]][["candidates"]][[1]][["votes"]][["total"]]
  PA_Governor$Loser_votes[x-1] = PAvotes[["races"]][[2]][["reporting_units"]][[x]][["candidates"]][[2]][["votes"]][["total"]]
  PA_Governor$Winner[x-1] = PAvotes[["races"]][[2]][["reporting_units"]][[x]][["candidates"]][[1]][["nyt_id"]]
  PA_Governor$Loser[x-1] = PAvotes[["races"]][[2]][["reporting_units"]][[x]][["candidates"]][[2]][["nyt_id"]]
}
rm(x)

PA_Governor$Shapiro_votes = c(0)
PA_Governor$Mastriano_votes = c(0)

for (x in 1:length(PA_Governor$County)){
  if(PA_Governor$Winner[x] == "shapiro-j"){
    PA_Governor$Shapiro_votes[x] = PA_Governor$Winner_votes[x]
    PA_Governor$Mastriano_votes[x] = PA_Governor$Loser_votes[x]
  }
  if(PA_Governor$Winner[x] == "mastriano-d"){
    PA_Governor$Mastriano_votes[x] = PA_Governor$Winner_votes[x]
    PA_Governor$Shapiro_votes[x] = PA_Governor$Loser_votes[x]
  }
}
rm(x)

PA_Governor$Total_votes = PA_Governor$Shapiro_votes + PA_Governor$Mastriano_votes
PA_Governor$Shapiro_margin = (PA_Governor$Shapiro_votes - PA_Governor$Mastriano_votes) *100 / PA_Governor$Total_votes
PA_Governor$Turnout = PA_Governor$Total_votes * 100 / sum(PA_Governor$Total_votes)

filepath2 = " "

PA_Biden = read.csv(header = TRUE, filepath2)

#Source

#https://en.wikipedia.org/wiki/2020_United_States_presidential_election_in_Pennsylvania

PA_Senate = PA_Senate[order(PA_Senate$County),]
PA_Governor = PA_Governor[order(PA_Governor$County),]

PA_Senate$Fetterman_v_Biden = PA_Senate$Fetterman_margin - PA_Biden$Biden_margin
PA_Governor$Shapiro_v_Biden = PA_Governor$Shapiro_margin - PA_Biden$Biden_margin

PA = PA[order(PA$COUNTY_NAM),]
PA$Fetterman_v_Biden = PA_Senate$Fetterman_v_Biden
PA$Shapiro_v_Biden = PA_Governor$Shapiro_v_Biden

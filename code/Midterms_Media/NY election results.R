#Election results for New York

filepath1 = " "

library(rjson)
NYvotes <- fromJSON(file = filepath1)

#Source
#https://static01.nyt.com/elections-assets/2022/data/2022-11-08/results-new-york.json

#NY Vote information harvested from NYT JSON file 
County = c(0)
for (x in 2:63){
  County[x-1] = NYvotes[["races"]][[1]][["reporting_units"]][[x]][["name"]]
}
rm(x)
NY_Senate = data.frame(County)
rm(County)

NY_Senate$Winner_votes = c(0)
NY_Senate$Loser_votes = c(0)
NY_Senate$Winner = c(0)
NY_Senate$Loser = c(0)

for (x in 2:63){
  NY_Senate$Winner_votes[x-1] = NYvotes[["races"]][[1]][["reporting_units"]][[x]][["candidates"]][[1]][["votes"]][["total"]]
  NY_Senate$Loser_votes[x-1] = NYvotes[["races"]][[1]][["reporting_units"]][[x]][["candidates"]][[2]][["votes"]][["total"]]
  NY_Senate$Winner[x-1] = NYvotes[["races"]][[1]][["reporting_units"]][[x]][["candidates"]][[1]][["nyt_id"]]
  NY_Senate$Loser[x-1] = NYvotes[["races"]][[1]][["reporting_units"]][[x]][["candidates"]][[2]][["nyt_id"]]
}
rm(x)

NY_Senate$Schumer_votes = c(0)
NY_Senate$Pinion_votes = c(0)

for (x in 1:length(NY_Senate$County)){
  if(NY_Senate$Winner[x] == "schumer-c"){
    NY_Senate$Schumer_votes[x] = NY_Senate$Winner_votes[x]
    NY_Senate$Pinion_votes[x] = NY_Senate$Loser_votes[x]
  }
  if(NY_Senate$Winner[x] == "pinion-j"){
    NY_Senate$Pinion_votes[x] = NY_Senate$Winner_votes[x]
    NY_Senate$Schumer_votes[x] = NY_Senate$Loser_votes[x]
  }
}
rm(x)

NY_Senate$Total_votes = NY_Senate$Schumer_votes + NY_Senate$Pinion_votes
NY_Senate$Schumer_margin = (NY_Senate$Schumer_votes - NY_Senate$Pinion_votes) *100 / NY_Senate$Total_votes
NY_Senate$Turnout = NY_Senate$Total_votes * 100 / sum(NY_Senate$Total_votes)


County = c(0)
for (x in 2:63){
  County[x-1] = NYvotes[["races"]][[2]][["reporting_units"]][[x]][["name"]]
}
rm(x)
NY_Governor = data.frame(County)
rm(County)

NY_Governor$Winner_votes = c(0)
NY_Governor$Loser_votes = c(0)
NY_Governor$Winner = c(0)
NY_Governor$Loser = c(0)

for (x in 2:63){
  NY_Governor$Winner_votes[x-1] = NYvotes[["races"]][[2]][["reporting_units"]][[x]][["candidates"]][[1]][["votes"]][["total"]]
  NY_Governor$Loser_votes[x-1] = NYvotes[["races"]][[2]][["reporting_units"]][[x]][["candidates"]][[2]][["votes"]][["total"]]
  NY_Governor$Winner[x-1] = NYvotes[["races"]][[2]][["reporting_units"]][[x]][["candidates"]][[1]][["nyt_id"]]
  NY_Governor$Loser[x-1] = NYvotes[["races"]][[2]][["reporting_units"]][[x]][["candidates"]][[2]][["nyt_id"]]
}
rm(x)

NY_Governor$Hochul_votes = c(0)
NY_Governor$Zeldin_votes = c(0)

for (x in 1:length(NY_Governor$County)){
  if(NY_Governor$Winner[x] == "hochul-k"){
    NY_Governor$Hochul_votes[x] = NY_Governor$Winner_votes[x]
    NY_Governor$Zeldin_votes[x] = NY_Governor$Loser_votes[x]
  }
  if(NY_Governor$Winner[x] == "zeldin-l"){
    NY_Governor$Zeldin_votes[x] = NY_Governor$Winner_votes[x]
    NY_Governor$Hochul_votes[x] = NY_Governor$Loser_votes[x]
  }
}
rm(x)

NY_Governor$Total_votes = NY_Governor$Hochul_votes + NY_Governor$Zeldin_votes
NY_Governor$Hochul_margin = (NY_Governor$Hochul_votes - NY_Governor$Zeldin_votes) *100 / NY_Governor$Total_votes
NY_Governor$Turnout = NY_Governor$Total_votes * 100 / sum(NY_Governor$Total_votes)

filepath2 = " "
NY_Biden = read.csv(header = TRUE, filepath2)

#Source
#https://en.wikipedia.org/wiki/2020_United_States_presidential_election_in_New_York

NY_Senate = NY_Senate[order(NY_Senate$County),]
NY_Governor = NY_Governor[order(NY_Governor$County),]

NY_Senate$Schumer_v_Biden = NY_Senate$Schumer_margin - NY_Biden$Biden_margin
NY_Governor$Hochul_v_Biden = NY_Governor$Hochul_margin - NY_Biden$Biden_margin

NYS = NYS[order(NYS$NAME),]
NYS$Schumer_v_Biden = NY_Senate$Schumer_v_Biden
NYS$Hochul_v_Biden = NY_Governor$Hochul_v_Biden

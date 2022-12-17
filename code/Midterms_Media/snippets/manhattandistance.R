#Code used to calculate distance between each PA county and Manhattan 
manhattan = subset(NYS, NAME == "New York")

PA$Manhattan_dist = c(0)
for (x in 1:length(PA$COUNTY_NAM)){
  PA$Manhattan_dist[x] = st_distance(manhattan, PA[x,])[1,1]
}

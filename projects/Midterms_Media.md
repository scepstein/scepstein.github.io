---
layout: project
type: project
image: img/Midterms_Media/icon.jpg
title: "The Role of Media in 2022 Midterm Elections"
date: 2022
published: true
labels:
- RStudio
- R
- shapefile
- R/rgdal
- R/sf
- R/rjson
- R/ggplot2
- R/cowplot
summary: "Analysis of 2022 Midterm Elections and the role of media markets."
---

## Code and Packages Used

RStudio was used as the IDE for this project. The entire project was analyzed using the R programming language. Data in csv, json, and shp file types were analyzed. The following R packages were used: rgdal, sf, rjson, ggplot2, and cowplot.

Click here to view all the code used to produce analysis and visualizations below. 

### Data Disclosue

I have produced all of the visualizations shown below and links to the corresponding code are included above. All data that was retrieved from outside sources is referenced at the end of the article. 

## Analysis and Results

#### Midterm Elections

In the United States, midterm elections are held halfway through each presidential term; they provide the public with the opportunity to reshape most federal and state offices through democratic process. Historically, the political party that the President represents will face an unfavorable environment in the midterms, which frequently results in large losses for that party. One popular theory as to why this occurs is that the segment of the public that opposes the actions and ideology of the incumbent president will turnout to vote at a larger rate than the complacent supporters. Leading up to election day in 2022, the presidency is occupied by Joseph Biden, a Democrat, producing the expectation from historical precedent that the national environment is favorable to Republicans. Practically this means that Republican candidates are expected to do better, at the expense of their Democratic counterparts, shifting the outcomes primarily in races that are close. 

#### Results of 2022

With the results of the November 8th elections almost completed, Democrats appear to have performed much better than what was expected from historical precedent. Losses for Democrats in key U.S. House, U.S. Senate, and state governors' races were kept to a minimum. However, this trend was not observed ubiquitously throughout the nation. Democratic New York governor Kathy Hochul won her election by only 6 points. Statewide races are typically a lock for Democrats in New York, where former governor Andrew Cuomo won his previous election by 23 points in 2018, the same margin Joe Biden won the state by in 2020. Throughout the state, Democrats lost several U.S. House races that Biden had carried in 2020, while Democrats out of New York won in much more difficult terrain. 

#### What happened in New York?

The 2022 elections featured many unique candidates nationwide, which was likely responsible for several candidate-specific election outcomes. While candidate quality was likely a relevant factor in New York, the poor performance by Democratic candidates on all levels of the ballot is indicative of a larger systematic effect than individual candidate quality. One theory that I've come across relates to the effect of media in New York, particularly surrounding New York City. Proponents of the media bias theory claim that New York City based media, more so than media in other places, supports Republican ideology and talking points and ended up promoting Republican candidates in the midterm elections. As a result, I've gathered available data in order to determine if this theory is sensible. 

Firstly, I examined Hochul's performance statewide relative to Biden's 2020 presidential results, which will be used as a baseline. I also looked at Schumer's performance in his campaign for U.S. Senate (2022). Schumer is an extremely popular statewide elected, winning by 43 points in 2016 and 34 points in Republican-wave year 2010. In 2022, Schumer only carried the state by 12 points, suggesting that Hochul's candidate quality was not the only detractor for Democrats in the state. Both Schumer and Hochul under-performed Biden's electoral gains (by % of vote acquired) in all 62 counties. 

<img class="img-fluid" src="../img/Midterms_Media/hochulvbiden.jpg" width="45%">
<img class="img-fluid" src="../img/Midterms_Media/schumervbiden.jpg" width="45%">

#### Pennsylvania shows a different story

As seen in several competitive battleground states across the country, where Republicans were predicted to have an edge, Democratic candidates produced many statewide victories, bucking historical precedent. In Pennsylvania, senatorial candidate John Fetterman (D) defeated challenger Mehemt Oz (R) and gubernatorial candidate Josh Shapiro (D) defeated challenger Douglas Mastriano (R), by much larger margins than the state has offered in recent Presidential elections to both parties. Shapiro out-performed Biden's margin in every county, winning the state by almost 15 points compared to Biden's 1 point victory. Fetterman outperformed Biden's margin in all but two counties: Pike and Monroe. Across the entire map, there appears to be a general trend that the further a county is located away from New York City, the larger over-performance by the 2022 Democratic candidates. 

<img class="img-fluid" src="../img/Midterms_Media/shapirovbiden.jpg" width="45%">
<img class="img-fluid" src="../img/Midterms_Media/fettermanvbiden.jpg" width="45%">

#### Southwestern Connecticut shifts rightward

To look at additional examples of the "proximity to New York City effect," we can look to one of New York's eastern neighbors: Connecticut. Across the state, we see a similar trend where the two Democratic incumbents, Lamont for Governor and Blumenthal for Senate, ran behind Biden's 2020 numbers almost across the board, but especially in the southwestern region of the state, which is closest in proximity to New York City.

<img class="img-fluid" src="../img/Midterms_Media/lamontvbiden.jpg" width="45%">
<img class="img-fluid" src="../img/Midterms_Media/blumenthalvbiden.jpg" width="45%">

#### The role of media

Designated media areas (DMAs) are geographic boundaries used to determine television and radio markets. Presumably, everyone in the same DMA is receiving the same news tailored to the culture of their geographic region. Mapped below, the New York City DMA contains small sections of Pennsylvania and Connecticut in addition to surrounding areas in New York and New Jersey. Notably, these sections include Pike County, PA and a portion of Southwestern Connecticut. These are the same areas where statewide Democratic candidates performed the worst relative to Biden's 2020 numbers. 

<img class="img-fluid" src="../img/Midterms_Media/nycdma_zoomout.jpg" width="45%">
<img class="img-fluid" src="../img/Midterms_Media/nycdma_zoomin.jpg" width="45%">

<img class="img-fluid" src="../img/Midterms_Media/Sen_spread.jpg" width="45%">
<img class="img-fluid" src="../img/Midterms_Media/Gov_spread.jpg" width="45%">

Connecticut provides election results by township, so we have increased granularity to visualize regions inside and outside the NYC DMA. In both statewide races, the median township in the New York City market featured a worse performance for Democrats than the 25th percentile in the Hartford and New Haven market that covers the rest of the state. In addition to the strong negative outliers present in the NYC media market, these plots support the trends suggested by the map data.  

<img class="img-fluid" src="../img/Midterms_Media/CT_bp_Sen.jpg" width="45%">
<img class="img-fluid" src="../img/Midterms_Media/CT_bp_Gov.jpg" width="45%">

#### Influence from the big city

The maps generated thus far have suggested proximity to New York City relates to electoral performance in Pennsylvania and Connecticut. I generated some correlation plots to determine how strong the correlation is. 

```r
#Code used to calculate distance between each PA county and Manhattan 
manhattan = subset(NYS, NAME == "New York")

PA$Manhattan_dist = c(0)
for (x in 1:length(PA$COUNTY_NAM)){
  PA$Manhattan_dist[x] = st_distance(manhattan, PA[x,])[1,1]
}
```

[Click here to see the rest of the code from this project](https://github.com/scepstein/scepstein.github.io/tree/main/code/Midterms_Media)

Firstly, within New York States there was no apparent correlation between proximity to Manhattan and either Schumer or Hochul's performances (r = 0.1 and 0.14, respectively), suggesting the statewide issues these two candidates faced were unrelated to media or culture unique to NYC.

<img class="img-fluid" src="../img/Midterms_Media/Schumer_dist.jpg" width="45%">
<img class="img-fluid" src="../img/Midterms_Media/Hochul_dist.jpg" width="45%">

In Pennsylvania, the correlation was more significant (r = 0.52 for Shapiro and 0.61 for Fetterman). Across the state, Fetterman and Shapiro performed better in the Western part of the state, in almost all counties with better performances than Biden's 2020 numbers. In both cases, the worst two preforming counties are among the closest. 

<img class="img-fluid" src="../img/Midterms_Media/Fetterman_dist.jpg" width="45%">
<img class="img-fluid" src="../img/Midterms_Media/Shapiro_dist.jpg" width="45%">

Similar to before, Connecticut displays an interesting regional effect. Well displayed in Blumenthal's plots, towns within 100 km of Manhattan featured a strong correlation (r = 0.69) between proximity and electoral performance. Beyond 100 km, the effect is more or less lost (r = 0.18), yielding the full data set an r value of 0.43. Lamont's governor results are less pronounced but the two regions still persist (r = 0.53, 0.25, and 0.34, respectively).

<img class="img-fluid" src="../img/Midterms_Media/Blumenthal_dist.jpg" width="45%">
<img class="img-fluid" src="../img/Midterms_Media/Lamont_dist.jpg" width="45%">

#### Conclusions

## Data Sources

[National map of designed market areas (DMAs)](https://datablends.us/2021/01/14/a-useful-dma-shapefile-for-tableau-and-alteryx/)

[Shapefile of New York counties](https://gis.ny.gov/gisdata/inventories/details.cfm?DSID=927)

[Shapefile of Pennsylvania counties](https://www.pasda.psu.edu/uci/DataSummary.aspx?dataset=24)
 
[Shapefile of Connecticut counties](https://catalog.data.gov/dataset/tiger-line-shapefile-2019-state-connecticut-current-county-subdivision-state-based)

[Pennsylvania election results, 2022](https://www.nytimes.com/interactive/2022/11/08/us/elections/results-pennsylvania.html)

[Pennsylvania election results, 2020](https://en.wikipedia.org/wiki/2020_United_States_presidential_election_in_Pennsylvania)

[New York election results, 2022](https://www.nytimes.com/interactive/2022/11/08/us/elections/results-new-york.html)

[New York election results, 2020](https://en.wikipedia.org/wiki/2020_United_States_presidential_election_in_New_York)

[Connecticut election results, 2022](https://www.nytimes.com/interactive/2022/11/08/us/elections/results-connecticut.html)

[Connecticut election resutls, 2020](https://www.nbcconnecticut.com/news/politics/decision-2020/town-by-town-results-how-did-connecticut-vote-in-the-2020-presidential-election/2355898/)

### Disclaimer

Vote totals were taken as reported before official results were certified, so the finalized numbers may be slightly different than what is presented here. 

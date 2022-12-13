---
layout: project
type: project
image: img/cotton/cotton-square.png
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

#Insert images here

#### Pennsylvania shows a different story

As seen in several competitive battleground states across the country, where Republicans were predicted to have an edge, Democratic candidates produced many statewide victories, bucking historical precedent. In Pennsylvania, senatorial candidate John Fetterman (D) defeated challenger Mehemt Oz (R) and gubernatorial candidate Josh Shapiro (D) defeated challenger Douglas Mastriano (R), by much larger margins than the state has offered in recent Presidential elections to both parties. Shapiro out-performed Biden's margin in every county, winning the state by almost 15 points compared to Biden's 1 point victory. Fetterman outperformed Biden's margin in all but two counties: Pike and Monroe. Across the entire map, there appears to be a general trend that the further a county is located away from New York City, the larger over-performance by the 2022 Democratic candidates. 

#Insert images here



## Data Sources

National map of designed market areas (DMAs)
https://datablends.us/2021/01/14/a-useful-dma-shapefile-for-tableau-and-alteryx/

Shapefile of New York counties
https://gis.ny.gov/gisdata/inventories/details.cfm?DSID=927

Shapefile of Pennsylvania counties
https://www.pasda.psu.edu/uci/DataSummary.aspx?dataset=24
 
Shapefile of Connecticut counties 
https://catalog.data.gov/dataset/tiger-line-shapefile-2019-state-connecticut-current-county-subdivision-state-based

Pennsylvania election results, 2022
https://www.nytimes.com/interactive/2022/11/08/us/elections/results-pennsylvania.html

Pennsylvania election results, 2020
https://en.wikipedia.org/wiki/2020_United_States_presidential_election_in_Pennsylvania

New York election results, 2022
https://www.nytimes.com/interactive/2022/11/08/us/elections/results-new-york.html

New York election results, 2020
https://en.wikipedia.org/wiki/2020_United_States_presidential_election_in_New_York

Connecticut election results, 2022
https://www.nytimes.com/interactive/2022/11/08/us/elections/results-connecticut.html

Connecticut election resutls, 2020
https://www.nbcconnecticut.com/news/politics/decision-2020/town-by-town-results-how-did-connecticut-vote-in-the-2020-presidential-election/2355898/


### Disclaimer

Vote totals were taken as reported before official results were certified, so the finalized numbers may be slightly different than what is presented here. 

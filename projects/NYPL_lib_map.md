---
layout: project
type: project
image: img/Midterms_Media/icon.jpg
title: "Design of a web application to display and map NYPL library locations for any book in the online catalog."
date: 2023-01
published: true
labels:
- Python
- Flask
- Google Cloud Platform
- Google Maps API
- HTML/CSS/Javascript
summary: "Use of R-programming to integrate recent election results with geographic information data to generate maps to determine the effect of media on the 2022 midterm results."
---

#This page is currently in development.

### Introduction

In this blog post, I plan to use the R programming language to analyze the results of the 2022 Midterm elections in New York, Connecticut, and Pennsylvania. I will compare county and town election results from the 2020 presidential election to senatorial and gubernatorial elections in 2022. Further, I look at the impact of geospatial media markets on election results in these states. Through generation of maps and data plots, I hope to identify any connections between common media presence and trends in election results. 

### Code and Packages Used

old: content: RStudio was used as the IDE for this project. The entire project was analyzed using the R programming language. Data in csv, json, and shp file types were analyzed. The following R packages were used: rgdal, sf, rjson, ggplot2, and cowplot.

old content: [Click here](https://github.com/scepstein/scepstein.github.io/tree/main/code/Midterms_Media) to view all the code used to produce analysis and visualizations below. 

    <form id="website-form">
        <input type="text" name="website_link" placeholder="Enter website link here">
        <button type="submit">Submit</button>
    </form>
    <div id="map" style="height: 500px; width: 100%;"></div>
    <script>
        document.getElementById("website-form").addEventListener("submit", function(event) {
        event.preventDefault();
        var website_link = document.querySelector('input[name="website_link"]').value;
        fetch('https://nypl-library-map.uc.r.appspot.com/libraries', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ website_link: website_link })
        })
        .then(function(response) {
            return response.json();
        })
        .then(function(data) {
            console.log(data);
            globalData = data;
            var src = `https://maps.googleapis.com/maps/api/js?key=${data.api_key}&callback=initMap`;
            var script = document.createElement('script');
            script.src = src;
            document.body.appendChild(script);
        });
    }, { passive: false });

    var currentInfoWindow;

function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 40.7831, lng: -73.9712},
    zoom: 11.5
  });
  var markers = [];

  for (var i = 0; i < globalData.map_data.length; i++) {
    var marker;
    if (globalData.map_data[i].category === "available") {
      marker = new google.maps.Marker({
        position: {lat: globalData.map_data[i].lat, lng: globalData.map_data[i].lng},
        map: map,
        icon: 'http://maps.google.com/mapfiles/ms/micons/blue-dot.png'
      });
    } else if (globalData.map_data[i].category === "unavailable") {
      marker = new google.maps.Marker({
        position: {lat: globalData.map_data[i].lat, lng: globalData.map_data[i].lng},
        map: map,
        icon: 'http://maps.google.com/mapfiles/ms/micons/red-dot.png'
      });
    }

    marker.addListener('click', (function(marker, i) {
      return function() {
        if (currentInfoWindow) {
          currentInfoWindow.close();
        }
        var infowindow = new google.maps.InfoWindow({
          content: globalData.map_data[i].name
        });
        infowindow.open(map, marker);
        currentInfoWindow = infowindow;
      }
    })(marker, i));

    markers.push(marker);
  }
}
    </script>


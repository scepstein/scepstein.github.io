---
layout: project
type: project
image: img/NYPL_lib_map/NYPL_lib_ico.png
title: "Design of a web application to map NYPL library locations for any book in the online catalog."
date: 2023-01
published: true
labels:
- Python
- Flask
- Google Cloud Platform
- Google Maps API
- HTML
- CSS
- Javascript
summary: "A Python-based web-scraper is deployed via Flask app to gather information from the NYPL catalog to determine which libraries in the system stock a specified book. HTML/CSS/Javascript is used to render an interactive map to geographically position the found libraries and denote availability status of the particular item at that location."
---



### Introduction

The New York Public Library (NYPL) system consists of libraries throughout Manhattan, the Bronx, and Staten Island. All of the items served within this system are discoverable on the online NYPL catalog. However, the catalog simply generates a list of libraries that stock the item but lacks the ability to geographically assess the location of the libraries. As a frequent reader and library patron, I wanted to build an application that would enable me to quickly determine which locations were holding a book I was looking for and which ones were near my location.

Using several libraries (not the book-housing kind) in Python, including Beautiful Soup, Pandas, and Requests, I developed a web-scarping tool that required the input of a library catalog entry URL and in turn produced the list of libraries carrying the item that are displayed on the web page for the typical patron. Scraping this information and the availability status of the item at each location, I could pair this information with geographic coordinates for each library to generate a map. Using Flask and Google Cloud Platform, I was able to deploy this application to a server to handle requests to my algorithm. I tailored HTML, CSS, and Javascript code to build the front-end of the application. With the help of the Google Maps API, a neat, interactive map is generated to display the libraries that carry the requested item.

[Try out the library finder in action HERE](https://raw.githack.com/scepstein/scepstein.github.io/main/data/NYPLmap/NYPL_library_finder.html)

### Code and Packages Used

old: content: RStudio was used as the IDE for this project. The entire project was anal

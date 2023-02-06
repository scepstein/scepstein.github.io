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

The New York Public Library (NYPL) system consists of libraries throughout Manhattan, the Bronx, and Staten Island. All of the items served within this system are discoverable on the online NYPL catalog. When searching for an item, the catalog simply generates a list of libraries that stock the item but lacks the ability to geographically assess the location of the libraries where the item is available. As a frequent reader and library patron, I wanted to build an application that would enable me to quickly determine which libraries were holding a book I was looking for and which of those were near my location.

Using several libraries (not the book-housing kind) in Python, including Beautiful Soup, Pandas, and Requests, I developed a web-scarping tool that required the input of a library catalog entry URL and in turn produced the list of libraries carrying the item that are displayed on the web page for the typical patron. Scraping this information and the availability status of the item at each location, I could pair this information with geographic coordinates for each library to generate a map. Using Flask and Google Cloud Platform, I was able to deploy this application to a server to handle requests to my algorithm. I tailored HTML, CSS, and Javascript code to build the front-end of the application. With the help of the Google Maps API, a neat, interactive map is generated to display the libraries that carry the requested item.

[Try out the library finder in action HERE](https://raw.githack.com/scepstein/scepstein.github.io/main/data/NYPLmap/NYPL_library_finder.html)

### Finished Product

The finished product is functional and can be accessed at the link above. In summary, a minimal front-end webpage is available to recieve the URL for a particular NYPL catalog item. In the following example, I'll show the entry for To Kill a Mockingbird by Harper Lee.

<img class="img-fluid" src="../img/NYPL_lib_map/front end 1.png" width="80%">

Submission of the URL generates an interactive Google Map with pins for all library locations that typically stock the item. The pins are then color-coded for whether or not at least one copy of  the item is currently in stock at the specific location (screenshot below). 

<img class="img-fluid" src="../img/NYPL_lib_map/front end 2.png" width="80%">

The pins can also be clicked on to reveal the library name (screenshot below).

<img class="img-fluid" src="../img/NYPL_lib_map/front end 3.png" width="80%">

### How it's done.

#### Server-Side Algorithm

The main functionality of the app relies on the following python script. The package Beautiful soup is used to fetch the HTML code from the provided URL to the library catalog page. The <a> elements are searched for strings that denote the library names as they are used in the table presented by the catalog. This collects information on the list of libraries that stock the item and the availability status at that location. The name of the library as listed (because they are modified with section titles such as "Fiction") is compared to a dataframe of library names, where the name with highest string similarity is selected along with geographic coordinates for the location. The data is then filtered to handle instances where one library possesses multiple copies of an item. If a library maintains at least one copy that is currently available, then it is marked as available. Otherwise, it is marked as unavilable. The data is then returned in json format for the front-end javascript code.

```python
def process_data(website_link):
        #Scrape full HTMl file from webpage
        soup=BeautifulSoup(requests.get(website_link).content, "html.parser")
        #Scrape library names from HTML file to generate a list of available and unavailable books
        hits_all=[] 
        hits_avail=[]
        for x in range(0, len(soup.find_all('a'))):
            if "bibHoldingsAllItems" in soup.find_all('a')[x]['href']:
                hits_all.append(soup.find_all('a')[x-1].text.strip())
        for x in range(0, len(soup.find_all('a'))):
            if "bibHoldingsAvailableItems2" in soup.find_all('a')[x]['href']:
                hits_avail.append(soup.find_all('a')[x-1].text.strip())
                hits_all.remove(soup.find_all('a')[x-1].text.strip())
        #Generate list of library map info
        geokey = pd.read_csv("https://raw.githubusercontent.com/scepstein/scepstein.github.io/main/data/NYPLmap/libdata.csv")
        map_data = []
        def library_geokey_sorting(vector, category_code):
            for b in vector: 
                sim_vector = []
                for s in geokey["name"]:
                    sim_vector.append(SequenceMatcher(None, b, s).ratio())
                map_data.append({
                    'name': geokey["name"][sim_vector.index(max(sim_vector))],
                    'lat': geokey["lattitude"][sim_vector.index(max(sim_vector))],
                    'lng': geokey["longitude"][sim_vector.index(max(sim_vector))],
                    'category': category_code
                })
        library_geokey_sorting(hits_all, "unavailable")
        library_geokey_sorting(hits_avail, "available")
        #Filter through the map data to avoid repeat pins
        filtered_data = []
        seen_buildings = set()
        for m in map_data:
            if m['name'] not in seen_buildings: #First time mentioned libraries always get filtered through immediately 
                seen_buildings.add(m['name'])
                filtered_data.append(m)
            else:
                for f in filtered_data: #if a library is added and the new entry shows an availability, it replaces the status of the one on the filtered list
                    if f['name'] == m['name'] and m['category'] == 'available':
                        f['category'] = 'available'
        return filtered_data
```

#### Front-End Javascript Code

The server side library data is then passed to the front-end javascript code, which generates the Google Map using Google Maps API. The following Javascript code is used to establish the map. The map is centered around Manhattan. Markers are generated from the passed data and designated with red or blue pin icons based on the availability status at the library. Upon clicking, the infowindow appears for the selected pin denoting the library name.
  
```javascript
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
```
  
  

#Importing 2022.11.28 Voter file

#packages needed for all chunks below
import pandas as pd
import re

#List of columns in the original source file
sourcefile_columns = ["Last Name", "First Name", "Middle Name", "Name Suffix", "Residence House Number", "Residence Fractional Address", "Resident Pre Street Direction", "Residence Street Name", "Residence Post Street Direction", "Residence Apartment Type", "Residence Apartment", "Not Standard Residential Address", "Residence City", "Residence Zip Code 5", "Zip code plus 4", "Mailing address 1", "Mailing Address 2", "Mailing Address 3", "Mailing Address 4", "DOB", "Gender", "Party", "Other Party", "County Code", "Election District", "Legislative District", "Town", "Ward", "Congressional District", "Senate District", "Assembly District", "Last Date Voted", "Last Year voted", "Last registered address", "Last county voted in", "Last registered name", "County Voter Registration number", "Application date", "Application source","ID Flag", "ID Verification met", "Voter status code", "Status reason code", "Date voter inactive", "Date voter purged", "Unique NYS voter id", "history"]

#List of columns I intend to be included in the import process 
columns_keep = ["Residence City", "Residence Zip Code 5", "DOB", "Gender", "Party", "County Code", "Election District", "Legislative District", "Town", "Ward", "Congressional District", "Senate District", "Assembly District", "Last Date Voted", "Last Year voted", "Unique NYS voter id", "history"]
columns_keep2 = columns_keep.copy()
#Create columns_keep as a list of the index positions of the columns of interest from the original source file
for x in range(len(columns_keep)):
    columns_keep[x] = sourcefile_columns.index(columns_keep[x])

#Import of voter file 2022.11.28
filepath = "/Users/samepstein/Desktop/AllNYSVoters_20221128.txt" #saved to Desktop
voterfile = pd.read_table(filepath, delimiter=',', header=None, usecols = columns_keep, encoding = "ISO-8859-1", dtype={sourcefile_columns.index("Gender"): "category", sourcefile_columns.index("Party"): "category", sourcefile_columns.index("County Code"): "category", sourcefile_columns.index("Election District"): "category", sourcefile_columns.index("Legislative District"): "category", sourcefile_columns.index("Ward"): "category", sourcefile_columns.index("Congressional District"): "category", sourcefile_columns.index("Senate District"): "category", sourcefile_columns.index("Assembly District"): "category",})
voterfile.columns = columns_keep2

#Import 2020 voter file
source_columns2020 = ["Last Name", "First Name", "Middle Name", "Name Suffix", "Residence House Number", "Residence Fractional Address", "Resident Pre Street Direction","Residence Post Street Direction", "Residence Street Name", "Residence Apartment Type", "Residence City", "Residence Zip Code 5", "Zip code plus 4", "Mailing address 1", "Mailing Address 2", "Mailing Address 3", "Mailing Address 4", "DOB", "Gender", "Party", "Other Party", "County Code", "Election District", "Legislative District", "Town", "Ward", "Congressional District", "Senate District", "Assembly District", "Last Date Voted", "Last Year voted", "Last county voted in", "Last registered address", "Last registered name", "County Voter Registration number", "Application date", "Application source", "ID Flag", "ID Verification met", "Voter status code", "Status reason code","Date voter inactive", "Date voter purged", "Unique NYS voter id", "history"]
desired_columns2020 = ["DOB", "Gender", "Party", "County Code", "Election District", "Legislative District", "Congressional District", "Senate District", "Assembly District", "Last Date Voted", "Unique NYS voter id", "history"]
desired_columns2 = desired_columns2020.copy()
for x in range(len(desired_columns2020)):
    desired_columns2020[x] = source_columns2020.index(desired_columns2020[x])

voterfile2020 = pd.read_table("/Users/samepstein/Desktop/AllNYSVoters_20210412.txt", delimiter=',', header=None, usecols = desired_columns2020, encoding = "ISO-8859-1", dtype={source_columns2020.index("Gender"): "category", source_columns2020.index("Party"): "category", source_columns2020.index("County Code"): "category", source_columns2020.index("Election District"): "category", source_columns2020.index("Legislative District"): "category",  source_columns2020.index("Congressional District"): "category", source_columns2020.index("Senate District"): "category", source_columns2020.index("Assembly District"): "category",})
voterfile2020.columns = desired_columns2

#Create a subset of the voterfile for all voters in the 3rd and 4th Congressional districts 
mask = voterfile['Congressional District'].isin(["3", "4"])
voters34 = voterfile[mask]

#Inner merge both files by users with Unique voter IDs
merged_voterfile = pd.merge(voters34, voterfile2020, on='Unique NYS voter id', how='inner')

#Determine which voters voted in 2020 and marks with TRUE, same for 2022
merged_voterfile["voter20"] = False
merged_voterfile["voter22"] = False
merged_voterfile.loc[merged_voterfile['history_x'].str.contains("20201103 GE|GE 20201103", na = False),"voter20"] = True
merged_voterfile.loc[merged_voterfile['history_x'].str.contains("20221108 GE|GE 20221108", na = False),"voter22"] = True

#Assign GEOIDs to merged voter file
def GEOID(row):
    county = int(row["County Code_x"])
    county = (2 * county) - 1
    if county > 99:
        countycode = str(county)
    if county < 100 and county >9:
        countycode = "0" + str(county)
    if county < 10:
        countycode = "00" + str(county)
    ED = int(row["Election District_y"])
    if ED > 99:
        EDcode = str(ED)
    if ED < 100 and ED >9:
        EDcode = "0" + str(ED)
    if ED < 10:
        EDcode = "00" + str(ED)
    towncode = "00"
    if county == 59:
        town = row["Town"]
        if town == "GC":
            towncode = "01"
        if town == "HEM":
            towncode = "02"
        if town == "LB":
            towncode = "03"
        if town == "NH":
            towncode = "04"
        if town == "OB":
            towncode = "05"
    if county == 81:
        return "36" + countycode + "-" + towncode +str(row["Assembly District_y"]) + EDcode
    if county == 59:
        return "36" + countycode + "-" + towncode +str(row["Assembly District_y"]) + EDcode
    if county == 103:
        return "36" + countycode + "-" + str(row["Assembly District_y"]) + towncode + EDcode
    else: 
        return "36" + countycode + "-" + towncode +str(row["Assembly District_y"]) + EDcode
merged_voterfile["GEOID"] = merged_voterfile.apply(GEOID, axis=1)

#Perform counts for each GEOID 
counts20 = merged_voterfile[merged_voterfile['Last Date Voted_y'].isin([20201103])]['GEOID'].value_counts()
counts22 = merged_voterfile[merged_voterfile['Last Date Voted_x'].isin([20221108])]['GEOID'].value_counts()
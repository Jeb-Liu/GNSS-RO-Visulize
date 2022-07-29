import requests
import csv
import os

# read csv as a list in current path [['a'],['b'],['c']]
mag = 'M6'
year = '2022'
csvname = mag + '.' + year + 'DateList.csv'
with open(csvname, newline='') as csvfile:
    data = csv.reader(csvfile)
    next(data)
    nameList = []
    for row in data:
        nameList.append(row)

# List to Char ['a','b','c']
date = []
for count1 in range(len(nameList)):
   date.append(''.join(nameList[count1]))
   #to 3 digits(day=90---day=090)
   if len(date[count1])==2:
       date[count1] = '0' + date[count1]

# Download file for the day of the date
for count2 in range(len(date)):
    
    # Construct URL for this loop
    ionPrf_address = "https://data.cosmic.ucar.edu/gnss-ro/cosmic2/provisional/spaceWeather/level2"
    Head = "ionPrf_prov1_"
    End = ".tar.gz"
    filename = Head + year + "_" + date[count2] + End
    url = ionPrf_address + "/" + year + "/" + date[count2] + "/" + filename
    #print(url)
    
    #make a path if not exist
    path = '.' + "/" + mag + "_" + year + "/"
    if not os.path.exists(path):
        os.makedirs(path)
        
    #Download files to from website
    req = requests.get(url)
    with open(path+filename,"wb") as f:
        f.write(req.content)
        print(filename+" done!")

print("All Finished!")
    

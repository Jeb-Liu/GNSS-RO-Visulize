import tarfile
import os

# Put files in the same folder as the zip file
# read file name in current path
nameList = os.listdir('.')

for count in range(len(nameList)):
    if ".tar.gz" in nameList[count]:
        if __name__ == "__main__":
            name = nameList[count]
            t = tarfile.open(name)
            # current path / ionPrf_prov1_yyyy_dddd
            path = '.' + "/" + name[:22]
            t.extractall(path)
            print("Unzip [" + name + "] OK!")
print("All finished!")

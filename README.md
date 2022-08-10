# GNSS-RO

流程例
1. 在[USGS](https://earthquake.usgs.gov/earthquakes/search/)下载2022年1月1日起, 震级M7以上的地震信息, 得到文件 query.csv
2. 将 query.csv 整理为 M7.2022DateList.csv
3. 运行 Download.py ,相应日期的ionPrf文件会被下载至.../1.Raw-Data/M7_2022
4. 将 unzip.py 复制至文件夹 M7_2022 内
5. 将文件夹 M7_2022 复制至 .../2.Calculate/data , 运行 unzip.py

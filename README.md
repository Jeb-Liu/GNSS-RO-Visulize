# GNSS-RO

流程例
1. 在[USGS](https://earthquake.usgs.gov/earthquakes/search/)下载2022年1月1日起, 震级M7以上的地震信息, 得到文件query.csv
2. 将query.csv整理为M7.2022DateList.csv
3. 运行Download.py ,相应日期的ionPrf文件会被下载至.../1.Raw-Data/M7_2022
4. 将 unzip.py 复制至 文件夹M7_2022 内
5.将 文件夹M7_2022 复制至 .../2.Calculate/data , 运行unzip.py

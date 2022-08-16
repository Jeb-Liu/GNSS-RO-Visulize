# GNSSデータを用いて津波電離圏ホールを探す

## COSMIC-2の観測データを用いて

## 実行手順
2022年1月1日から発生したM7以上の地震を例として、実行手順は以下：

1. [USGS](https://earthquake.usgs.gov/earthquakes/search/)に、2022年1月1日からM7以上の地震データをダウンロードする(query.csv)。
2. フォルダ 1.Raw-Data を開けて、 query.csv を M7.2022DateList.csv の書式に整理する。
3. Download.py を実行して、その日の[ionPrf](https://cdaac-www.cosmic.ucar.edu/cdaac/cgi_bin/fileFormats.cgi?type=ionPrf)フィルタは.../1.Raw-Data/M7_2022にダウンロードする。(日付は変更可能)
4. unzip.p yをフォルダ M7_2022 にコピペする。
5. フォルダ M7_2022 を .../2.Calculate/data にコピペして、 unzip.py を実行する。
6. フォルダ 2.Calculate を開けて、 query.csv を M7.yyyy.ddd.hh.mm.ss.lat.lon.dep.mag.csv の書式に整理する。
7. Search-Earth-Quake.m を実行して、条件が満たされるデータは図として保存する。

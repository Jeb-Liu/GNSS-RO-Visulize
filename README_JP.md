# GNSSデータを用いて津波電離圏ホールを探す

2022年1月1日から発生したM7以上の地震を例として、実行手順は以下：

1. [USGS](https://earthquake.usgs.gov/earthquakes/search/)に、2022年1月1日からM7以上の地震データをダウンロードする(query.csv)。
2. フォルダ1.Raw-Dataを開けて、query.csvをM7.2022DateList.csvの書式に整理する。
3. Download.pyを実行して、その日の[ionPrf](https://cdaac-www.cosmic.ucar.edu/cdaac/cgi_bin/fileFormats.cgi?type=ionPrf)フィルタは.../1.Raw-Data/M7_2022にダウンロードする。(日付は変更可能)
4. unzip.pyをフォルダM7_2022にコピペする。
5. フォルダM7_2022を.../2.Calculate/dataにコピペして、unzip.pyを実行する。
6. フォルダ2.Calculateを開けて、query.csvをM7.yyyy.ddd.hh.mm.ss.lat.lon.dep.mag.csvの書式に整理する。
7. Search-Earth-Quake.mを実行して、条件が満たされるデータは図として保存する。

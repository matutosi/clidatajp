## 
library(clidatajp)

choose_station <- function(){
  cols_jp    <- c("region", "pref", "station")
  cols_world <- c("continent", "country", "station")
  choices <- c("Japan", "Others")
  jp_others <- utils::menu(choices, title = "Select Japan or others")
  switch(jp_others, 
    choose_with_menu(station_jp,    cols_jp,    "no"), 
    choose_with_menu(station_world, cols_world, "no")
  )
}
choose_station()
search_station <- function(){
  cat("Input station or country name")
  input <- readLines(n=1)
  st_jp <- 
    dplyr::filter(station_jp, stringr::str_detect(station, input))
  st_w1 <- 
    dplyr::filter(station_world, stringr::str_detect(station, input))
  st_w2 <- 
    dplyr::filter(station_world, stringr::str_detect(country, input))
  dplyr::bind_rows(st_jp, st_w1, st_w2)
}
search_station()

## 日本のデータは，平年値と日別値が同じところ

  # 日本の気象データ
  # https://www.data.jma.go.jp/obd/stats/etrn/index.php
  # https://www.data.jma.go.jp/obd/stats/etrn/index.php?prec_no=63&block_no=47770&year=2021&month=6&day=20&view=
  # prec_no  : prefecture
  # block_no : stationのこと，prec_noと整合の必要あり
  # year
  # month
  # day
  # https://www.data.jma.go.jp/obd/stats/etrn/view/annually_s.php?prec_no=63&block_no=47770
  https://www.data.jma.go.jp/obd/stats/etrn/view/nml_sfc_ym.php?prec_no=63&block_no=47770
  main <- "https://www.data.jma.go.jp/obd/stats/etrn/view/"
  item <- c("annually_s", "nml_sfc_ym", "monthly_s3", "monthly_s1", 
            "nml_sfc_d", "nml_sfc_season", "daily_s1", "hourly_s1", "10min_s1")
  pref_station <- stringr::str_c("prec_no=", pref, "=&block_no=", station)
  year         <- stringr::str_c("&year=",  y)
  month        <- stringr::str_c("&month=", m)
  day          <- stringr::str_c("&day=",   d)
  stringr::str_c(main, item, ".pho?", pref_station, year, month, day)
  #   pref_stationは，prefで絞り込むか，stationからprefを自動選択
  #   itemはリストから選択
  #   year, month, dayはリストから選択か直接入力，範囲の場合はpoliteでスクレイピング?
  #   
  # "https://www.data.jma.go.jp/obd/stats/etrn/view/annually_s.php?prec_no=63&block_no=47770&year=2021&month=6&day=20"
  # annually_s.php      年ごとの値
  # nml_sfc_ym.php      月ごとの平年値
  # monthly_s3.php      全ての月ごとの値
  # monthly_s1.php      選択年の月ごとの値
  # nml_sfc_d.php       選択年月の日ごとの平年値
  # nml_sfc_season.php  霜・雪・結氷の初終日の平年値
  # daily_s1.php        選択月の日ごとの値
  # hourly_s1.php       選択年月日の1時間ごとの値
  # 10min_s1.php        選択年月日の10分ごとの値

  # "https://www.data.jma.go.jp/obd/stats/etrn/index.php?prec_no=63&block_no=47770&year=2021&month=6&day=20&view="%>%
  #   rvest::read_html() %>%
  #   rvest::html_elements("#main") %>%
  #   rvest::html_elements(".contents") %>%
  #   `[[`(3) %>%
  #   rvest::html_elements("a") %>% 
  #   rvest::html_attr("href")


## 世界のデータは，月別値と日別値が違う
    月別値のほうが地点数が少ない?(3444地点?)
        https://www.data.jma.go.jp/gmd/cpd/monitor/climatview/frame.php?&s=1&r=0&d=0&y=2022&m=8&e=6&t=0&l=0&k=0&s=1
    日別値は8318地点?
        https://www.data.jma.go.jp/cpd/monitor/dailyview/index.php?y=2022&m=8&d=1&e=0

  # 日本国外の気象データ(日単位)
  # https://www.data.jma.go.jp/cpd/monitor/dailyview/graph_mkhtml_d.php?&n=96001&y=2022&m=1&d=1&p=1
  # ymdから遡ってp日分のデータが表示される
  #   n: station no
  #   p: period (days)
  #   y: year
  #   m: month
  #   d: day
  #   k: ???
  #   e: ???
  #   r: ???
  #   s: ???



## 市町村の取り出し(不要)
  # 途中で中断
  #   気象庁のページに一覧があったたため
url <- "https://ton2net.com/shikuchouson-ja/"
txt <- 
  url %>%
  rvest::read_html() %>%
  rvest::html_elements("#main") %>%
  rvest::html_elements(".copy-box") %>%
  rvest::html_text2()
pref_city <- 
  txt %>%
  stringr::str_split("\n", simplify = TRUE) %>%
  c() %>%
  tibble::as_tibble() %>%
  tidyr::separate(value, into = c("pref", "city"), sep = " ") %>%
  na.omit() %>%
  dplyr::mutate(station = stringr::str_replace_all(city, "[市町村]$", ""))

station %>%
  dplyr::left_join(pref_city) %>%
  dplyr::filter(is.na(pref)) %>%
  print(n=nrow(.))

## 市町村の取り出し(不要)
  # 都道府県へのリンクまで
  # 途中で中断(他でデータが有ったため)
  # https://uub.jp/cty/kyoto.html
  # https://uub.jp/cty/hokkaido.html
url <- "https://uub.jp/47/"
left <- 
  url %>%
  rvest::read_html() %>%
  rvest::html_elements(".left") %>%
  rvest::html_elements("a") %>%
  rvest::html_attr("href") %>%
  stringr::str_sub(start = 3) %>%
  stringr::str_extract("^[^/][a-z]+")
right <- 
  url %>%
  rvest::read_html() %>%
  rvest::html_elements(".right") %>%
  rvest::html_elements("a") %>%
  rvest::html_attr("href") %>%
  stringr::str_sub(start = 3) %>%
  stringr::str_extract("^[^/][a-z]+")
na.omit(c(left, right))

## code to prepare `station_jp` dataset goes here
  # Japan: station, region, prefecture
library(tidyverse)
devtools::load_all(".")
data(climate_jp)

region_pref <-
  "https://makitani.net/shimauma/knowledge/regional-classification-of-japan" %>%
  rvest::read_html() %>%
  rvest::html_table() %>%
  `[[`(1) %>%
  magrittr::set_colnames(c("region", "pref")) %>%
  tidyr::separate(pref, into = letters[1:9], sep = "、") %>%
  tidyr::pivot_longer(-region, names_to = "tmp", values_to = "pref", values_drop_na = TRUE) %>%
  dplyr::select(-tmp) %>%
  dplyr::mutate(region = stringr::str_replace(region, "九州沖縄", "九州")) %>%
  dplyr::bind_rows(tibble::tibble(region = "その他", pref = "その他"))

region_pref_2 <-  # for test
  c("北海道"  ,  "北海道",
    "岩手県"  ,  "東北"  ,
    "宮城県"  ,  "東北"  ,
    "山形県"  ,  "東北"  ,
    "秋田県"  ,  "東北"  ,
    "青森県"  ,  "東北"  ,
    "福島県"  ,  "東北"  ,
    "茨城県"  ,  "関東"  ,
    "群馬県"  ,  "関東"  ,
    "埼玉県"  ,  "関東"  ,
    "神奈川県",  "関東"  ,
    "千葉県"  ,  "関東"  ,
    "東京都"  ,  "関東"  ,
    "栃木県"  ,  "関東"  ,
    "愛知県"  ,  "中部"  ,
    "岐阜県"  ,  "中部"  ,
    "山梨県"  ,  "中部"  ,
    "新潟県"  ,  "中部"  ,
    "静岡県"  ,  "中部"  ,
    "石川県"  ,  "中部"  ,
    "長野県"  ,  "中部"  ,
    "富山県"  ,  "中部"  ,
    "福井県"  ,  "中部"  ,
    "三重県"  ,  "近畿"  ,
    "京都府"  ,  "近畿"  ,
    "滋賀県"  ,  "近畿"  ,
    "大阪府"  ,  "近畿"  ,
    "奈良県"  ,  "近畿"  ,
    "兵庫県"  ,  "近畿"  ,
    "和歌山県",  "近畿"  ,
    "岡山県"  ,  "中国"  ,
    "広島県"  ,  "中国"  ,
    "山口県"  ,  "中国"  ,
    "鳥取県"  ,  "中国"  ,
    "島根県"  ,  "中国"  ,
    "愛媛県"  ,  "四国"  ,
    "香川県"  ,  "四国"  ,
    "高知県"  ,  "四国"  ,
    "徳島県"  ,  "四国"  ,
    "沖縄県"  ,  "九州"  ,
    "宮崎県"  ,  "九州"  ,
    "熊本県"  ,  "九州"  ,
    "佐賀県"  ,  "九州"  ,
    "鹿児島県",  "九州"  ,
    "大分県"  ,  "九州"  ,
    "長崎県"  ,  "九州"  ,
    "福岡県"  ,  "九州"  ,
    "その他"  ,  "その他") %>%
  matrix(ncol = 2, byrow = TRUE) %>%
  tibble::as_tibble() %>%
  magrittr::set_colnames(c("pref", "region"))

region_pref %>%  # test
  dplyr::anti_join(region_pref_2, by="region")

station_pref_city <- 
  "https://www.data.jma.go.jp/obd/stats/data/mdrr/chiten/sindex2.html" %>%
  rvest::read_html() %>%
  rvest::html_table() %>%
  `[[`(1) %>%
  dplyr::select(1:4) %>%
  magrittr::set_colnames(c("yomi", "station", "pref", "city")) %>%
  bind_rows(tibble::tibble(yomi = "アソサン", station = "阿蘇山", pref = "熊本県", city = "南阿蘇村"))
station_pref_city$pref[station_pref_city$station == "昭和"] <- "その他"

  # join
station_jp <-
  climate_jp %>%
  dplyr::mutate_all(stringi::stri_unescape_unicode) %>%
  distinct(no, station, altitude, latitude, longitude, NS, WE) %>%
  dplyr::left_join(station_pref_city) %>%
  dplyr::right_join(region_pref, .) %>%
  dplyr::mutate_all(stringi::stri_escape_unicode)

usethis::use_data(station_jp, overwrite = TRUE)

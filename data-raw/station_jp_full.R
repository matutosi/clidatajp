## code to prepare `station_jp_full` dataset goes here
  # Japan: station, region, prefecture
library(tidyverse)
devtools::load_all(".")

domain <- "https://www.data.jma.go.jp/obd/stats/etrn/select/"
html <- 
  stringr::str_c(domain, "prefecture00.php?prec_no=&block_no=&year=&month=&day=&view=") %>%
  rvest::read_html() %>%
  rvest::html_elements("map") %>%
  rvest::html_elements("area")
href <- 
  html %>%
  rvest::html_attr("href") %>%
  stringr::str_c(domain, .)
prec_name <- rvest::html_attr(html, "alt")
station <- tibble::tibble()

  #   href <- head(href)
for(i in seq_along(href)){
  sleep()
  print(stringr::str_c(i, " / ", length(href)))
  station <- 
    href[[i]] %>%
    rvest::read_html() %>%
    rvest::html_elements("map") %>%
    rvest::html_elements("area") %>%
    paste0(rvest::html_attr(., "alt"), rvest::html_attr(., "onmouseover")) %>%
    unique() %>%
    tibble::tibble(html = ., prec = prec_name[i]) %>%
    dplyr::bind_rows(station, .)
}

station  # ここから整理するべし
cols <- 
  c("station", NA, "prec_no", "station_no", NA, NA, NA, "yomi", 
    "lat_1", "lat_2", "lon_1", "lon_2", "altitude", 
    "precipitation", "wind", "temperature", "sunshine", "snow", "moisture", 
    "year", "month", "day", 
    "memo_1", "memo_2", "memo_3", "memo_4", "memo_5")

station_jp_full <- 
  station %>%
  dplyr::mutate(html = html %>%
    stringr::str_remove_all('\\\"|\\\'|\\(|\\)|&amp') %>%
    stringr::str_remove_all('\\n.+') %>%
    stringr::str_replace_all(".+alt=(.+) *coords.+prec_no=([0-9]+);block_no=([0-9]+);year=.+onmouseover=javascript:viewPoint(.+); onmouseout.+", "\\1 \\2 \\3 \\4") %>%
    stringr::str_replace_all(' ', ',')) %>%
  dplyr::filter(!stringr::str_detect(html, "^<area,shape=")) %>%
  dplyr::distinct() %>%
  tidyr::separate(html, into = cols, sep=",") %>%
  dplyr::mutate_at(vars(!matches("station|yomi|memo|prec")), as.numeric) %>%
  dplyr::mutate(latitude  = lat_1 + (lat_2 / 60), 
                longitude = lon_1 + (lon_2 / 60), 
                end_date  = stringr::str_c(year, month, day, sep = "-"), 
                memo      = stringr::str_c(memo_1, memo_2, memo_3, memo_4, memo_5),
                .keep = "unused") %>%
  dplyr::mutate_if(is.character, stringi::stri_escape_unicode) %>%
  dplyr::filter(!(prec_no == "49" & station_no == "47639")) %>%  # 富士山頂が2つあるため(静岡と山梨)，山梨を削除
  print()

usethis::use_data(station_jp_full, overwrite = TRUE)

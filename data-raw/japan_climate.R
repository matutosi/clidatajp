  # use_data_raw("japan_climate")  # Generate a new file like this
## code to prepare `world_climate` dataset goes here

library(tidyverse)
devtools::load_all(".")

  #  #  #  #  #  #  #  #  #  #  #  #  # 
  # 
  # summary
  # 
  #  #  #  #  #  #  #  #  #  #  #  #  # 

  # download zip
url <- "https://www.data.jma.go.jp/obd/stats/data/mdrr/normal/2020/20210324/normal_surface_summary.zip"
dl_file <- "normal_surface_summary.zip"
curl::curl_download(url, dl_file)
  # unzip
exdir <- "/normal_surface_summary/"
      # to avoid garbage character
cmd <- stringr::str_c("unzip ", dl_file, " -d ", getwd(), exdir)
system(cmd)

  # file names
files <- dir(path = stringr::str_c(".", exdir))
old <-  stringr::str_detect(files, "旧") & !stringr::str_detect(files, "新") & !stringr::str_detect(files, "他")
new <- !stringr::str_detect(files, "旧") &  stringr::str_detect(files, "新") & !stringr::str_detect(files, "他")
old_files <- files[old]
new_files <- files[new]

  # clean up data
clean_climate_jp <- function(x_files, period){
  item <- stringr::str_sub(x_files, end = 2)
  climate <- 
    stringr::str_c(".", exdir, x_files) %>%
    purrr::map(readr::read_csv, locale = locale(encoding = "CP932"), show_col_types = FALSE) %>%
    purrr::map(dplyr::select, 1:14) %>%
    purrr::map(magrittr::set_colnames, c("no", "station", 1:12)) %>%
    purrr::map(dplyr::mutate_at, 3:14, as_numeric_without_warnings)
  climate <- 
    purrr::map2(climate, item, ~dplyr::mutate(.x, "item" := .y)) %>%
    purrr::map(tidyr::pivot_longer, 
        cols = !c(no, station, item), 
        names_to = "month", values_to = "value") %>%
    dplyr::bind_rows() %>%
    dplyr::mutate(item = stringr::str_replace_all(item, "気温", "temperature"  )) %>%
    dplyr::mutate(item = stringr::str_replace_all(item, "降水", "precipitation")) %>%
    dplyr::mutate(item = stringr::str_replace_all(item, "降雪", "snowfall"     )) %>%
    dplyr::mutate(item = stringr::str_replace_all(item, "日照", "insolation"   )) %>%
    tidyr::pivot_wider(id_cols = c(no, station, month), names_from = item, values_from = value) %>%
    dplyr::mutate(month = as.numeric(month)) %>%
    dplyr::mutate("country" := "日本") %>%
    dplyr::mutate("period" := period)
  return(climate)
}

old_climate <- clean_climate_jp(old_files, period = "1981-2010")
new_climate <- clean_climate_jp(new_files, period = "1991-2020")

unlink(dl_file)
unlink(stringr::str_c(".", exdir), recursive = TRUE)


  #  #  #  #  #  #  #  #  #  #  #  #  # 
  # 
  # station
  # 
  #  #  #  #  #  #  #  #  #  #  #  #  # 

  # download zip
url <- "https://www.data.jma.go.jp/obd/stats/data/mdrr/normal/2020/data/normal_surface.zip"
dl_file <- "normal_surface.zip "
curl::curl_download(url, dl_file)
  # unzip
exdir <- "/normal_surface/"
unzip_file <- "normal_surface/surface_station_index.csv"
      # to avoid garbage character
cmd <- stringr::str_c("unzip ", dl_file, unzip_file, " -d ", getwd(), exdir)
system(cmd)


files <- stringr::str_c(unzip_file)
cols <- c("no", "lat_deg", "lat_min", "lon_deg", "lon_min", "altitude")
station <- 
  stringr::str_c(".", exdir, files) %>%
  readr::read_csv(col_select = c(1, 5:9), locale = locale(encoding = "CP932"), show_col_types = FALSE) %>%
  tail(-1) %>%
  dplyr::mutate_all(as.numeric) %>%
  magrittr::set_colnames(cols) %>%
  dplyr::group_by(no) %>%
  dplyr::mutate(latitude = lat_deg + lat_min / 60, longitude = lon_deg + lon_min / 60)

ns <- tibble("NS" := c(rep("N", nrow(station) -1), "S"))  # "S": Antarctica
station <- 
  station %>%
  dplyr::bind_cols(ns) %>%
  dplyr::mutate("WE" := "E")

unlink(dl_file)
unlink(stringr::str_c(".", exdir), recursive = TRUE)


  #  #  #  #  #  #  #  #  #  #  #  #  # 
  # 
  # unify and save
  # 
  #  #  #  #  #  #  #  #  #  #  #  #  # 
japan_climate <-
  dplyr::bind_rows(new_climate, old_climate) %>%
  dplyr::left_join(station) %>%
  dplyr::select(-c(lat_deg, lat_min, lon_deg, lon_min))

usethis::use_data(japan_climate, overwrite = TRUE)

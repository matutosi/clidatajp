## code to prepare `climate_jp_full` dataset goes here

devtools::load_all(".")
library(tidyverse)
data(station_jp_full)

  # data(station_jp)
  # station_jp <-
  #   station_jp %>%
  #   dplyr::mutate_if(is.character, stringi::stri_unescape_unicode)
  # station_jp_full <-
  #   station_jp_full %>%
  #   dplyr::mutate_if(is.character, stringi::stri_unescape_unicode) 
  # station_jp %>%
  #   left_join(station_jp_full, by = c("no" = "station_no")) %>%
  #   print()
  # station_jp_full

gen_url <- function(prec_no, station_no){
  len <- stringr::str_length(station_no)
  sfc_amd <- if(len == 5) "sfc" else "amd"
  stringr::str_c(
    "https://www.data.jma.go.jp/obd/stats/etrn/view/nml_",
    sfc_amd,
    "_ym.php?prec_no=",
    prec_no,
    "&block_no=",
    station_no,
    "&year=&month=&day=&view="
  )
}

  # 5桁：nml_sfc_ym
  # https://www.data.jma.go.jp/obd/stats/etrn/view/nml_sfc_ym.php?prec_no=11&block_no=47401&year=&month=&day=&view=
  # 4桁：nml_amd_ym
  # https://www.data.jma.go.jp/obd/stats/etrn/view/nml_amd_ym.php?prec_no=11&block_no=0002&year=&month=&day=&view=
download_mean_cli <- function(prec_no, station_no){
  sleep()
  html <- 
    gen_url(prec_no, station_no) %>%
    rvest::read_html()
    # 1066：伊吹山でエラー
  has_mean_data <-
    html %>%
    rvest::html_text() %>%
    stringr::str_detect("平年値（年・月ごとの値）の計算はしておりません") %>%
    `!`
  if(has_mean_data){
    mean_data <- 
      html %>%
      rvest::html_table() %>%
      `[[`(5) %>%
      dplyr::bind_cols(tibble::tibble(station_no = station_no)) %>%
      return()
  } else {
    mean_data <- NULL
  }
  return(mean_data)
}
  # get_mean_cli("11", "0002")
  # get_mean_cli("11", "47401")
  # get_mean_cli(station_jp_full$prec_no[1066], station_jp_full$station_no[1066])


mean_cli <- list()
for(i in seq_along(station_jp_full$prec_no)){
  print(stringr::str_c(i, " / ", length(station_jp_full$prec_no)))
  mean_cli[[i]] <- download_mean_cli(station_jp_full$prec_no[i], station_jp_full$station_no[i])
}

  # gen_url("11", "0002") %>%
  #   rvest::read_html() %>%
  #   rvest::html_table() %>%
  #   `[[`(5)
  # gen_url("11", "47401") %>%
  #   rvest::read_html() %>%
  #   rvest::html_table() %>%
  #   `[[`(5)
  # 
  # station_jp_full %>%
  #   filter(wind == 0 & temperature == 0) %>%
  #   .$station_no %>%
  #   str_length() %>%
  #   stem()

  # for(i in which(map_dbl(mean_cli, is.null) == 1)){
  #   mean_cli[[i]] <- tibble::tibble()
  # }
  # mean_cli %>%
  #   map_dbl(ncol) %>%
  #   hist()
  # mean_cli %>%
  #   map_dbl(nrow) %>%
  #   hist()

  # 3パターンの対応が必要
  # mean_cli[[1]]
  # mean_cli[[2]]
  # mean_cli[[1066]]

clean_climate_21_cols <- function(climate){
  # climate <- mean_cli[[1]]
  cols <- 
    c("month", 
      "air_pressure_land", "air_pressure_sea", "precipitation", 
      "temperature", "temperature_max", "temperature_min",
      "steam_pressure", "moisture", 
      "wind_speed", "wind_direction", 
      "sunshine", "global_solar_radiation", 
      "snow_fall", "snow_fall_max_per_day", "snow_deepest", 
      "cloud_cover", 
      "days_of_snow", "days_of_fog", "days_of_thunderstorm",
      "station_no")
  climate <- magrittr::set_colnames(climate, cols)
  period  <- dplyr::slice(climate, 3)
  climate <- dplyr::slice(climate, -(1:4)) 
  return(climate)
  #     tidyr::pivot_longer(cols = -month, names_to = "item", values_to = "value")
}

clean_climate_10_cols <- function(climate){
  # climate <- mean_cli[[2]]
  cols <- 
    c("month", 
      "precipitation", 
      "temperature", "temperature_max", "temperature_min", 
      "wind_speed", "sunshine", 
      "snow_fall", "snow_deepest", 
      "station_no")
  climate <- magrittr::set_colnames(climate, cols)
  period  <- dplyr::slice(climate, 1)
  climate <- dplyr::slice(climate, -(1:2)) 
  return(climate)
}
  # ncol(mean_cli[[1066]])

  # tmp <- 
  #   dplyr::bind_rows(clean_climate_21_cols(mean_cli[[1]]),
  #             clean_climate_10_cols(mean_cli[[2]]),
  #             mean_cli[[1066]])
  # tmp %>%
  #   print(n=nrow(.))

clean_climate <- function(climate){
  if(ncol(climate) == 21) return(clean_climate_21_cols(climate))
  if(ncol(climate) == 10) return(clean_climate_10_cols(climate))
  if(ncol(climate) == 0)  return(climate)
}

  # clean_climate(mean_cli[[1]])
  # clean_climate(mean_cli[[2]])
  # clean_climate(mean_cli[[1066]])

climate_jp_full <- 
  mean_cli %>%
  purrr::map(clean_climate) %>%
  dplyr::bind_rows()

usethis::use_data(climate_jp_full, overwrite = TRUE)


## 

climate_jp_full %>%
  dplyr::filter(month == "年") %>%
  dplyr::filter(precipitation != "///") %>%
  dplyr::filter(temperature   != "///")

climate_jp_full %>%
  dplyr::filter(month == "年") %>%
  dplyr::filter(precipitation != "///") %>%
  dplyr::filter(temperature   != "///") %>%
  dplyr::mutate_at(c("precipitation", "temperature"), as.numeric) %>%
  dplyr::filter(is.na(temperature)) %>%
  dplyr::filter(is.na(precipitation)) %>%
  select(station_no)  # 47821

climate_jp_full %>%
  dplyr::filter(month == "年") %>%
  dplyr::filter(precipitation != "///") %>%
  dplyr::filter(temperature   != "///") %>%
  dplyr::mutate_at(c("precipitation", "temperature"), as.numeric) %>%
  ggplot(aes(temperature, precipitation)) + 
    geom_point()
  #   dplyr::arrange(temperature) %>%
  #   print() %>%
  #   dplyr::arrange(desc(temperature)) %>%
  #   print() %>%
  #   dplyr::arrange(precipitation) %>%
  #   print() %>%
  #   dplyr::arrange(desc(precipitation))

  # climate_jp_full %>%
  #   filter(station_no == "47821")


data(station_jp_full)
station_jp_full <- 
  station_jp_full %>%
  dplyr::mutate_if(is.character, stringi::stri_unescape_unicode) %>%
  dplyr::select(-c(temperature, precipitation))

gg <- 
  climate_jp_full %>%
  dplyr::filter(month == "年") %>%
  dplyr::filter(precipitation != "///") %>%
  dplyr::filter(temperature   != "///") %>%
  dplyr::left_join(station_jp_full, by = "station_no") %>%
  dplyr::mutate_at(c("precipitation", "temperature"), as.numeric) %>%
  ggplot()

gg + 
  geom_point(aes(longitude, latitude, colour = precipitation)) + 
  scale_colour_gradient2(low = "yellow", mid = "gray", high = "blue", midpoint = 2000) + 
  theme_bw()

gg + 
  geom_point(aes(precipitation, latitude, colour = altitude)) + 
  theme_bw()

gg + 
  geom_point(aes(temperature, latitude, colour = altitude)) + 
  theme_bw()

climate_jp_full %>%
  dplyr::filter(month == "年") %>%
  dplyr::filter(precipitation != "///") %>%
  dplyr::filter(temperature   != "///") %>%
  dplyr::left_join(station_jp_full, by = "station_no") %>%
  dplyr::mutate_at(c("precipitation", "temperature"), as.numeric) %>%
  ggplot() + 
    geom_point(aes(longitude, latitude, colour = precipitation)) + 
    scale_colour_gradientn(colours = c("yellow", "green", "blue", "darkblue", "black")) + 
    theme_bw()

data(climate_jp)
climate_jp


cli_year <- 
  climate_jp_full %>%
  dplyr::filter(month == "年") %>%
  transmute(station_no, temperature = as.numeric(temperature))

cli_mean <- 
  climate_jp_full %>%
  dplyr::filter(month != "年") %>%
  group_by(station_no) %>%
  dplyr::summarize(temperature = mean(as.numeric(temperature)))

climate_jp <- 
  climate_jp %>%
  transmute(station_no = as.character(no), temperature) %>%
  group_by(station_no) %>%
  dplyr::summarize(temperature = mean(as.numeric(temperature)))

cli_year %>%
  left_join(cli_mean, by = "station_no") %>%
  left_join(climate_jp, by = "station_no") %>%
  na.omit()


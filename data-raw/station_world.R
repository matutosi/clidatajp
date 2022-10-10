## code to prepare `station_world` dataset goes here
library(tidyverse)
devtools::load_all(".")
data(climate_world)

## world
cols <- c("no", "station", "continent", "country", "region", "pref", "altitude", "latitude", "longitude", "NS", "WE")
station_world <- 
  climate_world %>%
  dplyr::mutate_all(stringi::stri_unescape_unicode) %>%
  dplyr::mutate(station = stringr::str_replace(station, "(.+)_(.+)", "\\1")) %>%
  dplyr::select(any_of(cols)) %>%
  dplyr::distinct()

usethis::use_data(station_world, overwrite = TRUE)

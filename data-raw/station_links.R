## code to prepare `station_links` dataset goes here
  # use_data_raw("station_links")  # Generate this file

library(tidyverse)
station_links <-
  readr::read_tsv("tools/station_links.tsv", show_col_types = FALSE) %>%
  dplyr::mutate_all(stringi::stri_escape_unicode)
usethis::use_data(station_links, overwrite = TRUE)

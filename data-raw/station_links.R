  # use_data_raw("station_links")  # Generate this file
## code to prepare `station_links` dataset goes here

library(tidyverse)
station_links <-
  readr::read_tsv("data-raw/station_links.tsv", show_col_types = FALSE) %>%
  dplyr::mutate_all(stringi::stri_escape_unicode)
usethis::use_data(station_links, overwrite = TRUE)

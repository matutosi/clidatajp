  # use_data_raw("climate_world")  # Generate this file
## code to prepare `climate_world` dataset goes here

library(tidyverse)
climate_world <-
  readr::read_tsv("data-raw/climate_world.tsv", show_col_types = FALSE) %>%
  dplyr::mutate_if(is.character, stringi::stri_escape_unicode)
usethis::use_data(climate_world, overwrite = TRUE)

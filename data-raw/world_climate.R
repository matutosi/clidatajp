  # use_data_raw("world_climate")  # Generate this file
## code to prepare `world_climate` dataset goes here

library(tidyverse)
world_climate <-
  readr::read_tsv("tools/world_climate.tsv", show_col_types = FALSE) %>%
  dplyr::mutate_all(stringi::stri_escape_unicode)
usethis::use_data(world_climate, overwrite = TRUE)

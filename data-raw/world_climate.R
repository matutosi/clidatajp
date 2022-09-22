  # use_data_raw("world_climate")  # Generate this file
## code to prepare `world_climate` dataset goes here

library(tidyverse)

world_climate <-
  readr::read_tsv("tools/world_climate.tsv", show_col_types = FALSE) %>%
  dplyr::mutate_all(stringi::stri_escape_unicode)
usethis::use_data(world_climate, overwrite = TRUE)

  # OLD VERSION
  # 
  # library(tidyverse)
  # data(station_links)
  # cols <- 
  #     c("station", "country", "latitude", "NS", "longitude", "WE", "altitude")
  # sep <- 
  #   "\\u5ea6\\uff1a|\\u00b0" %>%
  #   stringi::stri_unescape_unicode()
  # sep <- stringr::str_c("\\s+.", sep)
  # station_links <- 
  #   station_links %>%
  #   `$`(station) %>%
  #   stringi::stri_unescape_unicode() %>%
  #   map(stringr::str_replace_all, "\\s+"           , " "          ) %>%
  #   map(stringr::str_replace_all, "- \\(m\\)"      , "NA"         ) %>%
  #   map(stringr::str_replace_all, "-(\\d+) \\(m\\)", "minus\\1"   ) %>%
  #   map(stringr::str_replace_all, " \\(m\\)"       , ""           ) %>%
  #   map(stringr::str_replace_all, "(.+)-(.+)-(.+)" , "\\1_\\2:\\3") %>%
  #   map(stringr::str_replace_all, " - "            , ":"          ) %>%
  #   map(stringr::str_replace_all, sep              , ":"          ) %>%
  #   map(stringr::str_replace_all, "minus"          , "-"          ) %>%
  #   map(tibble::as_tibble) %>%
  #   map(tidyr::separate, value, into = cols, sep = ":") %>%
  #   map(dplyr::mutate, station = stringr::str_c(station, "_", country)) %>%
  #   dplyr::bind_rows() %>%
  #   dplyr::mutate(no = 1:nrow(station_links))
  # 
  # world_climate <-
  #   readr::read_tsv("tools/world_climate.tsv", show_col_types = FALSE) %>%
  #   dplyr::select(no, month, temperature, precipitation) %>%
  #   dplyr::left_join(station_links) %>%
  #   dplyr::mutate_at(
  #         all_of(c("no", "month", "temperature", "precipitation", "latitude", "longitude", "altitude")),
  #         as_numeric_without_warnings) %>%
  #   dplyr::mutate_if(is.character, stringi::stri_escape_unicode)

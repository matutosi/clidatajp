#' Donwload climate data of the world. 
#' 
#' For polite scraping, 5 sec interval is set in donwload_climate(), 
#' it takes over 5 hours to get climate data of all stations. 
#' Please use existing links by "data(world_climate)", 
#' if you do not need to renew climate data. 
#' You can see web page as below. 
#' https://www.data.jma.go.jp/gmd/cpd/monitor/nrmlist/
#' 
#' @name donwload_climate
#' @param url  A String to specify target html.
#' @return     a
#' @examples
#' # If you want all climate data, remove head().
#' library(tidyverse)
#' data(station_links)
#' station_links <-
#'   station_links %>%
#'   head() %>%
#'   `$`("url")
#' 
#' climate <- list()
#' for(i in seq_along(station_links)){
#'   climate[i] <- donwload_climate(station_links[i])
#' }
#' 
#' 
#' 
#' 
#' 
#' 
#' 
#' 
#' @export
donwload_climate <- function(url){
  sleep()
  html <- 
    url %>%
    rvest::read_html()
  station <- 
    html %>%
    rvest::html_elements("#main") %>%
    rvest::html_elements("h3") %>%
    rvest::html_text() %>%
    clean_station()
  climate <- 
    html %>%
    rvest::html_elements("#main") %>%
    rvest::html_table() %>%
    `[[`(1) %>%
    magrittr::set_colnames(c("month" , "temperature", "precipitation")) %>%
    dplyr::mutate_all(as_numeric_without_warnings) %>%
    utils::tail(-1)
  combined <- 
    dplyr::bind_cols(station, climate) %>%
    dplyr::mutate(url = url)
  return(combined)
}

#' @rdname download_climate
#' @export
clean_station <- function(text){
  cols <- 
      c("station", "country", "latitude", "NS", "longitude", "WE", "altitude")
  sep <- 
    "\\u5ea6\\uff1a|\\u00b0" %>%
    stringi::stri_unescape_unicode()
  sep <- stringr::str_c("\\s+.", sep)
  cleaned_text <- 
    text %>%
    map(stringr::str_replace_all, "\\s+"           , " "          ) %>%
    map(stringr::str_replace_all, "- \\(m\\)"      , "NA"         ) %>%
    map(stringr::str_replace_all, "-(\\d+) \\(m\\)", "minus\\1"   ) %>%
    map(stringr::str_replace_all, " \\(m\\)"       , ""           ) %>%
    map(stringr::str_replace_all, "(.+)-(.+)-(.+)" , "\\1_\\2:\\3") %>%
    map(stringr::str_replace_all, " - "            , ":"          ) %>%
    map(stringr::str_replace_all, sep              , ":"          ) %>%
    map(stringr::str_replace_all, "minus"          , "-"          ) %>%
    map(tibble::as_tibble) %>%
    map(tidyr::separate, .data[["value"]], into = cols, sep = ":") %>%
    map(dplyr::mutate, 
        "station" := 
        stringr::str_c(.data[["station"]], "_", .data[["country"]]))
  return(cleaned_text)
}


clean_station <- function(text){
  cols <- c("station", "country", "latitude", "NS", "longitude", "WE", "altitude")
  text %>%
    stringr::str_replace_all("\\s+"                 , " "             ) %>%
    stringr::str_replace_all("高度：- \\(m\\)"      , "高度：NA"      ) %>%
    stringr::str_replace_all("高度：-(\\d+) \\(m\\)", "高度：minus\\1") %>%
    stringr::str_replace_all(" \\(m\\)"             , ""              ) %>%
    stringr::str_replace_all("(.+)-(.+)-(.+)"       , "\\1_\\2:\\3"   ) %>%
    stringr::str_replace_all(" - "                  , ":"             ) %>%
    stringr::str_replace_all("\\s+[緯経高]度：|°"  , ":"             ) %>%
    stringr::str_replace_all("minus"                , "-"             ) %>%
    tibble::as_tibble() %>%
    tidyr::separate(.data[["value"]], into = cols, sep = ":") %>%
      # to avoid dupulication (stations have same name)
    dplyr::mutate("station" := stringr::str_c(.data[["station"]], "_", .data[["country"]]))
}

#' @rdname download_climate
#' @export
clean_station <- function(text){
  cols <- 
    c("station", "country", "latitude", "NS", "longitude", "WE", "altitude")
  sep <- "\\s+.\\u5ea6\\uff1a|\\u00b0"
  text %>%
    stringi::stri_escape_unicode() %>%
    stringr::str_replace_all("\\s+"           , " "          ) %>%
    stringr::str_replace_all("- \\(m\\)"      , "NA"         ) %>%
    stringr::str_replace_all("-(\\d+) \\(m\\)", "minus\\1"   ) %>%
    stringr::str_replace_all(" \\(m\\)"       , ""           ) %>%
    stringr::str_replace_all("(.+)-(.+)-(.+)" , "\\1_\\2:\\3") %>%
    stringr::str_replace_all(" - "            , ":"          ) %>%
    stringr::str_replace_all(sep              , ":"          ) %>%
    stringr::str_replace_all("minus"          , "-"          ) %>%
    tibble::as_tibble() %>%
    tidyr::separate(.data[["value"]], into = cols, sep = ":") %>%
  # to avoid dupulication (stations have same name)
    dplyr::mutate("station" := stringr::str_c(.data[["station"]], "_", .data[["country"]]))
}

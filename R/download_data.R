generate_area_links <- function(n_area = 6){
  # https://www.data.jma.go.jp/gmd/cpd/monitor/nrmlist/
  "https://www.data.jma.go.jp/gmd/cpd/monitor/nrmlist/CountryList.php?rcode=" %>%
    stringr::str_c(stringr::str_pad(1:n_area, width = 2, pad = "0"))
}
donwload_links <- function(url){
  sleep()
  url %>%
    rvest::read_html() %>%
    rvest::html_elements("#main") %>%
    rvest::html_elements("a") %>% 
    rvest::html_attr("href") %>%
    stringr::str_c("https://www.data.jma.go.jp/gmd/cpd/monitor/nrmlist/", .)
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
    tidyr::separate(value, into = cols, sep = ":") %>%
    dplyr::mutate(station = stringr::str_c(station, "_", country))  # to avoid dupulication (stations have same name)
}


  # 
  # stringi::stri_escape_unicode(".度：")  # ".\\u5ea6\\uff1a"
  # stringi::stri_escape_unicode("°")     # "\\u00b0"

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
    tidyr::separate(value, into = cols, sep = ":") %>%
  # to avoid dupulication (stations have same name)
    dplyr::mutate(station = stringr::str_c(station, "_", country))
}

donwload_station_climate <- function(url){
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

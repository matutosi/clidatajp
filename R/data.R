#' Climate data in the world
#' 
#' Climate data donwloaded from Japan Meteorological Agency web pages.
#' URLs of each station are listed in data(station_links).
#' https://www.data.jma.go.jp/gmd/cpd/monitor/nrmlist/
#' 
#' @format A data frame with 41328 (3444 stations * 12 months) rows 
#' and 11 variable: 
#' \describe{
#'   \item{no           }{Id number}
#'   \item{month        }{Month}
#'   \item{temperature  }{Mean temperature}
#'   \item{precipitation}{Mean precipitation}
#'   \item{station      }{Station name. To avoid dupulication, including country nameafter station name. Can split by "_". Escaped by stringi::stri_escape_unicode().}
#'   \item{country      }{Country name. Escaped by stringi::stri_escape_unicode().}
#'   \item{latitude     }{Latitude. (degree)}
#'   \item{NS           }{North or South.}
#'   \item{longitude    }{Longitude. (degree)}
#'   \item{WE           }{West or East.}
#'   \item{altitude     }{Altitude (m)}
#' }
#' @examples
#' library(tidyverse)
#' data(world_climate)
#' world_climate %>%
#'   dplyr::mutate_all(stringi::stri_unescape_unicode)
"world_climate"

#' Station name and its URL
#'
#' @format A data frame with  3444 rows and 3 variable: 
#' \describe{
#'   \item{no           }{Id number}
#'   \item{station      }{Station information including no, month, temperature, precipitation, station, country, latitude, NS, longitude, WE, altitude. The information is NOT cleaned Row information donwloaded from each URL. Escaped by stringi::stri_escape_unicode().}
#'   \item{url         }{URL of station.}
#' }
#' @examples
#' library(tidyverse)
#' data(station_links)
#' station_links %>%
#'   dplyr::mutate_all(stringi::stri_unescape_unicode)
"station_links"

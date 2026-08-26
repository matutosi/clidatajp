# Download climate data of the world

For polite scraping, 5 sec interval is set in download_climate(), it
takes over 5 hours to get climate data of all stations. Please use
existing links by "data(climate_world)", if you do not need to renew
climate data. You can see web page as below.
https://www.data.jma.go.jp/gmd/cpd/monitor/nrmlist/

## Usage

``` r
download_climate(url)
```

## Arguments

- url:

  A String to specify target html.

## Value

A tibble including climate and station information, or NULL when failed.

## Examples

``` r
# If you want all climate data, remove head().
# The codes take > 5 sec because of poliste scraping.
# \donttest{
library(magrittr)
library(stringi)
library(dplyr)
data(station_links)
station_links <-
  station_links %>%
  dplyr::mutate_all(stringi::stri_unescape_unicode) %>%
  head(3) %T>%
  { 
     continent <<- `$`(., "continent") 
     no        <<- `$`(., "no") 
  } %>%
  `$`("url")

climate <- list()
for(i in seq_along(station_links)){
  print(stringr::str_c(i, " / ", length(station_links)))
  climate[[i]] <- download_climate(station_links[i])
}
#> [1] "1 / 3"
#> [1] "2 / 3"
#> [1] "3 / 3"
  # run only when download_climate() successed
if(sum(is.null(climate[[1]]), 
       is.null(climate[[2]]), 
       is.null(climate[[3]])) == 0){
  month_per_year <- 12
  climate_world <- 
    dplyr::bind_rows(climate) %>%
    dplyr::bind_cols(
      tibble::tibble(continent = rep(continent, month_per_year))) %>%
    dplyr::bind_cols(
      tibble::tibble(no        = rep(no,        month_per_year))) %>%
    dplyr::relocate(no, continent, country, station)
  climate_world
}
#> # A tibble: 36 × 13
#>    no    continent country station latitude NS    longitude WE    altitude month
#>    <chr> <chr>     <chr>   <chr>   <chr>    <chr> <chr>     <chr> <chr>    <dbl>
#>  1 60560 アフリカ  アルジェリア… アインセフラ… 32.77    N     0.60      W     1058         1
#>  2 60620 アフリカ  アルジェリア… アインセフラ… 32.77    N     0.60      W     1058         2
#>  3 60369 アフリカ  アルジェリア… アインセフラ… 32.77    N     0.60      W     1058         3
#>  4 60560 アフリカ  アルジェリア… アインセフラ… 32.77    N     0.60      W     1058         4
#>  5 60620 アフリカ  アルジェリア… アインセフラ… 32.77    N     0.60      W     1058         5
#>  6 60369 アフリカ  アルジェリア… アインセフラ… 32.77    N     0.60      W     1058         6
#>  7 60560 アフリカ  アルジェリア… アインセフラ… 32.77    N     0.60      W     1058         7
#>  8 60620 アフリカ  アルジェリア… アインセフラ… 32.77    N     0.60      W     1058         8
#>  9 60369 アフリカ  アルジェリア… アインセフラ… 32.77    N     0.60      W     1058         9
#> 10 60560 アフリカ  アルジェリア… アインセフラ… 32.77    N     0.60      W     1058        10
#> # ℹ 26 more rows
#> # ℹ 3 more variables: temperature <dbl>, precipitation <dbl>, url <chr>
# }
```

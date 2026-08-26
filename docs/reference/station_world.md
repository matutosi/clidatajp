# Climate stations of the world

Climate stations of the world

## Usage

``` r
station_world
```

## Format

A data frame with 3444 rows and 9 variable:

- no :

  Station no

- station :

  Station name. To avoid duplication, including country name after
  station name. Can split by "\_". Escaped by
  stringi::stri_escape_unicode().

- continent :

  Continent. Escaped by stringi::stri_escape_unicode().

- country :

  Country name. Escaped by stringi::stri_escape_unicode().

- altitude :

  Altitude (m)

- latitude :

  Latitude (degree)

- NS :

  North or South.

- longitude :

  Longitude (degree)

- WE :

  West or East

## Examples

``` r
library(magrittr)
library(stringi)
library(dplyr)
data(station_world)
station_world %>%
  dplyr::mutate_all(stringi::stri_unescape_unicode)
#> # A tibble: 3,444 × 9
#>    no    station       continent country altitude latitude longitude NS    WE   
#>    <chr> <chr>         <chr>     <chr>   <chr>    <chr>    <chr>     <chr> <chr>
#>  1 60560 アインセフラ  アフリカ  アルジェリア… 1058     32.77    0.6       N     W    
#>  2 60620 アドラル      アフリカ  アルジェリア… 279      27.88    0.18      N     W    
#>  3 60369 アルジェ      アフリカ  アルジェリア… 9        36.77    3.1       N     E    
#>  4 60360 アンナバ      アフリカ  アルジェリア… 3        36.83    7.82      N     E    
#>  5 60611 イナメナス    アフリカ  アルジェリア… 561      28.05    9.63      N     E    
#>  6 60640 イリジ        アフリカ  アルジェリア… 543      26.5     8.42      N     E    
#>  7 60690 インゲザム    アフリカ  アルジェリア… 400      19.57    5.77      N     E    
#>  8 60630 インサラー    アフリカ  アルジェリア… 268      27.23    2.5       N     E    
#>  9 60559 ウェド        アフリカ  アルジェリア… 64       33.5     6.78      N     E    
#> 10 60421 ウームエルブワギー…… アフリカ  アルジェリア… 889      35.87    7.12      N     E    
#> # ℹ 3,434 more rows
```

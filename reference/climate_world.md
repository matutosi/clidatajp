# Climate data in the world

Climate data downloaded from Japan Meteorological Agency web pages. URLs
of each station are listed in data(station_links).
https://www.data.jma.go.jp/gmd/cpd/monitor/nrmlist/

## Usage

``` r
climate_world

world_climate
```

## Format

A data frame with 41328 (3444 stations \* 12 months) rows and 12
variable:

- no :

  Station no

- continent :

  Continent. Escaped by stringi::stri_escape_unicode().

- country :

  Country name. Escaped by stringi::stri_escape_unicode().

- station :

  Station name. To avoid duplication, including country name after
  station name. Can split by "\_". Escaped by
  stringi::stri_escape_unicode().

- month :

  Month

- temperature :

  Mean temperature

- precipitation:

  Mean precipitation

- latitude :

  Latitude. (degree)

- NS :

  North or South.

- longitude :

  Longitude. (degree)

- WE :

  West or East.

- altitude :

  Altitude (m)

An object of class `tbl_df` (inherits from `tbl`, `data.frame`) with
41328 rows and 12 columns.

## Examples

``` r
library(magrittr)
library(stringi)
library(dplyr)
data(world_climate)
world_climate %>%
  dplyr::mutate_all(stringi::stri_unescape_unicode)
#> # A tibble: 41,328 × 12
#>    no    continent country      station month temperature precipitation latitude
#>    <chr> <chr>     <chr>        <chr>   <chr> <chr>       <chr>         <chr>   
#>  1 60560 アフリカ  アルジェリア アインセフラ… 1     7.1         14.9          32.77   
#>  2 60560 アフリカ  アルジェリア アインセフラ… 2     9.2         11.2          32.77   
#>  3 60560 アフリカ  アルジェリア アインセフラ… 3     12.9        15.9          32.77   
#>  4 60560 アフリカ  アルジェリア アインセフラ… 4     16.8        16.9          32.77   
#>  5 60560 アフリカ  アルジェリア アインセフラ… 5     21.5        15            32.77   
#>  6 60560 アフリカ  アルジェリア アインセフラ… 6     26.7        6.9           32.77   
#>  7 60560 アフリカ  アルジェリア アインセフラ… 7     31          4.1           32.77   
#>  8 60560 アフリカ  アルジェリア アインセフラ… 8     29.5        13.5          32.77   
#>  9 60560 アフリカ  アルジェリア アインセフラ… 9     24.4        21            32.77   
#> 10 60560 アフリカ  アルジェリア アインセフラ… 10    18.6        25.8          32.77   
#> # ℹ 41,318 more rows
#> # ℹ 4 more variables: NS <chr>, longitude <chr>, WE <chr>, altitude <chr>
```

# Climate data in Japan

Climate data downloaded from Japan Meteorological Agency web pages. URLs
of each station are listed in data(station_links).
https://www.data.jma.go.jp/gmd/cpd/monitor/nrmlist/

## Usage

``` r
climate_jp

japan_climate
```

## Format

A data frame with 3768 (157 stations \* 12 months \* 2 periods) rows and
14 variable:

- no :

  Station no

- month :

  Month

- period :

  Period of observations

- temperature :

  Mean temperature

- precipitation:

  Mean precipitation

- snowfall :

  Mean snowfall

- insolation :

  Mean insolation

- station :

  Station name. To avoid duplication, including country name after
  station name. Can split by "\_". Escaped by
  stringi::stri_escape_unicode().

- country :

  Country name. Escaped by stringi::stri_escape_unicode().

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
3768 rows and 14 columns.

## Examples

``` r
library(magrittr)
library(stringi)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
data(japan_climate)
japan_climate %>%
  dplyr::mutate_all(stringi::stri_unescape_unicode)
#> # A tibble: 3,768 × 14
#>    no    station month temperature precipitation snowfall insolation country
#>    <chr> <chr>   <chr> <chr>       <chr>         <chr>    <chr>      <chr>  
#>  1 47401 稚内    1     -4.3        84.6          129      40.6       日本   
#>  2 47401 稚内    2     -4.3        60.6          105      74.7       日本   
#>  3 47401 稚内    3     -0.6        55.1          68       137.5      日本   
#>  4 47401 稚内    4     4.5         50.3          9        173.5      日本   
#>  5 47401 稚内    5     9.1         68.1          0        181.6      日本   
#>  6 47401 稚内    6     13          65.8          NA       154.6      日本   
#>  7 47401 稚内    7     17.2        100.9         NA       142.7      日本   
#>  8 47401 稚内    8     19.5        123.1         NA       150.7      日本   
#>  9 47401 稚内    9     17.2        136.7         NA       172.1      日本   
#> 10 47401 稚内    10    11.3        129.7         1        134.6      日本   
#> # ℹ 3,758 more rows
#> # ℹ 6 more variables: period <chr>, altitude <chr>, latitude <chr>,
#> #   longitude <chr>, NS <chr>, WE <chr>
```

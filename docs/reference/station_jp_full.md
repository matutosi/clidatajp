# All stations in Japan

Station information downloaded from Japan Meteorological Agency web
pages. data(station_jp) includes only 157 stations of climate data,
while this data includes all 1673 stations. A pair of prec_no and
station_no specifies a station in detail_url() and download_detail().
Note that station_no of "kansho" (weather station) has 5 digits (159
stations) and that of "AMeDAS" has 4 digits (1514 stations).
https://www.data.jma.go.jp/obd/stats/etrn/index.php

## Usage

``` r
station_jp_full
```

## Format

A data frame with 1673 rows and 16 variables:

- station :

  Station name. Escaped by stringi::stri_escape_unicode().

- prec_no :

  Area no of 'JMA'. Escaped by stringi::stri_escape_unicode().

- station_no :

  Station no of 'JMA', which is used as block_no in detail_url().
  Escaped by stringi::stri_escape_unicode().

- yomi :

  Pronunciation in Japanese. Escaped by stringi::stri_escape_unicode().

- altitude :

  Altitude (m)

- precipitation:

  Flag of observation (1: observed, 0: not observed). Character, not
  numeric.

- wind :

  Flag of observation (1: observed, 0: not observed)

- temperature :

  Flag of observation (1: observed, 0: not observed)

- sunshine :

  Flag of observation (1: observed, 0: not observed)

- snow :

  Flag of observation (1: observed, 0: not observed)

- moisture :

  Flag of observation (1: observed, 0: not observed)

- prec :

  Area name of prec_no. Escaped by stringi::stri_escape_unicode().

- latitude :

  Latitude (degree)

- longitude :

  Longitude (degree)

- end_date :

  Date of the end of observation. "9999-99-99" shows that the station is
  in operation (1287 stations). Escaped by
  stringi::stri_escape_unicode().

- memo :

  Note of 'JMA'. Escaped by stringi::stri_escape_unicode().

## Examples

``` r
library(magrittr)
library(stringi)
library(dplyr)
data(station_jp_full)
station_jp_full %>%
  head_3() %>%
  dplyr::mutate_if(is.character, stringi::stri_unescape_unicode)
#> # A tibble: 3 × 16
#>   station prec_no station_no yomi       altitude precipitation  wind temperature
#>   <chr>   <chr>   <chr>      <chr>         <dbl> <chr>         <dbl>       <dbl>
#> 1 稚内    11      47401      ワツカナイ      2.8 1                 1           1
#> 2 沓形    11      0002       クツガタ       14   1                 1           1
#> 3 浜頓別  11      0003       ハマトンベツ……     18   1                 1           1
#> # ℹ 8 more variables: sunshine <dbl>, snow <dbl>, moisture <dbl>, prec <chr>,
#> #   latitude <dbl>, longitude <dbl>, end_date <chr>, memo <chr>
```

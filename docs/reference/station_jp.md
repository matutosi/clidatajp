# Climate stations in Japan

Climate stations in Japan

## Usage

``` r
station_jp
```

## Format

A data frame with 157 rows and 11 variable:

- region :

  Region. Escaped by stringi::stri_escape_unicode().

- pref :

  Prefecture. Escaped by stringi::stri_escape_unicode()

- no :

  Station no.

- station :

  Station name. To avoid duplication, including country name after
  station name. Can split by "\_". Escaped by
  stringi::stri_escape_unicode().

- altitude :

  Altitude. (m)

- latitude :

  Latitude. (degree)

- longitude :

  Longitude. (degree)

- NS :

  North or South.

- WE :

  West or East.

- yomi :

  Pronunciation in Japanese. Escaped by stringi::stri_escape_unicode()

- city :

  City name. Escaped by stringi::stri_escape_unicode().

## Examples

``` r
library(magrittr)
library(stringi)
library(dplyr)
data(station_jp)
station_jp %>%
  dplyr::mutate_all(stringi::stri_unescape_unicode)
#> # A tibble: 157 × 11
#>    region pref   no    station  altitude latitude    longitude NS    WE    yomi 
#>    <chr>  <chr>  <chr> <chr>    <chr>    <chr>       <chr>     <chr> <chr> <chr>
#>  1 北海道 北海道 47401 稚内     2.8      45.415      141.6783… N     E     ワッカナ…
#>  2 北海道 北海道 47402 北見枝幸 6.7      44.94       142.585   N     E     キタミエ…
#>  3 北海道 北海道 47404 羽幌     7.9      44.3633333… 141.7     N     E     ハボロ……
#>  4 北海道 北海道 47405 雄武     14.1     44.58       142.9633… N     E     オウム……
#>  5 北海道 北海道 47406 留萌     23.6     43.945      141.6316… N     E     ルモイ……
#>  6 北海道 北海道 47407 旭川     119.8    43.7566666… 142.3716… N     E     アサヒカ…
#>  7 北海道 北海道 47409 網走     37.6     44.0166666… 144.2783… N     E     アバシリ…
#>  8 北海道 北海道 47411 小樽     24.9     43.1816666… 141.015   N     E     オタル……
#>  9 北海道 北海道 47412 札幌     17.4     43.06       141.3283… N     E     サッポロ…
#> 10 北海道 北海道 47413 岩見沢   42.3     43.2116666… 141.785   N     E     イワミザ…
#> # ℹ 147 more rows
#> # ℹ 1 more variable: city <chr>
```

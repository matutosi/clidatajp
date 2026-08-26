# Station name and its URL

Station name and its URL

## Usage

``` r
station_links
```

## Format

A data frame with 3444 rows and 4 variable:

- no :

  Station no

- station :

  Station information including no, month, temperature, precipitation,
  station, country, latitude, NS, longitude, WE, altitude. The
  information is NOT cleaned Row information downloaded from each URL.
  Escaped by stringi::stri_escape_unicode().

- url :

  URL of station.

- continent :

  Continent. Escaped by stringi::stri_escape_unicode().

## Examples

``` r
library(magrittr)
library(stringi)
library(dplyr)
data(station_links)
station_links %>%
  dplyr::mutate_all(stringi::stri_unescape_unicode)
#> # A tibble: 3,444 × 4
#>    no    station                                                 url   continent
#>    <chr> <chr>                                                   <chr> <chr>    
#>  1 60560 アインセフラ - アルジェリア   緯度：32.77°N   経度：0.60°W   高度：1058 (m)… http… アフリカ 
#>  2 60620 アドラル - アルジェリア   緯度：27.88°N   経度：0.18°W   高度：279 (m)…… http… アフリカ 
#>  3 60369 アルジェ - アルジェリア   緯度：36.77°N   経度：3.10°E   高度：9 (m)…… http… アフリカ 
#>  4 60360 アンナバ - アルジェリア   緯度：36.83°N   経度：7.82°E   高度：3 (m)…… http… アフリカ 
#>  5 60611 イナメナス - アルジェリア   緯度：28.05°N   経度：9.63°E   高度：561 (m)…… http… アフリカ 
#>  6 60640 イリジ - アルジェリア   緯度：26.50°N   経度：8.42°E   高度：543 (m)…… http… アフリカ 
#>  7 60690 インゲザム - アルジェリア   緯度：19.57°N   経度：5.77°E   高度：400 (m)…… http… アフリカ 
#>  8 60630 インサラー - アルジェリア   緯度：27.23°N   経度：2.50°E   高度：268 (m)…… http… アフリカ 
#>  9 60559 ウェド - アルジェリア   緯度：33.50°N   経度：6.78°E   高度：64 (m)…… http… アフリカ 
#> 10 60421 ウームエルブワギー - アルジェリア   緯度：35.87°N   経度：7.12°E   高度：889 (… http… アフリカ 
#> # ℹ 3,434 more rows
```

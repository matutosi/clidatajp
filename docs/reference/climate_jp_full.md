# Climate normals of all stations in Japan

Monthly normals downloaded from Japan Meteorological Agency web pages
for all stations in data(station_jp_full). Values are raw strings of the
web pages, because they include marks of 'JMA' ("@", ")", "\]" and "#"
show quality of the value, "///" and "—" show no value). Use
as_numeric_without_warnings() after removing the marks, or use
download_detail(), which cleans the marks. Stations of "AMeDAS" have no
value in 11 of the columns, because only 10 items are observed.
https://www.data.jma.go.jp/obd/stats/etrn/index.php

## Usage

``` r
climate_jp_full

climate_jp_full_tmp
```

## Format

A data frame with 21697 rows (1669 stations \* 13 rows) and 21
variables. All variables are character.

- month :

  Month (1 to 12) or yearly value. Escaped by
  stringi::stri_escape_unicode().

- air_pressure_land :

  Mean air pressure on land (hPa)

- air_pressure_sea :

  Mean air pressure on sea level (hPa)

- precipitation :

  Mean precipitation (mm)

- temperature :

  Mean temperature (degree Celsius)

- temperature_max :

  Mean of daily maximum temperature (degree Celsius)

- temperature_min :

  Mean of daily minimum temperature (degree Celsius)

- steam_pressure :

  Mean steam pressure (hPa)

- moisture :

  Mean relative humidity (percent)

- wind_speed :

  Mean wind speed (m/s)

- wind_direction :

  Most frequent wind direction. Escaped by
  stringi::stri_escape_unicode().

- sunshine :

  Mean sunshine duration (hour)

- global_solar_radiation:

  Mean global solar radiation (MJ/m^2)

- snow_fall :

  Mean snow fall (cm)

- snow_fall_max_per_day :

  Mean of daily maximum snow fall (cm)

- snow_deepest :

  Mean of deepest snow (cm)

- cloud_cover :

  Mean cloud cover

- days_of_snow :

  Mean days of snow

- days_of_fog :

  Mean days of fog

- days_of_thunderstorm :

  Mean days of thunderstorm

- station_no :

  Station no. Can be joined to station_no of data(station_jp_full).
  Escaped by stringi::stri_escape_unicode().

An object of class `tbl_df` (inherits from `tbl`, `data.frame`) with
21697 rows and 21 columns.

## Examples

``` r
library(magrittr)
library(stringi)
library(dplyr)
data(climate_jp_full)
climate_jp_full %>%
  head_3() %>%
  dplyr::mutate_if(is.character, stringi::stri_unescape_unicode)
#> # A tibble: 3 × 21
#>   month air_pressure_land air_pressure_sea precipitation temperature
#>   <chr> <chr>             <chr>            <chr>         <chr>      
#> 1 1月   1010.7            1012.2           84.6          -4.3       
#> 2 2月   1011.3            1012.8           60.6          -4.3       
#> 3 3月   1010.4            1011.9           55.1          -0.6       
#> # ℹ 16 more variables: temperature_max <chr>, temperature_min <chr>,
#> #   steam_pressure <chr>, moisture <chr>, wind_speed <chr>,
#> #   wind_direction <chr>, sunshine <chr>, global_solar_radiation <chr>,
#> #   snow_fall <chr>, snow_fall_max_per_day <chr>, snow_deepest <chr>,
#> #   cloud_cover <chr>, days_of_snow <chr>, days_of_fog <chr>,
#> #   days_of_thunderstorm <chr>, station_no <chr>
```

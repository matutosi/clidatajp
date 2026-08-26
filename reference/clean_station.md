# Clean up station information

Helper function for download_climate().

## Usage

``` r
clean_station(station)
```

## Arguments

- station:

  A String of station information.

## Value

A tibble including station information.

## Examples

``` r
data(station_links)
station_links %>%
  head(1) %>%
  `$`("station") %>%
  stringi::stri_unescape_unicode() %>%
  clean_station()
#> # A tibble: 1 × 7
#>   station                   country      latitude NS    longitude WE    altitude
#>   <chr>                     <chr>        <chr>    <chr> <chr>     <chr> <chr>   
#> 1 アインセフラ_アルジェリア アルジェリア 32.77    N     0.60      W     1058    
```

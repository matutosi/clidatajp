# Download prec_no and block_no of stations in Japan

A station of detail climate data is specified by a pair of prec_no
(area) and block_no (station). download_prec_no() downloads all prec_no,
and download_block_no() downloads block_no of the area. Please use
existing data by "data(station_jp_full)", which includes prec_no and
station_no of all stations, if you do not need to renew them. For polite
scraping, 5 sec interval is set in both functions. You can see web page
as below. https://www.data.jma.go.jp/obd/stats/etrn/index.php

## Usage

``` r
download_prec_no()

download_block_no(prec_no)
```

## Arguments

- prec_no:

  A string or numeric of area no.

## Value

download_prec_no(): a tibble of prec_no and area. download_block_no(): a
tibble of prec_no, block_no, station and type. NULL when failed.

## Examples

``` r
# \donttest{
prec_no <- download_prec_no()
prec_no
#> # A tibble: 61 × 2
#>    prec_no area                
#>    <chr>   <chr>               
#>  1 11      宗谷地方            
#>  2 12      上川地方            
#>  3 13      留萌地方            
#>  4 14      石狩地方            
#>  5 15      空知地方            
#>  6 16      後志地方            
#>  7 17      網走・北見・紋別地方
#>  8 18      根室地方            
#>  9 19      釧路地方            
#> 10 20      十勝地方            
#> # ℹ 51 more rows
download_block_no(61)
#> # A tibble: 27 × 4
#>    prec_no block_no station type  
#>    <chr>   <chr>    <chr>   <chr> 
#>  1 61      0588     峰山    amedas
#>  2 61      0589     宮津    amedas
#>  3 61      47750    舞鶴    kansho
#>  4 61      0591     仏坂    amedas
#>  5 61      0592     浅原山  amedas
#>  6 61      0593     福知山  amedas
#>  7 61      0594     胡麻    amedas
#>  8 61      0595     妙高山  amedas
#>  9 61      0596     園部    amedas
#> 10 61      47759    京都    kansho
#> # ℹ 17 more rows
# }
```

# Download detail climate data in Japan

For polite scraping, 5 sec interval is set in download_detail(). Please
do not download too many data at once. Use detail_url() to build an url
of the data.

## Usage

``` r
download_detail(url, as_numeric = TRUE)
```

## Arguments

- url:

  A string to specify target html.

- as_numeric:

  A logical. If TRUE, columns of numbers are converted into numeric.
  Marks of 'JMA' for missing values are treated as NA.

## Value

A tibble including detail climate data, or NULL when failed.

## Examples

``` r
# \donttest{
url <- detail_url(61, 47759, "daily", 2023, 6)
download_detail(url)
#> # A tibble: 30 × 22
#>       日 `気圧(hPa)_現地_平均` `気圧(hPa)_海面_平均` `降水量(mm)_合計`
#>    <dbl>                 <dbl>                 <dbl>             <dbl>
#>  1     1                 1005                  1011.              14.5
#>  2     2                  996.                 1002.              92.5
#>  3     3                  998.                 1004.               0  
#>  4     4                 1004.                 1010.              NA  
#>  5     5                 1005.                 1011.              NA  
#>  6     6                 1003                  1009.               1  
#>  7     7                 1003.                 1010.               0  
#>  8     8                 1003.                 1009.              14  
#>  9     9                  999.                 1005.              22.5
#> 10    10                 1004.                 1010.              NA  
#> # ℹ 20 more rows
#> # ℹ 18 more variables: `降水量(mm)_最大_1時間` <dbl>,
#> #   `降水量(mm)_最大_10分間` <dbl>, `気温(℃)_平均` <dbl>, `気温(℃)_最高` <dbl>,
#> #   `気温(℃)_最低` <dbl>, `湿度(％)_平均` <dbl>, `湿度(％)_最小` <dbl>,
#> #   `風向・風速(m/s)_平均風速` <dbl>, `風向・風速(m/s)_最大風速_風速` <dbl>,
#> #   `風向・風速(m/s)_最大風速_風向` <chr>,
#> #   `風向・風速(m/s)_最大瞬間風速_風速` <dbl>, …
# }
```

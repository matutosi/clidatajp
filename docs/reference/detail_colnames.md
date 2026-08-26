# Helper functions for download_detail()

detail_colnames() joins header rows into column names,
clean_detail_value() removes marks of 'JMA' from values, and
to_numeric_when_all() converts a vector into numeric only when all
values can be converted.

## Usage

``` r
detail_colnames(header)

clean_detail_value(x)

to_numeric_when_all(x)
```

## Arguments

- header:

  A dataframe of header rows.

- x:

  A string vector of values.

## Value

detail_colnames(): a string vector of column names.
clean_detail_value(): a string vector. to_numeric_when_all(): a numeric
vector or a string vector.

## Examples

``` r
header <- data.frame(x = c("temperature", "temperature"),
                     y = c("temperature", "mean"))
detail_colnames(header)
#> [1] "temperature"      "temperature_mean"
clean_detail_value(c("21.6", "0.0 )", "--", "///"))
#> [1] "21.6" "0.0"  NA     NA    
to_numeric_when_all(c("21.6", "0.0", NA))
#> [1] 21.6  0.0   NA
to_numeric_when_all(c("21.6", "north"))
#> [1] "21.6"  "north"
```

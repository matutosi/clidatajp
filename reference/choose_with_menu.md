# Choose data with menu.

Choose data with menu.

## Usage

``` r
choose_with_menu(df, filter_cols, extract = NULL)
```

## Arguments

- df:

  A dataframe

- filter_cols:

  A string or string vector

- extract:

  A string

## Value

If extract is NULL, return a dataframe, else return a vector.

## Examples

``` r
if(interactive()){
  data(climate_world)
  climate_world <- 
    climate_world %>%
    dplyr::mutate_all(stringi::stri_unescape_unicode)
  
  choose_with_menu(climate_world, filter_cols = "continent")
  4  # input
  
  choose_with_menu(climate_world, filter_cols = c("continent", "country", "station"))
  4  # input
  3  # input
  2  # input
}
```

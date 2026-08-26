# Downloaded tables of climate normals in Japan

Raw tables downloaded from Japan Meteorological Agency web pages, before
cleaning into data(climate_jp_full). Kept for reproducibility of
data-raw/climate_jp_full.R. Each element is a table of a station of
data(station_jp_full), and the order of the elements is the same as the
rows of the data. Column names are not set, and the first rows are
headers of the web page.
https://www.data.jma.go.jp/obd/stats/etrn/index.php

## Usage

``` r
mean_cli
```

## Format

A list of 1673 tibbles.

- 21 columns:

  157 tables of "kansho" (weather station).

- 10 columns:

  1512 tables of "AMeDAS".

- NULL :

  4 stations, which have no normals.

## Examples

``` r
data(mean_cli)
length(mean_cli)
#> [1] 1673
dim(mean_cli[[1]])
#> [1] 17 21
```

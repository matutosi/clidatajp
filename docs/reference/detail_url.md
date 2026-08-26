# Build urls of detail climate data in Japan

Japan Meteorological Agency ('JMA') provides detail climate data
(yearly, monthly, daily, hourly and 10 minutes values) for each station.
detail_url() builds urls of the data, and download_detail() downloads
the data of the url. You can see web page as below.
https://www.data.jma.go.jp/obd/stats/etrn/index.php

## Usage

``` r
detail_url(
  prec_no,
  block_no,
  item = "daily",
  year = NULL,
  month = NULL,
  day = NULL
)

detail_item(item, block_no)
```

## Arguments

- prec_no:

  A string or numeric of area no.

- block_no:

  A string or numeric of station no. Keep leading zero of 'AMeDAS' as a
  string (ex. "0588").

- item:

  A string to specify data type. See details.

- year:

  A numeric or string of year.

- month:

  A numeric or string of month.

- day:

  A numeric or string of day.

## Value

        A string vector of urls.

## Details

A station is specified by a pair of prec_no (area) and block_no
(station). Use download_prec_no() and download_block_no() to get the
numbers. Note that block_no of "kansho" (weather station) has 5 digits
(ex. "47759") and that of "AMeDAS" has 4 digits (ex. "0588"). Suffix of
item ("\_s" or "\_a") is set to match the type of block_no.

item can be a short name in the following list, or a name of php file
without extension (ex. "daily_s1").

- annually :

  Yearly values.

- monthly :

  Monthly values in a year (year is required).

- monthly_all:

  Monthly values of all years ("kansho" only).

- daily :

  Daily values in a month (year and month are required).

- hourly :

  Hourly values in a day (year, month and day are required).

- 10min :

  10 minutes values in a day (year, month and day are required).

- nml_ym :

  Normals of each month.

- nml_daily :

  Normals of each day in a month (month is required).

- nml_season :

  Normals of first and last day of frost, snow and ice ("kansho" only).

## Examples

``` r
detail_url(61, 47759, "daily", 2023, 6)
#> [1] "https://www.data.jma.go.jp/obd/stats/etrn/view/daily_s1.php?prec_no=61&block_no=47759&year=2023&month=6&day=&view="
detail_url(61, "0588", "hourly", 2023, 6, 20)
#> [1] "https://www.data.jma.go.jp/obd/stats/etrn/view/hourly_a1.php?prec_no=61&block_no=0588&year=2023&month=6&day=20&view="
detail_url(61, 47759, "daily", 2023, 1:3)
#> [1] "https://www.data.jma.go.jp/obd/stats/etrn/view/daily_s1.php?prec_no=61&block_no=47759&year=2023&month=1&day=&view="
#> [2] "https://www.data.jma.go.jp/obd/stats/etrn/view/daily_s1.php?prec_no=61&block_no=47759&year=2023&month=2&day=&view="
#> [3] "https://www.data.jma.go.jp/obd/stats/etrn/view/daily_s1.php?prec_no=61&block_no=47759&year=2023&month=3&day=&view="
```

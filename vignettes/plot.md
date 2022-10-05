clidatajp
================

# 

``` r
library(tidyverse)
#> ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.2 ──
#> ✔ ggplot2 3.3.6      ✔ purrr   0.3.4 
#> ✔ tibble  3.1.8      ✔ dplyr   1.0.10
#> ✔ tidyr   1.2.1      ✔ stringr 1.4.1 
#> ✔ readr   2.1.2      ✔ forcats 0.5.2 
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
library(clidatajp)
```

``` r
data(world_climate)
data(japan_climate)

climate <- 
  dplyr::bind_rows(world_climate, japan_climate) %>%
  dplyr::mutate_if(is.character, stringi::stri_unescape_unicode)  %>%
  dplyr::group_by(station) %>%
  dplyr::filter(sum(is.na(temperature), is.na(precipitation)) == 0) %>%
  dplyr::filter(period != "1991-2020" | is.na(period))

climate <- 
  climate %>%
  dplyr::summarise(temp = mean(as.numeric(temperature)), prec = sum(as.numeric(precipitation))) %>%
  dplyr::left_join(dplyr::distinct(dplyr::select(climate, station:altitude))) %>%
  dplyr::left_join(tibble::tibble(NS = c("S", "N"), ns = c(-1, 1))) %>%
  dplyr::left_join(tibble::tibble(WE = c("W", "E"), we = c(-1, 1))) %>%
  dplyr::group_by(station) %>%
  dplyr::mutate(lat = latitude * ns, lon = longitude * we)
#> Joining, by = "station"
#> Joining, by = "NS"
#> Joining, by = "WE"

climate %>%
  ggplot(aes(lon, lat, colour = temp)) +
    scale_colour_gradient2(low = "blue", mid = "gray", high = "red", midpoint = 15) + 
    geom_point() + 
    theme_bw()
```

![](D:/dropbox/ToDo/clidatajp/vignettes/plot_files/figure-gfm/plot-1.png)<!-- -->

``` r
  # ggsave("temperature.png")

climate %>%
  dplyr::filter(prec < 4000) %>%
  ggplot(aes(lon, lat, colour = prec)) +
    scale_colour_gradient2(low = "yellow", mid = "gray", high = "blue", midpoint = 1500) + 
    geom_point() + 
    theme_bw()
```

![](D:/dropbox/ToDo/clidatajp/vignettes/plot_files/figure-gfm/plot-2.png)<!-- -->

``` r
  # ggsave("precipitation.png")

japan <- stringi::stri_unescape_unicode("\\u65e5\\u672c")
climate %>%
  dplyr::filter(country != japan) %>%
  ggplot(aes(temp, prec)) + 
  geom_point() + 
  theme_bw() + 
  theme(legend.position="none")
```

![](D:/dropbox/ToDo/clidatajp/vignettes/plot_files/figure-gfm/plot-3.png)<!-- -->

``` r
  # ggsave("climate_nojp.png")

climate %>%
  ggplot(aes(temp, prec)) + 
    geom_point() + 
    theme_bw()
```

![](D:/dropbox/ToDo/clidatajp/vignettes/plot_files/figure-gfm/plot-4.png)<!-- -->

``` r
  # ggsave("climate_all.png")

climate %>%
  dplyr::mutate(jp = (country == japan)) %>%
  ggplot(aes(temp, prec, colour = jp)) + 
    geom_point() + 
    theme_bw() +
    theme(legend.position="none")
```

![](D:/dropbox/ToDo/clidatajp/vignettes/plot_files/figure-gfm/plot-5.png)<!-- -->

``` r
  # ggsave("climate_compare_jp.png")
```

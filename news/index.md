# Changelog

## clidatajp 0.5.3

- 2026-08-26

- Add functions

  - [`wi()`](https://matutosi.github.io/clidatajp/reference/wi.md) and
    [`ci()`](https://matutosi.github.io/clidatajp/reference/wi.md)
    calculate warm index and cold index (Kira 1945).

- Add functions for detail climate data in Japan

  - [`detail_url()`](https://matutosi.github.io/clidatajp/reference/detail_url.md)
    builds urls of detail data (yearly, monthly, daily, hourly and 10
    minutes values).
  - [`download_detail()`](https://matutosi.github.io/clidatajp/reference/download_detail.md)
    downloads the data of the url.
  - [`download_prec_no()`](https://matutosi.github.io/clidatajp/reference/download_prec_no.md)
    and
    [`download_block_no()`](https://matutosi.github.io/clidatajp/reference/download_prec_no.md)
    get numbers to specify a station.

- Remove data

  - `climate_jp_full_tmp`, which was an intermediate data and identical
    to `climate_jp_full`. Use `climate_jp_full`.

- Update installation instructions to use ‘remotes’ package.

## clidatajp 0.5.2

CRAN release: 2023-03-05

- 2023-03-05

- Add data

  - `climate_station` include URL of 3444 stations
  - `station_jp` include information of 157 stations
  - `station_world` include information of 3444 stations

- Rename data

  - `japan_climate` to `climate_jp`
  - `world_climate` to `climate_world`

## clidatajp 0.5.1

CRAN release: 2022-11-05

- 2022-11-05

- Add graceful fail to match the CRAN policy:

  - ‘Packages which use Internet resources should fail gracefully with
    an informative message if the resource is not available or has
    changed (and not give a check warning nor error).’
  - Added graceful fail in download_climate(), download_area_links(),
    and download_links().
  - Improved tests.

## clidatajp 0.5.0

CRAN release: 2022-10-05

- 2022-10-05

- First release

  - `data(japan_climate)` include japan climate data from Japan
    Meteorological Agency (‘JMA’).
  - `data(world_climate)` include world climate data from ‘JMA’.
  - `data(station_links)` include station information and its links for
    ‘JMA’.
  - [`download_area_links()`](https://matutosi.github.io/clidatajp/reference/download_links.md)
    and `*`download_links()\` download links for climate data.
  - [`download_climate()`](https://matutosi.github.io/clidatajp/reference/download_climate.md)
    download climate data from ‘JMA’.

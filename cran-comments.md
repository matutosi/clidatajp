## Summary of the update

* This is an update of an existing package (0.5.2 -> 0.5.3).

* In this version I have:
    * Added functions for detail climate data in Japan:
      detail_url(), download_detail(), download_prec_no() and download_block_no().
      They fail gracefully with an informative message
      when the internet resource is not available,
      as download_climate() and download_links() already do.
    * Added functions for climate indices: wi() and ci().
    * Added documentation of the data sets, which had no documentation.
    * Removed a data set 'climate_jp_full_tmp',
      which was an intermediate data and identical to 'climate_jp_full'.

## Test environments

* local
    * Windows 11, R 4.6.1
* GitHub Actions (r-lib/actions)
    * macOS 15, R-release
    * Windows Server 2025, R-release
    * Ubuntu 24.04, R-release / R-devel / R-oldrel-1
* rhub::rhub_check()
    * Ubuntu 24.04, R-devel
    * macOS 15, R-devel
    * Windows Server 2025, R-devel
* devtools::check_win_devel()
    * Windows, R-devel (2026-08-24 r90445 ucrt)

## R CMD check results

There were 0 ERRORs, 0 WARNINGs, and 0 NOTEs on all environments above.

## Downstream dependencies

There are currently no downstream dependencies for this package.

## Resubmission

This is a resubmission. In this version I have:

* Added a link to the used webservices to the description field of DESCRIPTION file.
* Added \value to sleep.Rd.
* kept \dontrun{} in download_climate.R, download_links.R, 
  bacause the examples take < 5 sec for polite scraping (at least 5 sec interval).

# Test environments

* local
    * Windows 10, R 4.2.1
    * Mac OS 11 Big Sur, R 4.2.1
* devtools::check_rhub()
    * Windows Server 2022, R-devel, 64 bit
    * Ubuntu Linux 20.04.1 LTS, R-release, GCC
    * Fedora Linux, R-devel, clang, gfortran
* devtools::check_win_devel()

# R CMD check results

## On local check 

There were 0 errors  | 0 warnings  | 0 notes

## devtools::check_rhub() and devtools::check_win_devel()

There were 0 errors  | 0 warnings  | 3 notes

* checking CRAN incoming feasibility ... [14s] NOTE
  New submission
  Maintainer: 'Toshikazu Matsumura <matutosi@gmail.com>'

* checking for detritus in the temp directory ... NOTE
  Found the following files/directories:
    'lastMiKTeXException'

*  checking HTML version of manual ... NOTE
   Skipping checking HTML validation: no command 'tidy' found

# Downstream dependencies

There are currently no downstream dependencies for this package.

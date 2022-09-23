# Test environments

* local
    * Windows 10, R 4.2.1
    * Mac OS 11 Big Sur, R 4.2.1
* devtools::check_win_devel()
    * Windows Server 2022, R-devel, 64 bit
    * Ubuntu Linux 20.04.1 LTS, R-release, GCC
    * Fedora Linux, R-devel, clang, gfortran
* devtools::check_rhub()

# R CMD check results

## On local check 

There were 0 errors  | 0 warnings  | 0 notes

## devtools::check_win_devel() and devtools::check_rhub()

There were 0 errors  | 0 warnings  | 2 notes

* checking CRAN incoming feasibility ... [14s] NOTE
  New submission
  Maintainer: 'Toshikazu Matsumura <matutosi@gmail.com>'

* checking for detritus in the temp directory ... NOTE
  Found the following files/directories:
    'lastMiKTeXException'

# Downstream dependencies

There are currently no downstream dependencies for this package.

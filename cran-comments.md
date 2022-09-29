## Resubmission

This is a resubmission. In this version I have:

* Added a link to the used webservices to the description field of DESCRIPTION file.
* Added \value to sleep.Rd.
* Replaced \dontrun{} with \donottest{} download_climate.R, download_links.R and *.rd files.

# Test environments

* local
    * Windows 10, R 4.2.1
    * Mac OS 11 Big Sur, R 4.2.1
* devtools::check_rhub()
    * Windows Server 2022, R-devel, 64 bit
    * Ubuntu Linux 20.04.1 LTS, R-release, GCC
    * Fedora Linux, R-devel, clang, gfortran
* Could not test by devtools::check_win_devel()
    Error in curl::curl_fetch_memory(url, handle = h) : 
    Timeout was reached: [win-builder.r-project.org] Operation timed out after 10001 milliseconds with 0 out of 0 bytes received

# R CMD check results

## On local check 

There were 0 errors  | 0 warnings  | 0 notes

## devtools::check_rhub()

There were 0 errors  | 0 warnings  | 4 notes

* checking examples ... [5s/20s] NOTE
  Examples with CPU (user + system) or elapsed time > 5s

  Because of polite scraping (at least 5 sec interval).

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

## Correct version

* I recieved an e-mail as shown below. 
    Please see the problems shown on
    <https://cran.r-project.org/web/checks/check_results_clidatajp.html>.
    Please correct before 2022-11-16 to safely retain your package on CRAN.
    It seems we need to remind you of the CRAN policy:
    'Packages which use Internet resources should fail gracefully with an informative message
    if the resource is not available or has changed (and not give a check warning nor error).'
    This needs correction whether or not the resource recovers.
    The CRAN Team

* In this version I have:
      * Added graceful fail in download_climate(), download_area_links(), and download_links().
      * Improved tests.

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

## devtools::check_rhub()

There were 0 errors  | 0 warnings  | 3 notes

* checking for detritus in the temp directory ... NOTE
  Found the following files/directories:
    'lastMiKTeXException'

* checking examples ... [6s/19s] NOTE
  Examples with CPU (user + system) or elapsed time > 5s
                 user system elapsed
  japan_climate 1.995  0.086   7.341

* checking HTML version of manual ... NOTE
  Skipping checking HTML validation: no command 'tidy' found

# Downstream dependencies

There are currently no downstream dependencies for this package.

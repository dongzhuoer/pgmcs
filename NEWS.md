# pgmcs 0.3.2

## Minor improvements and fixes

1. shorten name of shiny App folder, avoid too long path for `remotes::install_git('.')`


# pgmcs 0.3.1

## Minor improvements and fixes

1. add `RNGversion('3.5.2')` to make vignette and shiny example reproduciable  
   > The default method for generating from a discrete uniform distribution (used in `sample()`, for instance) has been changed.  
   > --- [CHANGES IN R 3.6.0](https://cran.r-project.org/doc/manuals/r-devel/NEWS.html)


# pgmcs 0.3.0

## New features

1. improve documentation with pkgdown
1. add testthat


# pgmcs 0.2.1

## Minor improvements and fixes

1. fix package dependencies  (#1)


# pgmcs 0.2.0

## Breaking changes

1. Rename to `pgmcs`. (Thanks to someone for releasing a package with the same name to CRAN)

## New features

1. a new Shiny app which is much faster (Calculation is only performed after user has pressed the "Run" button).   

## Minor improvements and fixes

1. Polish app's style, make it into a 1366\*768 screen. (It should can if the user don't have too much thing up and down in the screen, such as toolbar, menubar. Anyway I don't make sure since I don't have a 1366\*768 laptop.)


# pgs 0.1.0

## New features

1. `population_simulation()` for one run
1. `demo_population_simulation()` for multiple runs at the same time
1. a Shiny app including demos. However, the speed is kinds of _slow_ since the result is updated in real time (e.g., when you slide a value from 10 to 1000, 20, 50, 120, 270, etc are also calculated) 

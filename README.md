# Overview

This package implements the simulation in 20.2 of _Genetics From Genes to Genomes, 5th_.



# Installation

```r
if (!('remotes' %in% .packages(T))) install.packages('remotes');
remotes::install_github('dongzhuoer/pgmcs');
```



# For developers

1. TO DO: replace **plyr** with **purr**

```r
remotes::install_github('dongzhuoer/pgmcs')

# https://www.shinyapps.io/admin/#/tokens
# comment `RETICULATE_PYTHON` in `~/.Renvrion`, I don't know why but it just cause error
rsconnect::deployApp('inst/shiny/pgmcs/', appName= 'population-genetics-monte-carlo-simulation', forceUpdate = T)
rsconnect::deployApp('inst/shiny/pgmcs2/',  appName= 'population-genetics-monte-carlo-simulation2', forceUpdate = T)
```

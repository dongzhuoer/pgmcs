# pgmcs
[![Build Status](https://travis-ci.com/dongzhuoer/pgmcs.svg?branch=master)](https://travis-ci.com/dongzhuoer/pgmcs)




## Overview

This package implements the simulation in 20.2 of "Genetics From Genes to Genomes, 5th".



## Install

```r
if (!('devtools' %in% .packages(T))) install.packages('devtools');
remotes::install_github('dongzhuoer/pgmcs');
```



## Usage

refer to `vignette('pgmcs')`.



## Deploy (for developer)

```r
remotes::install_github('dongzhuoer/pgmcs')

# https://www.shinyapps.io/admin/#/tokens
# comment `RETICULATE_PYTHON` in `~/.Renvrion`, I don't know why but it just cause error
rsconnect::deployApp('inst/shiny/pgmcs/', appName= 'population-genetics-monte-carlo-simulation', forceUpdate = T)
rsconnect::deployApp('inst/shiny/pgmcs/',  appName= 'population-genetics-monte-carlo-simulation2', forceUpdate = T)
```

> configuration is saved in the `rsconnect/` subdir under app folder



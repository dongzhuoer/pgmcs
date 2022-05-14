testthat::context('Testing population_simulation.R')
setwd(here::here(''))  # workspace is reset per file



testthat::test_that('population_simulation()', {
    set.seed(0)
    
    testthat::expect_identical(
        population_simulation(10, c(0, 10, 0)),
        c(0.5, 0.55, 0.7, 0.7, 0.65, 0.8, 1, 1, 1, 1)
    ) 
});

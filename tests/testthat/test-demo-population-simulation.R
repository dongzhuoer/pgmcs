testthat::context('Testing demo_population_simulation.R')
setwd(here::here(''))  # workspace is reset per file

testthat::test_that('demo_population_simulation()', {
    testthat::expect_true(T);

    set.seed(13);
    demo_population_simulation(6, 30, c(0, 10, 0), c(1, 1, 1), "Small population: Lots of genetic drift");

    set.seed(0);
    demo_population_simulation(6, 30, c(0, 500, 0), c(1, 1, 1), "Large population: Little genetic drift");

    set.seed(57);
    demo_population_simulation(6, 30, c(0, 500, 0), c(1,1,0.8), "Natural selection")
});

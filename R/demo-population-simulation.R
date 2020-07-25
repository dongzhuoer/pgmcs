#' @title run several population simulations
#'
#' @description 
#' run several population simulations and visualize the result, refer to `vignette('pgmcs')` for examples
#'
#' @details the underlying workhorse is [population_simulation()]
#'
#' @param nrun integer scalar. Number of simulation runs.
#' @inheritParams population_simulation
#' @param title string. Plot title.
#'
#' @return an ggplot object
#' @export
#'
#' @section Shiny app:
#' `shiny::runApp(system.file('shiny', package = 'pgs'))`
demo_population_simulation <- function(nrun, ngeneration, population, fitness, title) {
    plyr::ldply(1:nrun, function(i){
        data.frame(irun = i, igeneration = seq_len(ngeneration),
                   A.frequency = population_simulation(ngeneration, population, fitness))
    }) -> df;

    g <- ggplot2::ggplot(df, ggplot2::aes(x = igeneration, y = A.frequency, color = factor(irun))) +
        ggplot2::geom_line() +
        ggplot2::ylim(0,1) +
        ggplot2::scale_color_discrete(guide = ggplot2::guide_legend(title = 'run')) +
        ggplot2::labs(title = title, x = 'Generations from start (generation 0)', y = 'Frequency of allele A') +
        ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5, size = 15))

    if (ngeneration <= 100) g = g + ggplot2::geom_point();
    if (nrun > 10) g = g + ggplot2::theme(legend.position = 'none')
    g;
}
library(shiny)
library(pgmcs)



ui <- fluidPage(
    titlePanel('Population Genetics Monte Carlo Simulation, static mode'),

    includeCSS('style.css'),

    fluidRow(
        column(3, h3('')),
        column(3, h3('AA'), style = 'font-size:150%;text-align:center'),
        column(3, h3('Aa'), style = 'font-size:150%;text-align:center'),
        column(3, h3('aa'), style = 'font-size:150%;text-align:center')
    ),

    fluidRow(
        column(3, p('initial poppulation', style = 'font-size:150%;color:steelblue;text-align:center')),
        column(3, sliderInput('nAA', NULL, value = 0, min = 0, max = 1000, step = 1)),
        column(3, sliderInput('nAa', NULL, value = 10, min = 0, max = 1000, step = 1)),
        column(3, sliderInput('naa', NULL, value = 0, min = 0, max = 1000, step = 1))
    ),

    fluidRow(
        column(3, p('fitness value', style = 'font-size:150%;color:steelblue;text-align:center')),
        column(3, sliderInput('wAA', NULL, value = 1, min = 0, max = 1, step = 0.01)),
        column(3, sliderInput('wAa', NULL, value = 1, min = 0, max = 1, step = 0.01)),
        column(3, sliderInput('waa', NULL, value = 1, min = 0, max = 1, step = 0.01))
    ),

    fluidRow(
        column(2, sliderInput('nrun', h4('run'), value = 6, min = 1, max = 250, step = 1)),
        column(3, sliderInput('ngeneration', h4('generation'), value = 30, min = 10, max = 5000, step = 10)),
        column(5, textInput('title', h4('title'), value = 'Population Genetics Monte Carlo Simulation')),
        column(2, sliderInput('seed', h4('seed'), value = 0, min = 1, max = 100, step = 1))
    ),

    fluidRow(
        column(2, submitButton('Run Simulation', icon('play-circle'))),
        column(10, helpText(HTML('Go to <a href="/population-genetics-monte-carlo-simulation">dynamic mode</a>. The output will update in real time, and you will get a few pre-built demos from textbook and can reset to initial value. But the speed may be much <strong>slower</strong>.')))
    ),

    hr(),

    plotOutput(outputId = 'plot'),

    helpText(strong('Note:'), 'For Figure 20.13, I find it almost impossible to produce a figure which looks like that in the textbook (I run 1000 simulations but hadn\'t found even one). So I adjust 0.98 to 0.97.'),

    helpText(strong('Advanced:'), 'I made several restrictions to relieve the workload of the server, please refer to', a(href = 'https://github.com/dongzhuoer/pgmcs', 'https://github.com/dongzhuoer/pgmcs'), 'if you want to explore more possibilities'),

    helpText(strong('Bug Report:'), 'If you find any bugs, please tell me',
             a(href = 'mailto:dongzhuoer@mail.nankai.edu.cn?subject=Report a bug in pgmcs Shiny app', 'email'),
             a(href = 'https://github.com/dongzhuoer/pgmcs/issues/new', 'GitHub'))
)


server <- function(input, output, session) {

    update_plot <- function() {
        renderPlot({
            set.seed(input$seed);

            nrun <- input$nrun;
            ngeneration <- input$ngeneration;
            pupulation <- c(input$nAA, input$nAa, input$naa);
            fitness <- as.numeric(c(input$wAA, input$wAa, input$waa));
            title <- input$title;

            demo_population_simulation(nrun, ngeneration, pupulation, fitness, title);
        }) -> output$plot;
    }

    update_plot();

    observeEvent(input$run, update_plot());
}



shinyApp(ui = ui, server = server);

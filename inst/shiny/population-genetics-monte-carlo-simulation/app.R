library(shiny)
library(pgmcs)



ui <- fluidPage(
    titlePanel('Population Genetics Monte Carlo Simulation, dynamic mode'),

    includeCSS('style.css'),

    fluidRow(
        column(3, h3('')),
        column(3, h3('AA'), style = 'font-size:150%;text-align:center'),
        column(3, h3('Aa'), style = 'font-size:150%;text-align:center'),
        column(3, h3('aa'), style = 'font-size:150%;text-align:center')
    ),

    fluidRow(
        column(3, p('initial poppulation', style = 'font-size:150%;color:steelblue;text-align:center')),
        column(3, sliderInput('nAA', NULL, value = 0, min = 0, max = 500, step = 1)),
        column(3, sliderInput('nAa', NULL, value = 0, min = 0, max = 500, step = 1)),
        column(3, sliderInput('naa', NULL, value = 0, min = 0, max = 500, step = 1))
    ),

    fluidRow(
        column(3, p('fitness value', style = 'font-size:150%;color:steelblue;text-align:center')),
        column(3, sliderInput('wAA', NULL, value = 0, min = 0, max = 1, step = 0.01)),
        column(3, sliderInput('wAa', NULL, value = 0, min = 0, max = 1, step = 0.01)),
        column(3, sliderInput('waa', NULL, value = 0, min = 0, max = 1, step = 0.01))
    ),

    fluidRow(
        column(2, sliderInput('nrun', h4('run'), value = 0, min = 1, max = 100, step = 1)),
        column(3, sliderInput('ngeneration', h4('generation'), value = 0, min = 5, max = 1000, step = 5)),
        column(5, textInput('title', h4('title'))),
        column(2, sliderInput('seed', h4('seed'), value = 0, min = 1, max = 100, step = 1))
    ),

    fluidRow(
        column(1, actionButton('run_again', 'Run again', icon('play-circle'))),
        column(1, actionButton('reset', 'Reset', icon('refresh'))),
        column(1, actionButton('fig20.8a', '20.8 (a)')),
        column(1, actionButton('fig20.8b', '20.8 (b)')),
        column(1, actionButton('fig20.13-1', '20.13')),
        column(1, actionButton('fig20.13-2', '20.13')),
        column(6, helpText(HTML('Go to <a href="/population-genetics-monte-carlo-simulation2">static mode</a>. The output will not update in real time, so the speed is much <strong>faster</strong>.')))
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
    update_element <- function(nrun, ngeneration, title, seed , nAA, nAa, naa, wAA, wAa, waa){
        updateNumericInput(session, 'nrun', value = nrun);
        updateNumericInput(session, 'ngeneration', value = ngeneration);
        updateNumericInput(session, 'seed', value = seed);
        updateTextInput(session, 'title', value = title);
        updateNumericInput(session, 'nAA', value = nAA);
        updateNumericInput(session, 'nAa', value = nAa);
        updateNumericInput(session, 'naa', value = naa);
        updateNumericInput(session, 'wAA', value = wAA);
        updateNumericInput(session, 'wAa', value = wAa);
        updateNumericInput(session, 'waa', value = waa);
    }

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

    reset <- function() {
        update_element(6 ,30, 'Population Genetics Monte Carlo Simulation', 0, 0, 10, 0, 1, 1, 1);
        update_plot();
    }

    example <- function(...) {
        update_element(...);
        update_plot();
    }

    reset();

    observeEvent(input$run_again, {update_plot(); updateNumericInput(session, 'seed', value = sample(1:1000, 1));});
    observeEvent(input$reset, reset());

    observeEvent(input$fig20.8a,
                 example(6, 30, 'Figure 20.8 (a) Small population: Lots of genetic drift',
                         13, 0, 10, 0, 1, 1, 1)
    );

    observeEvent(input$fig20.8b,
                 example(6, 30, 'Figure 20.8 (b) Large population: Little genetic drift',
                         0, 0, 500, 0, 1, 1, 1)
    );

    observeEvent(input$`fig20.13-1`,
                 example(6, 900, 'Figure 20.13 Natural selection together with genetic drift for Small Population',
                         57, 0, 1, 499, 1, 1, 0.97)
    );

    observeEvent(input$`fig20.13-2`,
                 example(6, 900, 'Figure 20.13 Natural selection together with genetic drift for Small Population',
                         885, 0, 1, 499, 1, 1, 0.97)
    );
}



shinyApp(ui = ui, server = server);

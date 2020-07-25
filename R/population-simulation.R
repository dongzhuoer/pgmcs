#' @title simulate genetic drift in a finite population
#'
#' @description simulate genetic drift in a finite population for one gene with two alleles
#'
#' @param ngeneration integer scalar. Number of generations
#' @param population integer vector. How many dominant homozygotes, heterozygotes, and recessive homozygotes do the initial population contain. For example, `c(2, 5, 3)` means 2 AA, 5 Aa and 3 aa.
#' @param fitness numeric vector. The fitness value of AA, Aa and aa. `c(1, 1, 1)` means no natural selection.
#'
#' @return numeric vector. The frequency of allele A.
#'
#' @examples
#' population_simulation(30, c(0, 10, 0))
#'
#' @export
population_simulation <- function(ngeneration, population, fitness = c(1, 1, 1)) {
    population <- rep(c('AA', 'Aa', 'aa'), population);
    n <- length(population);             # population size
    A.frequency <- numeric(ngeneration); # to store allele frequency

    for (i in seq_len(ngeneration)) {
        A.frequency[i] = mean(ifelse(population == 'AA', 1, ifelse(population == 'aa', 0, 0.5)))

        ## function for generate m offspring
        ## m must >= 1
        reproduce <- function(population, m) {
            ## we don't consider gender here, so mother and father can be the same individual
            gamete <- function(parent) {
                ifelse(parent == 'AA', 'A', ifelse(parent == 'aa', 'a', sample(c('A', 'a'), m, T)))
            }

            parent = sample(population, 2*m, T);

            father = parent[seq(1, 2*m, 2)];
            mather = parent[seq(2, 2*m, 2)];

            sperm = gamete(father);
            ovum = gamete(mather);

            paste0(sperm, ovum);
        }

        # generate `n` new births to replace the formal generation
        population = reproduce(population, n);

        # selection
        if (!identical(fitness, c(1, 1, 1))) {
            # if Wbb is 0.98, we randomly eliminates 2% of bb individuals created in each generation, and replaces them with off spring from a new mating of the parental generation.

            nAA = sum(population == 'AA');
            naa = sum(population == 'aa');
            nAa = n - nAA - naa; # the population size is constant, and heterozygous may be 'Aa' or 'aA'

            new.nAA = round(nAA * fitness[1]);
            new.nAa = round(nAa * fitness[2]);
            new.naa = round(naa * fitness[3]);

            ndead = n - new.nAA - new.nAa - new.naa;

            if (ndead > 0) {
                population <- c(rep('AA', new.nAA), rep('Aa', new.nAa), rep('aa', new.naa),
                                reproduce(population, ndead));
            }
        }
    }

    return(A.frequency);
}




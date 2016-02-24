library("parallel")

sondaz_giver_lista <- function(listewka) {
    date_giver <- function(podlista) {
        podlista[["res"]]
    }
    lapply(listewka, date_giver)
}

baza <- readRDS("data/baza.rds")
sondaze <- sondaz_giver_lista(baza)
rm(baza)

# dane <- sondaze[[1]] # do testowania
interpolacja_hgt <- function(dane, nr_kolumny, poziomy) {
    # poziomy lepiej zadeklarowac poza funkcja
    if (length(which(dane[, 1] < 1000 & dane[, 1] > 850)) >= 2) {
        round(approx(dane[, 1], dane[, nr_kolumny], xout = poziomy)$y, 2)
    } else {
        rep(NA, length(poziomy))
    }
}

# header <-
# c('PRES','HGHT','TEMP','DWPT','RELH','MIXR','DRCT','SKNT','THTA','THTE','THTV')
levels <- rev(sort(c(seq(from = 700, to = 1000, by = 25), seq(from = 100, to = 650, 
    by = 50))))

Rprof()
HGHT <- mclapply(sondaze, interpolacja_hgt, 2, levels, mc.cores = 2)
TEMP <- mclapply(sondaze, interpolacja_hgt, 3, levels, mc.cores = 2)
RELH <- mclapply(sondaze, interpolacja_hgt, 5, levels, mc.cores = 2)
MIXR <- mclapply(sondaze, interpolacja_hgt, 6, levels, mc.cores = 2)
DRCT <- mclapply(sondaze, interpolacja_hgt, 7, levels, mc.cores = 2)
SKNT <- mclapply(sondaze, interpolacja_hgt, 8, levels, mc.cores = 2)
Rprof(NULL)
summaryRprof()

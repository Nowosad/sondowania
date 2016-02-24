library(parallel)

baza <- readRDS(file="~/Dokumenty/publikacje_własne/2016/sondowania/baza.rds")

staty_giver_lista <- function(listewka){
        staty_giver <- function(podlista){
                podlista[['staty']]
        }
        lapply(listewka, staty_giver)
}

date_giver_lista <- function(listewka){
  date_giver <- function(podlista){
    podlista[['date']]
  }
  lapply(listewka, date_giver)
}

stacja_giver_lista <- function(listewka){
  date_giver <- function(podlista){
    posdlista[['date']]
  }
  lapply(listewka, date_giver)
}


moje_staty <- staty_giver_lista(baza)
table(names(unlist(lapply(moje_staty, function(x) x[6])))) 
hist(unlist(lapply(moje_staty, function(x) x[6])))
table(round(unlist(lapply(moje_staty, function(x) x[12]))/10)) # w cape'y rzedy 2339 nie wierze


(date_giver_lista(baza))[[156192]]
baza[[156192]]

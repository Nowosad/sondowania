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

sondaz_giver_lista <- function(listewka){
  date_giver <- function(podlista){
    podlista[['res']]
  }
  lapply(listewka, date_giver)
}





moje_staty <- staty_giver_lista(baza)
table(names(unlist(lapply(moje_staty, function(x) x[6])))) 
hist(unlist(lapply(moje_staty, function(x) x[6])))
table(round(unlist(lapply(moje_staty, function(x) x[12]))/10)) # w cape'y rzedy 2339 nie wierze


(date_giver_lista(baza))[[156192]]
baza[[156192]]




sondaze <- sondaz_giver_lista(baza)
dane <- sondaze[[1]]
dane2 <- sondaze

poziomy=rev(sort(c(seq(from=700,to=1000,by=25),seq(from=100,to=650,by=50))))

interpolacja_hgt <- function(dane, nr_kolumny){
  # poziomy lepiej zadeklarowac poza funkcja
  if(length(which(dane[,1]<1000 & dane[,1]>850))>=2) {
    round(approx(dane[,1],dane[,nr_kolumny],xout=poziomy)$y,2)  
} else {
  rep(NA, length(poziomy))
}
}




Rprof()
#cl <- makeCluster(11,type = 'FORK')
a <- lapply(dane2, interpolacja_hgt, 3)
#a <- sapply(dane2, interpolacja_hgt)
#stopCluster(cl)
Rprof(NULL)
summaryRprof()

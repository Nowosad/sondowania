baza <- readRDS('~/Dokumenty/publikacje_własne/2016/sondowania/baza.rds')

sondaz_giver_lista <- function(listewka){
  date_giver <- function(podlista){
    podlista[['res']]
  }
  lapply(listewka, date_giver)
}

sondaze <- sondaz_giver_lista(baza)
#dane <- sondaze[[1]] # do testowania

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

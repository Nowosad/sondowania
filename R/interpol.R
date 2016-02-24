library(parallel)
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



header <- c("PRES","HGHT","TEMP","DWPT","RELH","MIXR","DRCT","SKNT","THTA","THTE","THTV")

Rprof()
#cl <- makeCluster(11)
#aPRS <- lapply(dane2, interpolacja_hgt, 3)
HGHT <- mclapply(sondaze, interpolacja_hgt, 2, mc.cores = 11, mc.preschedule = F)
TEMP <- mclapply(sondaze, interpolacja_hgt, 3, mc.cores = 10, mc.preschedule = F)
RELH <- mclapply(sondaze, interpolacja_hgt, 5, mc.cores = 10, mc.preschedule = F)
MIXR <- mclapply(sondaze, interpolacja_hgt, 6, mc.cores = 10, mc.preschedule = F)
DRCT <- mclapply(sondaze, interpolacja_hgt, 7, mc.cores = 10, mc.preschedule = F)
SKNT <- mclapply(sondaze, interpolacja_hgt, 8, mc.cores = 10, mc.preschedule = F)

#a <- do.call(rbind.data.frame, aPRS)
#names(a) <- poziomy
#rownames(a)
#a <- sapply(dane2, interpolacja_hgt)
#stopCluster(cl)
Rprof(NULL)
summaryRprof()

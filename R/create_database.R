library(plyr)

# load all archive dataset from local directory

# define constants:

# sounding header / file structure:
header <- c("PRES","HGHT","TEMP","DWPT","RELH","MIXR","DRCT","SKNT","THTA","THTE","THTV")

# TODO:
setwd("~/Pulpit/")
stations <- dir(path="sondowania")

# beginning of loop for folders/stations:
nowa_lista <- list()
licznik <- 1
for (i in stations){
        
        files <- dir(paste0("sondowania/", i), full.names = TRUE)
        
        for (j in files){
        #j <- files[1]
        
        tmp <- readLines(j) # temporary object for raw data
        
        if(length(tmp)>28){ # jak pomiar jest krotszy niz 28 linii (w rzeczywistoscii 5 poziomow to nie bierz sondowania pod uwage)
        
        term_lin <- grep(pattern="Station information",tmp)
        term_lin_stat <- grep(pattern="Description",tmp)-term_lin-1
        res <- read.fwf(j, widths = c(7,7,7,7,7,7,7,7,7,7,7), skip=5, n = term_lin-6,header = F)
        colnames(res) <- header
        
        # staty bez daty i kodu stacji
        staty <- as.double(as.character(read.fwf(j, widths = c(44,20), skip=term_lin+2, header = F, n = term_lin_stat-2)[,2]))
        test <- read.fwf(j, widths = c(44,20), skip=term_lin+2, header = F, n = term_lin_stat-2)
        
        if(licznik==1) {
          test2 <- test
        }
        staty <- join(test2,test, by="V1")[,3]
        names(staty) <- sub(":", "", gsub(" *", '',as.character(test2[,1])))
        
        
        #if(length(staty)<23) stop("bubu")
        
        date <- strptime(paste(substr(j, 24,33),substr(j, 35,36)), "%Y.%m.%d %H", tz="UTC")
        station <- i
        
        tmp_list <- list(station=station,date=date, res=res,staty=staty)
      
        
        # ok., tutaj jest problem ze zlaczeniem 2 list o podobnej postaci, zeby pozniej sie dalo
        # w miare latwo na czyms takim lapply'owac:
        
        nowa_lista[[licznik]] <- tmp_list
         
        print(j) 
        licznik <- licznik+1
        }# koniec ifa dla pustych plikow
        } # koniec petli po plikach wewnatrz katalogu
} # koniec petli po stacjach


saveRDS(nowa_lista, file="~/Dokumenty/publikacje_własne/2016/sondowania/baza.rds")
# podejrzyj strukture nowej listy....
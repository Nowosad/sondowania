# load all archive dataset from local directory

# define constants:

# sounding header / file structure:
header <- c("PRES","HGHT","TEMP","DWPT","RELH","MIXR","DRCT","SKNT","THTA","THTE","THTV")

# TODO:
# structure for stats:
stations <- dir(path="data/sondowania")

# beginning of loop for folders/stations:
nowa_lista <- list()
licznik <- 1
for (i in stations){
        
        files <- dir(paste0("data/sondowania/", i), full.names = TRUE)
        
        for (j in files){
        #j <- files[1]
        
        tmp <- readLines(j) # temporary object for raw data
        term_lin <- grep(pattern="Station information",tmp)
        term_lin_stat <- grep(pattern="Precipitable",tmp)-term_lin
        res <- read.fwf(j, widths = c(7,7,7,7,7,7,7,7,7,7,7), skip=5, n = term_lin-6,header = F)
        colnames(res) <- header
        
        # staty bez daty i kodu stacji
        staty <- as.double(as.character(read.fwf(j, widths = c(44,20), skip=term_lin+2, header = F, n = term_lin_stat-2)[,2]))
        date <- strptime(paste(substr(j, 29,38),substr(j, 40,41)), "%Y.%m.%d %H", tz="UTC")
        station <- i
        
        tmp_list <- list(station=station,date=date, res=res,staty=staty)
        
        # ok., tutaj jest problem ze zlaczeniem 2 list o podobnej postaci, zeby pozniej sie dalo
        # w miare latwo na czyms takim lapply'owac:
        
        nowa_lista[[licznik]] <- tmp_list
        print(j) 
        licznik <- licznik+1
        }
}


saveRDS(nowa_lista, file="~/Pulpit/sondowania/baza.rds")
# podejrzyj strukture nowej listy....
staty_giver_lista <- function(listewka){
        staty_giver <- function(podlista){
                podlista[['staty']]
        }
        lapply(listewka, staty_giver)
}

moje_staty <- staty_giver_lista(nowa_lista)
table(names(unlist(lapply(moje_staty, function(x) x[5])))) #Piąty element (1997) - Korben Dallas to były komandos, a obecnie taksówkarz w NY w XXIII wieku. Wplątany zostaje w misję ratowania świata przed siłami zła ...


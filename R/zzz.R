# zzz.R is the conventional location to define .onAttach()

.onAttach <- function(lib, pkg){

  pkg.info <- drop(read.dcf(file = system.file("DESCRIPTION",
                package = "LAGOSUS"), fields = c("Title", "Version", "Date")))

  gigascience_cite <-
  "https://lagoslakes.org"

  if(interactive()){
    packageStartupMessage(paste0("Welcome to the LAGOSUS R package. To cite LAGOSUS in publications see: \n ",
    gigascience_cite))
  }
}

utils::globalVariables(c('lagoslakeid'))

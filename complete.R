complete <- function(directory = file.path("C:","Users","user","Documents","GitHub","datasciencecoursera","specdata"), id = 1:332) {

  nobsNum <- numeric(0)
  
  for (cid in id) {
    cDfr <- getmonitor(cid, directory)
    nobsNum <- c(nobsNum, nrow(na.omit(cDfr)))
  }
  data.frame(id = id, nobs = nobsNum)
}

getmonitor <- function(id, directory = file.path("C:","Users","user","Documents","GitHub","datasciencecoursera","specdata"), summarize = FALSE) {

  fileStr <- paste(directory, "/", sprintf("%03d", as.numeric(id)), ".csv", 
                   sep = "")
  
  rawDfr <- read.csv(fileStr)
  

  if (summarize) {
    print(summary(rawDfr))
  }
  return(rawDfr)
}
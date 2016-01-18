pollutantmean <-function(directory = file.path("C:","Users","user","Documents","GitHub","datasciencecoursera","specdata"),pollutant,id = 1:332)
    {
  setwd(file.path(getwd(), directory))
  total <- 0
  observations <- 0
  for (i in id) {
    if (i < 10) {
      data<- read.csv(paste("0","0", as.character(i),".csv", sep=""), header = TRUE, na.strings = c("NA","NaN"," "))
    }
    else if (i>=10&i<100){data <- read.csv((paste("0", as.character(i), ".csv", sep=""), header=TRUE, na.strings=c("NA","NaN"," ")))}
    else {data<- read.csv(paste(as.character(i),".csv", sep=""), header = TRUE, na.strings=c("NA","NaN"," "))}
  }
  data=na.omit(data)
  observations = observations + nrow(data)
  if(pollutant == "sulfate"){total = total+sum(data$sulfate)}
  else{total = total+sum(data$nitrate)}

  setwd("..")
  return (total/observations)
}
  
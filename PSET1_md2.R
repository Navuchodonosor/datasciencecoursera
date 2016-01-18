pollutantmean <-function(directory = file.path("C:","Users","user","Documents","GitHub","datasciencecoursera","specdata"),pollutant,id = 1:332)
    {
  filelist = list.files(directory)
  file.names = as.numeric(sub("\\.csv$","",filelist))
  selected.files = filelist[match(id, file.names)]
  Data = lapply(file.path(directory,selected.files),read.csv)
  Data= do.call(rbind.data.frame,Data)
  mean(Data[,pollutant],na.rm=TRUE)
}

  
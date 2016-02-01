rankhospital <- function (state, outcome, num = "best") {
        ## Read outcome data
        outcomes<-read.csv("outcome-of-care-measures.csv", header =TRUE, stringsAsFactors=F, na.strings="Not Available")
        ##Check that state and outcome are valid
        ##Creates a vector with all possible outcomes
        diagnosis<-c("heart attack", "heart failure", "pneumonia")
        numChek<-c("best","worst")
        ## compares user inputted outcome with the right one
        if(!any(outcome == diagnosis)) {stop("invalid outcome")}
        ## compares state inputted by user with US state list
        if(!any(state == state.abb)) {stop("invalid state")}
        ## If something is not valid script stops and shows message

        ## Return hospital name in that state with the given rank
        ## 30-day death rate
        subsettedStates <- subset(outcomes, outcomes$State == state)
        if(outcome == "heart attack") {
                orderedStates<-subsettedStates[order(subsettedStates[ ,11]), ]
                NAs<-complete.cases(subset(orderedStates, select=c(Hospital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)))
                ans<-subset(orderedStates, select=c(Hospital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack), na.omit(NAs))
                colnames(ans)<-c("Hospital.Name", "Rate")
                ansNamesOrd<-ans[order(ans[,2], ans[,1]), ]
                ansNamesOrd$Rank<-c(1:length(ansNamesOrd[,1]))
                if (num == "best"){ansNamesOrd[1,1]}
                else if (num == "worst") {
                        lastLine<-length(ansNamesOrd[,1])
                        ansNamesOrd[lastLine,1]}
                else {ansNamesOrd[num,1]}        
        }
        
        else if (outcome == "heart failure") {
                ## All as above, but a little bit less code
                orderedStates<-subsettedStates[order(subsettedStates[ ,17]), ]
                NAs<-complete.cases(subset(orderedStates, select=c(Hospital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)))
                ans<-subset(orderedStates, select=c(Hospital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure), na.omit(NAs))
                colnames(ans)<-c("Hospital.Name", "Rate")
                ansNamesOrd<-ans[order(ans[,2], ans[,1]), ]
                ansNamesOrd$Rank<-c(1:length(ansNamesOrd[,1]))
                if (num == "best"){ansNamesOrd[1,1]}
                else if (num == "worst") {
                        lastLine<-length(ansNamesOrd[,1])
                        ansNamesOrd[lastLine,1]}
                else {ansNamesOrd[num,1]} 
        }
        else {
                orderedStates<-subsettedStates[order(subsettedStates[ ,23]), ]
                NAs<-complete.cases(subset(orderedStates, select=c(Hospital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)))
                ans<-subset(orderedStates, select=c(Hospital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia), na.omit(NAs))
                colnames(ans)<-c("Hospital.Name", "Rate")
                ansNamesOrd<-ans[order(ans[,2], ans[,1]), ]
                ansNamesOrd$Rank<-c(1:length(ansNamesOrd[,1]))
                if (num == "best"){ansNamesOrd[1,1]}
                else if (num == "worst") {
                        lastLine<-length(ansNamesOrd[,1])
                        ansNamesOrd[lastLine,1]}
                else {ansNamesOrd[num,1]} 
        }
        
}
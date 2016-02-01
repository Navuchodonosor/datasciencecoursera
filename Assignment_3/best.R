## This function searches for the best
## centers in US according to the lowest rates
## of mortality outcomes.
## Data provided by the U.S. Department of Health and Human Services.
## http://hospitalcompare.hhs.gov


best <- function (state, outcome) {
        ## Read outcome data
        outcomes<-read.csv("outcome-of-care-measures.csv", header =TRUE, stringsAsFactors=F, na.strings="Not Available")
        ##Check that state and outcome are valid
                ##Creates a vector with all possible outcomes
        diagnosis<-c("heart attack", "heart failure", "pneumonia")
                ## compares user inputted outcome with the right one
        if(!any(outcome == diagnosis)) {stop("invalid outcome")}
                ## compares state inputted by user with US state list
        if(!any(state == state.abb)) {stop("invalid state")}
                ## If something is not valid script stops and shows message
        
        ## Return hospital name in that state with 30-day
        ## lowest death rate
                ## Takes hospitals only from states chosen by user
        subsettedStates <- subset(outcomes, outcomes$State == state)
                ## Different outcomes
        if(outcome == "heart attack") {
                        ## Takes different rates of mortality
                mortalityRate<- subsettedStates$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack
                        ## Looks for a lowest rate (removing NA's)
                LowestRate<-min(mortalityRate, na.rm = TRUE)
                        ## Chooses clinic selected according to the rate
                subsetLowest <- subset(subsettedStates, mortalityRate %in% LowestRate)
                        ## Column with name
                place<-subsetLowest[2]
                        
                place
        }
        else if (outcome == "heart failure") {
                ## All as above, but a little bit less code
                LowestRate<-min(subsettedStates$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, na.rm = TRUE)
                subsetLowest <- subset(subsettedStates, subsettedStates[,17] %in% LowestRate)
                place<-subsetLowest[2]
                place
        }
        else {
                LowestRate<-min(subsettedStates$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia
                                , na.rm = TRUE)
                subsetLowest <- subset(subsettedStates, subsettedStates[,23] %in% LowestRate)
                place<-subsetLowest[2]
                place
        }
        
        finalPlace<-place[with(place, order(Hospital.Name)), ]
        finalPlace[1]
}
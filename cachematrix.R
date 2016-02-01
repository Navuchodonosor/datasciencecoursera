## This function creates a special "matrix" object that can cache its inverse
makeCacheMatrix <- function(x = matrix()) {
        i <- NULL
        
        #put values to my local matrix
        set <- function(y){
                x <<- y
                i <<- NULL
        }
        get <- function(){
                x
        }
        
        #calculates the inverse
        setInverse <- function(inverse){
                i <<- inverse
        }
        getInverse <- function(){
                i
        }
        
        list(set=set, get=get, setInverse=setInverse, getInverse=getInverse)
}


## This function computes the inverse of the special "matrix" returned by
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        i <- x$getInverse()
        if(!is.null(i)){
                message("getting cached data")
                return(i)
        }
        matrixTemp <- x$get()
        inverse <- solve(matrixTemp)
        x$setInverse(inverse)
        inverse
}
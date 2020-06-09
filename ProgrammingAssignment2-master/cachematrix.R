## makeCacheMatrix: This function creates a special “matrix” object that can cache its inverse. cacheSolve: This function computes the inverse of the special “matrix” returned by makeCacheMatrix above. If the inverse has already been calculated (and the matrix has not changed), then the cachesolve should retrieve the inverse from the cache. Computing the inverse of a square matrix can be done with the solve function in R. For example, if X is a square invertible matrix, then solve(X) returns its inverse.
## The following functions are used to create a special object that stores a matrix and caches its inverse. The first function, makeCacheMatrix creates a special “matrix”, which is really a list containing a function to:
## set the value of the matrix
## get the value of the matrix
## set the value of the inverse
## get the value of the inverse

makeCacheMatrix <- function(x = matrix()) {
  I<- NULL
  set<- function(y) {
    x<<-y
    I<<- NULL
  }
  get<-function() x
  setmean<- function(inverse) I<<- inverse
  getmean<- function() I
  list(set=set, get=get, setmean=setmean, getmean=getmean)
}

##This function computes the inverse of the special “matrix” returned by makeCacheMatrix above. If the inverse has already been calculated (and the matrix has not changed), then cacheSolve should retrieve the inverse from the cache.
cacheSolve <- function(x, ...) {
  I<-x$getinverse()
  if(!is.null(I)){
    message("getting cached data")
    return(I)
  }
  data<-x$get()
  m<-solve(data,...) 
  x$setinverse(I)
  I 
  ## Return a matrix that is the inverse of 'x'
}

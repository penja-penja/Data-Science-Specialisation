## Returns a list that contains the 2 pairs of getter and setter methods include:
## set the value of the vector
## get the value of the vector
## set the inverse value
## get the inverse value
makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  
  # Accessors
  get <- function() x
  getInverse <- function() inv
  
  # Mutators
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  setInverse <- function(newInv) inv <<- newInv

  # Return the functions
  list(set = set, get = get, 
       setInverse = setInverse, getInverse = getInverse)
}


## Calculate the inverse of the input value x and caches it
cacheSolve <- function(x, ...) {
  inv <- x$getInverse()
  
  # Calculated inverse value if it has not been calculated
  if(is.null(inv)) {
    data <- x$get()
    inv <- solve(data, ...)
    x$setInverse(inv)
  }
  
  inv
}

findAdjacentCells <- function(xCoordinate, yCoordinate, nRows, nCols) {
  #Select a random coordinate on a matrix and get all the surrounding coordinates
  center<- c(xCoordinate, yCoordinate)
  north <- c(xCoordinate, yCoordinate-1)
  northeast <- c(xCoordinate+1, yCoordinate-1)
  east <- c(xCoordinate+1, yCoordinate)
  southeast <- c(xCoordinate+1, yCoordinate+1)
  south<- c(xCoordinate, yCoordinate+1)
  southwest <- c(xCoordinate-1, yCoordinate+1)
  west<- c(xCoordinate-1, yCoordinate)
  northwest <- c(xCoordinate-1, yCoordinate-1)
  
  coordinateSurroundings <- rbind(center , north, northeast, east, southeast, south, southwest, west, northwest)
  coordinateSurroundings <- as.data.frame(coordinateSurroundings)
  colnames(coordinateSurroundings) <- c("x", "y")
  
  coordinateSurroundings <- subset(coordinateSurroundings, 
                                   coordinateSurroundings$x>0 & coordinateSurroundings$y>0 &
                                     coordinateSurroundings$x<=nRows & 
                                     coordinateSurroundings$y<=nCols)
  
  return(coordinateSurroundings)
}

randomAdjacentCell <- function(coordinateSurroundings) {
  #Pick a random direction for a point from a surrounding points matrix
  #Do not want to repeat the center point
  coordinateSurroundings<- coordinateSurroundings[rownames(coordinateSurroundings)!="center",]
  randomRowName <- sample(rownames(coordinateSurroundings), 1)
  randomRow <- coordinateSurroundings[randomRowName,]
  
  return(randomRow)
}

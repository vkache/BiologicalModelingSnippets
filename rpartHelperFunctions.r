#Machine learning functions
#2015-09-20

calculateComplexityParameter <- function(cpTable) {
  
  #Get the subset of the table where the CP is greater than zero
  #the number of splits is greater than zero and stdev is less than one
  cleanedUpCPtableSubset <- subset(cpTable, cpTable$CP>0 & cpTable$nsplit>0 & cpTable$xstd<1)
  
  #Get a subset of the table where the xerror is the smallest
  smallestXerrorSubset <- 
    subset(cleanedUpCPtableSubset, 
           cleanedUpCPtableSubset$xerror==min(cleanedUpCPtableSubset$xerror))
  
  #Get the sum of the smallest error subset and the its standard deviation
  #Then add a small value to it to make it a bit greater than the determinant
  smallestTreeCPdeterminant <- smallestXerrorSubset$xerror + smallestXerrorSubset$xstd
  smallestTreeCPdeterminant <- smallestTreeCPdeterminant + .1 * smallestTreeCPdeterminant
  
  #Get the portion of the CP table where the xerror is less than the determinant
  whereXerrorLessThanDeterminant <-
    subset(cleanedUpCPtableSubset, cleanedUpCPtableSubset$xerror < smallestTreeCPdeterminant)
  
  #Get the CP of the row where the xerror is less than the determinant and the
  #tree is the smallest
  cpOfSmallestTreeWithXerrorLessThanDeterminant <- 
    subset(whereXerrorLessThanDeterminant, 
           whereXerrorLessThanDeterminant$nsplit==min(whereXerrorLessThanDeterminant$nsplit))$CP
  
  #Cp value should be slightly greater than the determinant value
  cpOfSmallestTreeWithXerrorLessThanDeterminant <- 
    cpOfSmallestTreeWithXerrorLessThanDeterminant + .10*cpOfSmallestTreeWithXerrorLessThanDeterminant
  
  return(cpOfSmallestTreeWithXerrorLessThanDeterminant)
}


predictiveAccuracyOfAlgorithm <- function(twoColumnDataFrameActualPred){
  if(length(twoColumnDataFrameActualPred)!=2) {
    print("Improper data frame used for comparisons.")
  }
  
  colnames(twoColumnDataFrameActualPred) <- c("Actual", "Predicted")
  
  twoColumnDataFrameActualPred$predictionOutcome <- 
    ifelse(twoColumnDataFrameActualPred$Actual==twoColumnDataFrameActualPred$Predicted, 1, 0)
  
  proportionAccurate <- sum(twoColumnDataFrameActualPred$predictionOutcome)/
    length(twoColumnDataFrameActualPred$predictionOutcome)
  
  return(proportionAccurate)
}

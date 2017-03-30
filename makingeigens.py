from scipy import linalg
import numpy as np
import random


#creating a function to get eigenvalues that are negative with no imaginary values
def deseigen(lowrange, highrange, matsize):
    
    notnegorim = False  #Setting the initial while loop to iterate
      
    
    #iterating through random matrices to obtain negative eigenvalues
    while(notnegorim ==False):  #testing the boolean operator if any eigenvalues are not negative
        
        length = matsize*matsize  #creating a length for the array
        
        C = []  #creating an empty list to be turned into a matrix
        
        #making a matrix of random values based on user input and whether positive, zero or negative
        for k in range(0, length):
            posorneg = random.randrange(-1,1,1) #creating a value that is postive, zero or negative
            val = random.random() #creating a random float between 0 and 1
            r = random.random()   #creating another random float between 0 and 1

            #a fifty-fifty chance that the position value will reflect user input of high or low
            if(r>.5):
                positval = lowrange*val
            else:
                positval = highrange*val
            
            C.append(positval) #appending the value to the C list

        C = np.reshape(C,(matsize,matsize))  #turning C into an array

        L,V = linalg.eig(C) #calculating eigenvalues and eigenvectors of C
        print L
        
        #iterates over L and determines if any of the values in L are above zero and has imaginary parts,
        #if so while loops again
        
        itered=0 #setting an itered value to make sure all elements in L meet criteria
        #a for loop testing every eigenvalue to make sure it is negative and not imaginary
        for i in L:
            if(i<0 and i.imag ==0):
                itered = itered+1
                if(itered == len(L)):
                    notnegorim = True
                
    return C

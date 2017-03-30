import numpy as np
from scipy.integrate import odeint
import matplotlib.pyplot as plt
import math
plt.ion()


#Demonstrating the two fold cost of sex
t = np.linspace(0,5,5) #recreating time vector to demonstrate cost of sex
x = np.array([1])
for i in range(0,4):
    x = np.append(x,300.0*x[i])

plt.figure()
plt.plot(t,x, label= 'Selfing')

y = np.array([1])
for i in range(0,4):
    y = np.append(y,150.0*y[i])

plt.plot(t,y, label= 'Male/Female')

plt.xlabel('Weeks')
plt.ylabel('Number of worms')
plt.title('Arithmetic growth rate of selfing versus male/female populations')



K = 200000.0  #Carrying capacity of the population
p = 300  #progeny that is all female sex and producing maximum offspring



r =  math.log(p) #The growth rate assuming 300 births over a seven day period per worm


def logworm(N,t):
    Ni = N[0]
    funct = r*Ni*(1-Ni/K)

    return [funct]


t = np.linspace(0, 5,100)  #empty time vector, number of weeks

N0 = 1  # founder effect for a worm

soln = odeint(logworm, N0, t)  #solving the differential equation

plt.figure()
plt.plot(t,soln)

#now factoring in some male production
p = 300-.002*300  #progeny in C elegans that is all female sex producing maximum offspring, .2% males
r = math.log(p)  #growth rate for C elegans
soln = odeint(logworm, N0, t) #solving ODE

plt.plot(t,soln)


#now for a traditional male/female species
p = 300 - .5*300  #progeny in worm species that is a male/female species with 50% males
N0 = 2
r = math.log(p)-math.log(2)     #growth rate in normal male/female species
soln = odeint(logworm, N0, t)  #solving ODE

plt.plot(t,soln)






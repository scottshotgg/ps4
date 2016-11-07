from __future__ import division

import scipy.stats
from numpy import *

def normpdf(x, mu, sigma):
    u = (x-mu)/abs(sigma)
    y = (1/(sqrt(2*pi)*abs(sigma)))*exp(-u*u/2)
    return y


print scipy.stats.norm.pdf(20, 20, 10)
print normpdf(20, 20, 10)

print scipy.stats.norm.pdf(15, 20, 10)
print normpdf(15, 20, 10)

print scipy.stats.norm.pdf(10, 20, 10)
print normpdf(10, 20, 10)
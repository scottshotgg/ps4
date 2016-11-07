import numpy as np
import os
import csv
import operator
import math
import scipy.stats as stats

np.set_printoptions(threshold=np.nan)

def stdev(numbers):
	avg = np.mean(numbers)
	variance = np.sum([pow(x-avg,2) for x in numbers])/float(len(numbers)-1)
	return math.sqrt(variance)

def featureProbability(v, stdev, mean):
	#return ( (1 / (sigma * math.sqrt(2 * math.pi))) * math.exp(-(pow((float(v) - mu), 2))/(2 * pow(sigma, 2))) )
	exponent = math.exp(-(math.pow(v-mean,2)/(2*math.pow(stdev,2))))
	return (1 / (math.sqrt(2*math.pi) * stdev)) * exponent



x = []
y = []

file = open("spam_train.data")

with open("spam_train.data", "r") as f:
	for line in f:
		array = line.split(',')

		for value in range(len(array)):
			array[value] = float(array[value].strip('\r\n').strip('\n'))

		x.append(array[0:57])
		y.append(array[57])






# print len(meanarray)
# print len(stdarray)

# print meanarray[0]
# print stdarray[0]





notspamamount = 0
spamamount = 0

x0 = []
x1 = []


inc = 0
for value in y:
	if value == 0:
		notspamamount += 1
		x0.append(x[inc])
	else:
		spamamount += 1
		x1.append(x[inc])
	inc += 1


notspam = float(notspamamount)/(spamamount+notspamamount)
spam = float(spamamount)/(spamamount+notspamamount)

print x0
print x1

print x0[0]
print x1[0]
raw_input()


x0t = np.transpose(x0)
x1t = np.transpose(x1)

print np.shape(x0t)
print np.shape(x1t)


raw_input()

meanarray0 = []
stdarray0 = []
meanarray1 = []
stdarray1 = []


for featurearray in x0t:
	print featurearray
	meanarray0.append(np.mean(featurearray))
	print np.mean(featurearray)
	print np.sum(featurearray)
	print np.std(featurearray)
	print "stdev", stdev(featurearray)
	stdarray0.append(np.std(featurearray))
	#raw_input()

for featurearray in x1t:
	meanarray1.append(np.mean(featurearray))
	stdarray1.append(np.std(featurearray))


print stdarray0
print ""
print stdarray1
print ""
print meanarray0
print ""
print meanarray1
print ""

raw_input()

# print spamamount, notspamamount

# print spam, notspam


for value in range(len(y)):

	print "LINE", value
	print y[value]
	if y[value] == 0:
		print "we are in 0"
		for feature in range(len(x[value])):
			#print x[value][feature], stdarray0[feature], meanarray0[feature]
			#print featureProbability(x[value][feature], stdarray0[feature], meanarray0[feature])
			pzero = stats.norm(scale=stdarray0[feature], loc=meanarray0[feature]).pdf(x[value][feature])
			#if pzero > 1:
				#print pzero
			#print "\n\n"
	else:
		for feature in range(len(x[value])):
			#print x[value][feature], stdarray1[feature], meanarray1[feature]
			#print featureProbability(x[value][feature], stdarray1[feature], meanarray1[feature])
			pone = stats.norm(scale=stdarray1[feature], loc=meanarray1[feature]).pdf(x[value][feature])
			#if pone > 1:
				#print pone
				#print x[value][feature], stdarray1[feature], meanarray1[feature]
			#print "\n\n"


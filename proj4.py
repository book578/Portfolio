#!/usr/bin/python
##Ahmad Buhisi 
##Project 4
import os
import subprocess
import sys
from pylab import *
import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages
from matplotlib import rcParams
######function to return list of values to be added to alg0-3 arrays#####
###this function will take in the filename, open the file, generate an array with data for context switch, poster, anterior, and pincer attack average and return the array
def file_data(str_filename):   
	fd = open(str_filename)
	my_data = []
	myparse = []
	myfilelist = [] #will be a list to contain entries in the file //will be used to get context switch value
	for line in fd:
		myfilelist.append(line)
	my_data.append(float(len(myfilelist) - 3)/1000) #context switch
	myparse = myfilelist[len(myfilelist) -3].split(" ") #posterior
	my_data.append(float(myparse[len(myparse) -1])/1000)
	myparse = myfilelist[len(myfilelist) -2].split(" ") #anterior
	my_data.append(float(myparse[len(myparse) -1])/1000)
	myparse = myfilelist[len(myfilelist) -1].split(" ") #pincer
	my_data.append(float(myparse[len(myparse) -1])/ 1000)
	return my_data
rcParams.update({'figure.autolayout': True}) ##format figure for posting to pdf
filename = sys.argv[len(sys.argv) -1] ## obtain file name that will be used to name pdf file
script_dir = os.path.dirname(os.path.realpath('__file__')) #path of file running
list_figures =[]
pdf = PdfPages(filename) #initialize pdf object that will take in plt figure objects, and save to pdf document
title_page = plt.figure(figsize=(12,9)) #generate title page
title_page.clf()
title = 'Ahmad Buhisi ECE2524 Project #4' #text to be added for title page
title_page.text(0.5,0.5,title, transform=title_page.transFigure, size=24, ha="center") 
pdf.savefig()
plt.close()
alg_scenario = ["context switch", "posterior", "anterior", "pincer"]
a = arange(1000) #filter through all the folders in0 -in999
b = arange(1,8) # filter through folders in1 - in7
alg0 = [] #contextswitch, posterior, anterior, pincer
alg1 = [] #contextswitch, posterior, anterior, pincer
alg2 = [] #contextswitch, posterior, anterior, pincer
alg3 = [] #contextswitch, posterior, anterior, pincer
#/data/Exp1/0.1/in0  -- format for folder
#this nested for loop will be used to access the multiple folders and then call the function to generate array to be stored into lists alg0 -alg3
for bb in b:
    mydata_list0 = [0, 0, 0, 0]  
    mydata_list1 = [0, 0, 0, 0] 
    mydata_list2 = [0, 0, 0, 0] 
    mydata_list3 = [0, 0, 0, 0] 	
    for row in a: 
        strts = script_dir + "/data/Exp1/0.%d/in%d" %(bb,row)
	str_alg0 = strts + "/in%d.0.0.out" %row    
	mydata_list0 = [x + y for x, y in zip(mydata_list0, file_data(str_alg0))]
	str_alg1 = strts + "/in%d.1.0.out" %row 
	mydata_list1 = [x + y for x, y in zip(mydata_list1, file_data(str_alg1))]
		
	str_alg2 = strts + "/in%d.2.0.out" %row     
	mydata_list2 = [x + y for x, y in zip(mydata_list2, file_data(str_alg2))]
		
	str_alg3 = strts + "/in%d.3.0.out" %row
	mydata_list3 = [x + y for x, y in zip(mydata_list3, file_data(str_alg3))]
	
    alg0.append(mydata_list0)
    alg1.append(mydata_list1)
    alg2.append(mydata_list2) 
    alg3.append(mydata_list3) 		
x = arange(0.1, 0.8, 0.1)
#row, col
#the below code used to generate figures and store into pdf
fig, ax = plt.subplots(figsize=(15, 15)) #create subplot
ax.set_xlabel('System Load') #xlabel
ax.set_ylabel('Average number of Context Switches') #y1-label
ax.set_ylim(0,4600) #set the lower and upper boundary limits for y1
minorLocator = MultipleLocator(250) # set y1 -ticks
ax.yaxis.set_minor_locator(minorLocator) 
ax.grid(True) #create the grid
ax.grid(which='major', linestyle='--', linewidth=0.135, color='black') #customize grid for major x ticks
ax.grid(which='minor', linestyle='--', linewidth=0.25, color='blue') #customize grid for major y1 ticks
ax.set_axisbelow(True)
ax.set_prop_cycle(color=['c', 'm', 'y', 'k'], lw=[1, 2, 3, 4])
bx = ax.twinx()
bx.set_ylim(0,30)
bx.set_ylabel('Average number of Attacks',color='tab:green')
bx.grid(which='minor', linestyle=':', linewidth=0.25, color='red') #customize grid for major y2 ticks
minorLocator1 = MultipleLocator(1)
bx.yaxis.set_minor_locator(minorLocator1)
plt_choice = ax
plots = []
#create the plots and append to list, list is needed to combine the labels into 1 single label
for a in range(4):
	list_alg0 = []
	list_alg1 = []
	list_alg2 = []
	list_alg3 = []	
	for b in range(7):
		list_alg0.append(alg0[b][a])
		list_alg1.append(alg1[b][a])
		list_alg2.append(alg2[b][a])
		list_alg3.append(alg3[b][a])
	if a > 0:
		plt_choice = bx 	
	plots.append(plt_choice.plot(x, list_alg0,'o-',label='alg0_%s'%alg_scenario[a]))
	
	plots.append(plt_choice.plot(x, list_alg1,'h-',label='alg1_%s'%alg_scenario[a]))
		
	plots.append(plt_choice.plot(x, list_alg2,'s-',label='alg2_%s'%alg_scenario[a]))
		
	plots.append(plt_choice.plot(x, list_alg3,'X-',label='alg3_%s'%alg_scenario[a]))

my_plt = plots[0]
#create for loop to go through subplots generated and generate a single label
for i in range(1,len(plots)):
	my_plt += plots[i]
labels = [l.get_label() for l in my_plt]
plt_choice.legend(my_plt, labels, loc='center left', fontsize= 'small', bbox_to_anchor=(1.05,0.5))
plt.subplots_adjust(right=0.70)
plt.title('Averages for Context Switches, Posterior, Anterior, and Pincer Attacks at different System Loads-Exp1')
pdf.savefig()
plt.close()
#######################################part II ####################################################################################################
###part II is very similar to part I in process only difference is there is a 3 level nested loop 
###to go through the different folders and obtain Exp2 data
###################################################################################################################################################
a_2 = arange(1000) #filter through all the folders in0 -in999
b_2 = arange(5,25,5) # filter through folders in1 - in7
load_val = ["low","medium","high"]
alg02 = [] #contextswitch, posterior, anterior, pincer
alg12 = [] #contextswitch, posterior, anterior, pincer
alg22 = [] #contextswitch, posterior, anterior, pincer
alg32 = [] #contextswitch, posterior, anterior, pincer
#/data/Exp2/n5/high/in0
for bb in b_2:
    for load in load_val: 	
	mydata_list0 = [0, 0, 0, 0]  
    	mydata_list1 = [0, 0, 0, 0] 
    	mydata_list2 = [0, 0, 0, 0] 
    	mydata_list3 = [0, 0, 0, 0]
	for row in a_2: 
        	strts = script_dir + "/data/Exp2/n%d/%s/in%d" %(bb,load,row)
		str_alg0 = strts + "/in%d.0.0.out" %row    
		mydata_list0 = [x + y for x, y in zip(mydata_list0, file_data(str_alg0))]
		str_alg1 = strts + "/in%d.1.0.out" %row 
		mydata_list1 = [x + y for x, y in zip(mydata_list1, file_data(str_alg1))]
		
		str_alg2 = strts + "/in%d.2.0.out" %row     
		mydata_list2 = [x + y for x, y in zip(mydata_list2, file_data(str_alg2))]
		
		str_alg3 = strts + "/in%d.3.0.out" %row
		mydata_list3 = [x + y for x, y in zip(mydata_list3, file_data(str_alg3))]
	
    	alg02.append(mydata_list0)
    	alg12.append(mydata_list1)
    	alg22.append(mydata_list2) 
    	alg32.append(mydata_list3) 		
x_2 = arange(1, 13, 1)
#row, col
fig, ax = plt.subplots(figsize=(15, 15))
ax.set_xlabel('System Load with different number of Applications')
ax.set_ylabel('Average number of Context switches')
ax.set_ylim(0,9500)
ax.set_prop_cycle(color=['c', 'm', 'y', 'k'], lw=[1, 2, 3, 4])
minorLocator_2 = MultipleLocator(500)
ax.yaxis.set_minor_locator(minorLocator_2)
ax.grid(True)
ax.grid(which='major', linestyle='--', linewidth=0.135, color='black')
ax.grid(which='minor', linestyle='--', linewidth=0.25, color='black')
ax.set_axisbelow(True)
bx = ax.twinx()
bx.set_ylim(0,30)
bx.set_ylabel('Average number of attacks',color='tab:blue')
minorLocator_2b = MultipleLocator(1)
bx.yaxis.set_minor_locator(minorLocator_2b)
bx.grid(True)
bx.grid(which='minor', linestyle='-.', linewidth=0.25, color='red')
plt_choice = ax
plots = []
for a in range(4):
	list_alg0 = []
	list_alg1 = []
	list_alg2 = []
	list_alg3 = []	
	for b in range(12):
		list_alg0.append(alg02[b][a])
		list_alg1.append(alg12[b][a])
		list_alg2.append(alg22[b][a])
		list_alg3.append(alg32[b][a])
	if a > 0:
		plt_choice = bx 
	
	plots.append(plt_choice.plot(x_2, list_alg0,'^-',label='alg0_%s'%alg_scenario[a]))
	
	plots.append(plt_choice.plot(x_2, list_alg1,'o-',label='alg1_%s'%alg_scenario[a]))
		
	plots.append(plt_choice.plot(x_2, list_alg2,'H-',label='alg2_%s'%alg_scenario[a]))
		
	plots.append(plt_choice.plot(x_2, list_alg3,'s-',label='alg3_%s'%alg_scenario[a]))

my_plt = plots[0]
for i in range(1,len(plots)):
	my_plt += plots[i]
labels = [l.get_label() for l in my_plt]
plt_choice.legend(my_plt, labels, loc='center left',fontsize= 'medium', bbox_to_anchor=(1.05,0.5))
plt.subplots_adjust(right=0.70)
plt.xticks(x_2, ('n5low', 'n5med', 'n5high', 'n10low', 'n10med', 'n10high', 'n15low','n15med','n15high','n20low','n20med','n20high'))
plt.title('Averages for Context Switches, Posterior, Anterior, and Pincer Attacks at different System Loads -Exp2')
pdf.savefig()
plt.close()
d = pdf.infodict()
d['Title'] = 'ECE 2524 Project #4'
d['Author'] = 'Ahmad Buhisi'
pdf.close()	

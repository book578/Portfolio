#!/bin/bash
#Project # 2
#Ahmad Buhisi
########################################################################################################################################################################################
##The following data points are needed:
#Average number of context switches per algorithm per load
#Average number of posterior, anterior and pincer attacks per algorithm per load
#Expected total number of data points will be:
#per alogirthm,  21 averages for attacks 3 per load, 7 total loads, 7 total context switch averages
#28 total data points per algorithm, 4 algorithms in total = 112 datapoints to map
########################################################################################################################################################################################
touch ./results-exp{1,2} #create exp result files
touch ./overhead-exp{1,2} #create file for overhead context switches	
echo "#Ahmad Buhisi ECE 2524 Project#2 #EXP 1 Attack Results" > results-exp1;echo "#Ahmad Buhisi ECE 2524 Project#2 #EXP 2 Results" > results-exp2;
echo "#Ahmad Buhisi ECE 2524 Project#2 #EXP 1 Overhead Results" > overhead-exp1;echo "#Ahmad Buhisi ECE 2524 Project#2 #EXP 2 Overhead Results" > overhead-exp2;
Number=0
loadval=1
alg0_avg_cosw=();alg1_avg_cosw=();alg2_avg_cosw=();alg3_avg_cosw=();
alg0_posterior=();alg1_posterior=();alg2_posterior=();alg3_posterior=();
alg0_anterior=();alg1_anterior=();alg2_anterior=();alg3_anterior=();
alg0_pincer=();alg1_pincer=();alg2_pincer=();alg3_pincer=();
#two while loops the first while loop will access the loads from 0.1 to 0.7
#the second while loop will access each base case with in the load folders, add up all of the values for context switches, posterior, anterior
# pincer attacks per algorithm
while [ $loadval -lt 8 ] ; do
alg0_avg_cosw[$loadval]=0;alg1_avg_cosw[$loadval]=0;alg2_avg_cosw[$loadval]=0;alg3_avg_cosw[$loadval]=0;
alg0_posterior[$loadval]=0;alg1_posterior[$loadval]=0;alg2_posterior[$loadval]=0;alg3_posterior[$loadval]=0;
alg0_anterior[$loadval]=0;alg1_anterior[$loadval]=0;alg2_anterior[$loadval]=0;alg3_anterior[$loadval]=0;
alg0_pincer[$loadval]=0;alg1_pincer[$loadval]=0;alg2_pincer[$loadval]=0;alg3_pincer[$loadval]=0;
while [ $Number -lt 1000 ] ; do 
let alg0_avg_cosw[$loadval]=${alg0_avg_cosw[loadval]}-1+`grep -n "# of posterior" data/Exp1/0.$loadval/in$Number/in$Number.0.0.out |cut -d':' -f 1`
let alg0_posterior[$loadval]=${alg0_posterior[loadval]}+`grep "# of posterior" data/Exp1/0.$loadval/in$Number/in$Number.0.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let alg0_anterior[$loadval]=${alg0_anterior[loadval]}+`grep "# of anterior" data/Exp1/0.$loadval/in$Number/in$Number.0.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let alg0_pincer[$loadval]=${alg0_pincer[loadval]}+`grep "# of pincer" data/Exp1/0.$loadval/in$Number/in$Number.0.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let alg1_avg_cosw[$loadval]=${alg1_avg_cosw[loadval]}-1+`grep -n "# of posterior" data/Exp1/0.$loadval/in$Number/in$Number.1.0.out |cut -d':' -f 1`
let alg1_posterior[$loadval]=${alg1_posterior[loadval]}+`grep "# of posterior" data/Exp1/0.$loadval/in$Number/in$Number.1.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let alg1_anterior[$loadval]=${alg1_anterior[loadval]}+`grep "# of anterior" data/Exp1/0.$loadval/in$Number/in$Number.1.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let alg1_pincer[$loadval]=${alg1_pincer[loadval]}+`grep "# of pincer" data/Exp1/0.$loadval/in$Number/in$Number.1.0.out |cut -d':' -f 2|cut -b 2|cut -d' ' -f 2`
let alg2_avg_cosw[$loadval]=${alg2_avg_cosw[loadval]}-1+`grep -n "# of posterior" data/Exp1/0.$loadval/in$Number/in$Number.2.0.out |cut -d':' -f 1`
let alg2_posterior[$loadval]=${alg2_posterior[loadval]}+`grep "# of posterior" data/Exp1/0.$loadval/in$Number/in$Number.2.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let alg2_anterior[$loadval]=${alg2_anterior[loadval]}+`grep "# of anterior" data/Exp1/0.$loadval/in$Number/in$Number.2.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let alg2_pincer[$loadval]=${alg2_pincer[loadval]}+`grep "# of pincer" data/Exp1/0.$loadval/in$Number/in$Number.2.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let alg3_avg_cosw[$loadval]=${alg3_avg_cosw[loadval]}-1+`grep -n "# of posterior" data/Exp1/0.$loadval/in$Number/in$Number.3.0.out |cut -d':' -f 1`
let alg3_posterior[$loadval]=${alg3_posterior[loadval]}+`grep "# of posterior" data/Exp1/0.$loadval/in$Number/in$Number.3.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let alg3_anterior[$loadval]=${alg3_anterior[loadval]}+`grep "# of anterior" data/Exp1/0.$loadval/in$Number/in$Number.3.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let alg3_pincer[$loadval]=${alg3_pincer[loadval]}+`grep "# of pincer" data/Exp1/0.$loadval/in$Number/in$Number.3.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let Number=$Number+1
done
let loadval=$loadval+1
let Number=0
done
let loadval=1
printf "%s %25s %25s %25s %25s\n" "#system_load" "in0_avg_contextswitches" "in1_avg_contextswitches" "in2_avg_contextswitches" "in3_avg_contextswitches" >> ./overhead-exp1
while [ $loadval -lt 8 ]; do
alg0_avg_cosw[$loadval]=`echo "scale=10;var=${alg0_avg_cosw[loadval]};var/=1000;var"|bc -l`
alg1_avg_cosw[$loadval]=`echo "scale=10;var=${alg1_avg_cosw[loadval]};var/=1000;var"|bc -l` 
alg2_avg_cosw[$loadval]=`echo "scale=10;var=${alg2_avg_cosw[loadval]};var/=1000;var"|bc -l` 
alg3_avg_cosw[$loadval]=`echo "scale=10;var=${alg3_avg_cosw[loadval]};var/=1000;var"|bc -l`
printf "%12s %25s %25s %25s %25s\n" "0."$loadval ${alg0_avg_cosw[loadval]} ${alg1_avg_cosw[loadval]} ${alg2_avg_cosw[loadval]} ${alg3_avg_cosw[loadval]} >> ./overhead-exp1;
let loadval=$loadval+1
done
echo "">> ./overhead-exp1;echo "">> ./overhead-exp1
let loadval=1
printf "%s %25s %25s %25s %25s\n" "#system_load" "in0_avg_posterior attacks" "in1_avg_posterior attacks" "in2_avg_posterior attacks" "in3_avg_posterior attacks" >> results-exp1
while [ $loadval -lt 8 ]; do
alg0_posterior[$loadval]=`echo "scale=10;var=${alg0_posterior[loadval]};var/=1000;var"|bc -l`
alg1_posterior[$loadval]=`echo "scale=10;var=${alg1_posterior[loadval]};var/=1000;var"|bc -l` 
alg2_posterior[$loadval]=`echo "scale=10;var=${alg2_posterior[loadval]};var/=1000;var"|bc -l` 
alg3_posterior[$loadval]=`echo "scale=10;var=${alg3_posterior[loadval]};var/=1000;var"|bc -l`
printf "%12s %25s %25s %25s %25s\n" "0."$loadval ${alg0_posterior[loadval]} ${alg1_posterior[loadval]} ${alg2_posterior[loadval]} ${alg3_posterior[loadval]} >> ./results-exp1;
let loadval=$loadval+1
done
echo "">> ./results-exp1;echo "">> ./results-exp1
let loadval=1
printf "%s %25s %25s %25s %25s\n" "#system_load" "in0_avg_anterior attacks" "in1_avg_anterior attacks" "in2_avg_anterior attacks" "in3_avg_anterior attacks" >> results-exp1
while [ $loadval -lt 8 ]; do
alg0_anterior[$loadval]=`echo "scale=10;var=${alg0_anterior[loadval]};var/=1000;var"|bc -l`
alg1_anterior[$loadval]=`echo "scale=10;var=${alg1_anterior[loadval]};var/=1000;var"|bc -l` 
alg2_anterior[$loadval]=`echo "scale=10;var=${alg2_anterior[loadval]};var/=1000;var"|bc -l` 
alg3_anterior[$loadval]=`echo "scale=10;var=${alg3_anterior[loadval]};var/=1000;var"|bc -l`
printf "%12s %25s %25s %25s %25s\n" "0."$loadval ${alg0_anterior[loadval]} ${alg1_anterior[loadval]} ${alg2_anterior[loadval]} ${alg3_anterior[loadval]} >> ./results-exp1;
let loadval=$loadval+1
done
echo "">> ./results-exp1;echo "">> ./results-exp1
let loadval=1
printf "%s %25s %25s %25s %25s\n" "#system_load" "in0_avg_pincer attacks" "in1_avg_pincer attacks" "in2_avg_pincer attacks" "in3_avg_pincer attacks" >> results-exp1
while [ $loadval -lt 8 ]; do
alg0_pincer[$loadval]=`echo "scale=10;var=${alg0_pincer[loadval]};var/=1000;var"|bc -l`
alg1_pincer[$loadval]=`echo "scale=10;var=${alg1_pincer[loadval]};var/=1000;var"|bc -l` 
alg2_pincer[$loadval]=`echo "scale=10;var=${alg2_pincer[loadval]};var/=1000;var"|bc -l` 
alg3_pincer[$loadval]=`echo "scale=10;var=${alg3_pincer[loadval]};var/=1000;var"|bc -l`
printf "%12s %25s %25s %25s %25s\n" "0."$loadval ${alg0_pincer[loadval]} ${alg1_pincer[loadval]} ${alg2_pincer[loadval]} ${alg3_pincer[loadval]} >> ./results-exp1;
let loadval=$loadval+1
done
gnuplot -persist <<-EOFMarker
set title "Averages for Context Switches, posterior, anterior, and pincer attacks at different System Loads" font ",10" textcolor rgbcolor "royalblue" center
#set size  1.005,1  
set xlabel "System Loads"
set ylabel "Average Number of Context Switches"
set y2label "Average Number of Attacks" 
    set xrange [0:0.8]
    set yrange [0:4700]
    set y2range [0:30]   
set key on outside Right box lt 5 lc 145
    set grid ytics        # draw lines for each ytics and y2tics
    set grid y2tics
    set y2tics 1           # set the spacing for the y2tics
    set ytics 100          # set the spacing for the y1tics
     set grid xtics         # draw lines for each ytics and mytics
     set grid               # enable the grid
set terminal pngcairo size 2400,1800
set output "Exp1_plot_averages_context switches_posterior_anterior_pincer_attacks.png"   
    plot "results-exp1" using 1:2 index 0 axes x1y2 with linespoints title "avg posterior attacks in0",\
    "./results-exp1" using 1:3 index 0 axes x1y2 with linespoints title "avg posterior attacks in1",\
    "results-exp1" using 1:4 index 0 axes x1y2 with linespoints title "avg posterior attacks in2",\
    "results-exp1" using 1:5 index 0 axes x1y2 with linespoints title "avg posterior attacks in3"		
 set terminal pngcairo size 2400,1800
set output "Exp1_plot_averages_context switches_posterior_anterior_pincer_attacks.png"   
 replot "results-exp1" using 1:2 index 1 axes x1y2 with linespoints title "avg anterior attacks in0",\
    "results-exp1" using 1:3 index 1 axes x1y2 with linespoints title "avg anterior attacks in1",\
    "results-exp1" using 1:4 index 1 axes x1y2 with linespoints title "avg anterior attacks in2",\
    "results-exp1" using 1:5 index 1 axes x1y2 with linespoints title "avg anterior attacks in3"	
set terminal pngcairo size 2400,1800
set output "Exp1_plot_averages_context switches_posterior_anterior_pincer_attacks.png"   
 replot "results-exp1" using 1:2 index 2 axes x1y2 with linespoints title "avg pincer attacks in0",\
    "results-exp1" using 1:3 index 2 axes x1y2 with linespoints title "avg pincer attacks in1",\
    "results-exp1" using 1:4 index 2 axes x1y2 with linespoints title "avg pincer attacks in2",\
    "results-exp1" using 1:5 index 2 axes x1y2 with linespoints title "avg pincer attacks in3"	
set terminal pngcairo size 2400,1800
set output "Exp1_plot_averages_context switches_posterior_anterior_pincer_attacks.png"   
     replot "./overhead-exp1" using 1:2 axes x1y1 with linespoints title "avg context switches in0",\
    "./overhead-exp1" using 1:3 axes x1y1 with linespoints title "avg context switches in1",\
    "./overhead-exp1" using 1:4 axes x1y1 with linespoints title "avg context switches in2",\
    "./overhead-exp1" using 1:5 axes x1y1 with linespoints title "avg context switches in3"
EOFMarker
#########################################################################################################################################################################################################
#EXP2 Portion
#There are approximately 48,000 output files to process in this section
#Exp2 has two layers, one testing the number of applications running, and each number of applications are tested for high, medium, low system loads
#number of apps tested, are 5,10,15,20
#########################################################################################################################################################################################################
#declare the array as associative array, will allow for nxn array matrix
declare -A alg0_array; declare -A alg1_array; declare -A alg2_array; declare -A alg3_array
Number=0 #used to gothrough values of 0 - 999
folder_appval=0 #used to go through n5-n20 folders
appval_loadsysval=0 ##used to evaluate value through array
app_load_n=("low" "medium" "high")
fd_mult=1 #will be used to loop through the n5-n20 folders
while [ $fd_mult -lt 5 ];do
folder_appval=$[5*fd_mult]
app_l_count=0
while [ $app_l_count -lt 3 ];do
alg0_array[$appval_loadsysval,0]=0;alg0_array[$appval_loadsysval,1]=0;alg0_array[$appval_loadsysval,2]=0;alg0_array[$appval_loadsysval,3]=0;
alg1_array[$appval_loadsysval,0]=0;alg1_array[$appval_loadsysval,1]=0;alg1_array[$appval_loadsysval,2]=0;alg1_array[$appval_loadsysval,3]=0;
alg2_array[$appval_loadsysval,0]=0;alg2_array[$appval_loadsysval,1]=0;alg2_array[$appval_loadsysval,2]=0;alg2_array[$appval_loadsysval,3]=0;
alg3_array[$appval_loadsysval,0]=0;alg3_array[$appval_loadsysval,1]=0;alg3_array[$appval_loadsysval,2]=0;alg3_array[$appval_loadsysval,3]=0;
while [ $Number -lt 1000 ]; do
#context switch
let alg0_array[$appval_loadsysval,0]+=-1+`grep -n "# of posterior" data/Exp2/n$folder_appval/${app_load_n[app_l_count]}/in$Number/in$Number.0.0.out |cut -d':' -f 1`
let alg1_array[$appval_loadsysval,0]+=-1+`grep -n "# of posterior" data/Exp2/n$folder_appval/${app_load_n[app_l_count]}/in$Number/in$Number.1.0.out |cut -d':' -f 1`
let alg2_array[$appval_loadsysval,0]+=-1+`grep -n "# of posterior" data/Exp2/n$folder_appval/${app_load_n[app_l_count]}/in$Number/in$Number.2.0.out |cut -d':' -f 1`
let alg3_array[$appval_loadsysval,0]+=-1+`grep -n "# of posterior" data/Exp2/n$folder_appval/${app_load_n[app_l_count]}/in$Number/in$Number.3.0.out |cut -d':' -f 1`
#posterior
let alg0_array[$appval_loadsysval,1]+=`grep "# of posterior" data/Exp2/n$folder_appval/${app_load_n[app_l_count]}/in$Number/in$Number.0.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let alg1_array[$appval_loadsysval,1]+=`grep "# of posterior" data/Exp2/n$folder_appval/${app_load_n[app_l_count]}/in$Number/in$Number.1.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let alg2_array[$appval_loadsysval,1]+=`grep "# of posterior" data/Exp2/n$folder_appval/${app_load_n[app_l_count]}/in$Number/in$Number.2.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let alg3_array[$appval_loadsysval,1]+=`grep "# of posterior" data/Exp2/n$folder_appval/${app_load_n[app_l_count]}/in$Number/in$Number.3.0.out |cut -d':' -f 2|cut -d' ' -f 2`
#anterior
let alg0_array[$appval_loadsysval,2]+=`grep "# of anterior" data/Exp2/n$folder_appval/${app_load_n[app_l_count]}/in$Number/in$Number.0.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let alg1_array[$appval_loadsysval,2]+=`grep "# of anterior" data/Exp2/n$folder_appval/${app_load_n[app_l_count]}/in$Number/in$Number.1.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let alg2_array[$appval_loadsysval,2]+=`grep "# of anterior" data/Exp2/n$folder_appval/${app_load_n[app_l_count]}/in$Number/in$Number.2.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let alg3_array[$appval_loadsysval,2]+=`grep "# of anterior" data/Exp2/n$folder_appval/${app_load_n[app_l_count]}/in$Number/in$Number.3.0.out |cut -d':' -f 2|cut -d' ' -f 2`
#pincer
let alg0_array[$appval_loadsysval,3]+=`grep "# of pincer" data/Exp2/n$folder_appval/${app_load_n[app_l_count]}/in$Number/in$Number.0.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let alg1_array[$appval_loadsysval,3]+=`grep "# of pincer" data/Exp2/n$folder_appval/${app_load_n[app_l_count]}/in$Number/in$Number.1.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let alg2_array[$appval_loadsysval,3]+=`grep "# of pincer" data/Exp2/n$folder_appval/${app_load_n[app_l_count]}/in$Number/in$Number.2.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let alg3_array[$appval_loadsysval,3]+=`grep "# of pincer" data/Exp2/n$folder_appval/${app_load_n[app_l_count]}/in$Number/in$Number.3.0.out |cut -d':' -f 2|cut -d' ' -f 2`
let Number=$Number+1
done
let appval_loadsysval=$appval_loadsysval+1
let Number=0
let app_l_count=$app_l_count+1
done
let fd_mult=$fd_mult+1
done
appval_loadsysval=0
printf "%-15s %25s %25s %25s %25s\n" "#systemload" "in0_avg_context switches" "in1_avg_context switches" "in2_avg_context switches" "in3_avg_ context switches">> overhead-exp2;
folder_appval=0
fd_mult=1
folder_appval=$[5*fd_mult]
app_l_count=0
while [ $appval_loadsysval -lt 12 ];do
while [ $app_l_count -lt 3 ];do
alg0_array[$appval_loadsysval,0]=`echo "scale=10;var=${alg0_array[$appval_loadsysval,0]};var/=1000;var"|bc -l`
alg1_array[$appval_loadsysval,0]=`echo "scale=10;var=${alg1_array[$appval_loadsysval,0]};var/=1000;var"|bc -l`
alg2_array[$appval_loadsysval,0]=`echo "scale=10;var=${alg2_array[$appval_loadsysval,0]};var/=1000;var"|bc -l`
alg3_array[$appval_loadsysval,0]=`echo "scale=10;var=${alg3_array[$appval_loadsysval,0]};var/=1000;var"|bc -l`
printf "%-15s %25s %25s %25s %25s\n" $[appval_loadsysval+1] ${alg0_array[$appval_loadsysval,0]} ${alg1_array[$appval_loadsysval,0]} ${alg2_array[$appval_loadsysval,0]} ${alg3_array[$appval_loadsysval,0]} >> overhead-exp2;
let appval_loadsysval=$appval_loadsysval+1
let app_l_count=$app_l_count+1
done 
let app_l_count=0
let fd_mult=$fd_mult+1
folder_appval=$[5*fd_mult]
done
#posterior
appval_loadsysval=0
printf "%-15s %25s %25s %25s %25s\n" "#systemload" "in0_avg_posterior attacks" "in1_avg_posterior attacks" "in2_avg_posterior attacks" "in3_avg_posterior attacks">> results-exp2;
folder_appval=0
fd_mult=1
folder_appval=$[5*fd_mult]
app_l_count=0
while [ $appval_loadsysval -lt 12 ];do
while [ $app_l_count -lt 3 ];do
alg0_array[$appval_loadsysval,1]=`echo "scale=10;var=${alg0_array[$appval_loadsysval,1]};var/=1000;var"|bc -l`
alg1_array[$appval_loadsysval,1]=`echo "scale=10;var=${alg1_array[$appval_loadsysval,1]};var/=1000;var"|bc -l`
alg2_array[$appval_loadsysval,1]=`echo "scale=10;var=${alg2_array[$appval_loadsysval,1]};var/=1000;var"|bc -l`
alg3_array[$appval_loadsysval,1]=`echo "scale=10;var=${alg3_array[$appval_loadsysval,1]};var/=1000;var"|bc -l`
printf "%-15s %25s %25s %25s %25s\n" $[appval_loadsysval+1] ${alg0_array[$appval_loadsysval,1]} ${alg1_array[$appval_loadsysval,1]} ${alg2_array[$appval_loadsysval,1]} ${alg3_array[$appval_loadsysval,1]} >> results-exp2
let appval_loadsysval=$appval_loadsysval+1
let app_l_count=$app_l_count+1
done 
let app_l_count=0
let fd_mult=$fd_mult+1
folder_appval=$[5*fd_mult]
done
echo "" >> results-exp2; echo "" >> results-exp2;
#anterior
appval_loadsysval=0
printf "%-15s %25s %25s %25s %25s\n" "#systemload" "in0_avg_anterior attacks" "in1_avg_anterior attacks" "in2_avg_anterior attacks" "in3_avg_anterior attacks">> results-exp2;
folder_appval=0
fd_mult=1
folder_appval=$[5*fd_mult]
app_l_count=0
while [ $appval_loadsysval -lt 12 ];do
while [ $app_l_count -lt 3 ];do
alg0_array[$appval_loadsysval,2]=`echo "scale=10;var=${alg0_array[$appval_loadsysval,2]};var/=1000;var"|bc -l`
alg1_array[$appval_loadsysval,2]=`echo "scale=10;var=${alg1_array[$appval_loadsysval,2]};var/=1000;var"|bc -l`
alg2_array[$appval_loadsysval,2]=`echo "scale=10;var=${alg2_array[$appval_loadsysval,2]};var/=1000;var"|bc -l`
alg3_array[$appval_loadsysval,2]=`echo "scale=10;var=${alg3_array[$appval_loadsysval,2]};var/=1000;var"|bc -l`
printf "%-15s %25s %25s %25s %25s\n" $[appval_loadsysval+1] ${alg0_array[$appval_loadsysval,2]} ${alg1_array[$appval_loadsysval,2]} ${alg2_array[$appval_loadsysval,2]} ${alg3_array[$appval_loadsysval,2]} >> results-exp2;
let appval_loadsysval=$appval_loadsysval+1
let app_l_count=$app_l_count+1
done 
let app_l_count=0
let fd_mult=$fd_mult+1
folder_appval=$[5*fd_mult]
done
echo "" >>results-exp2;echo "" >>results-exp2;
#pincer
appval_loadsysval=0
printf "%-15s %25s %25s %25s %25s\n" "#systemload" "in0_avg_pincer attacks" "in1_avg_pincer attacks" "in2_avg_pincer attacks" "in3_avg_pincer attacks">> results-exp2;
folder_appval=0
fd_mult=1
folder_appval=$[5*fd_mult]
app_l_count=0
while [ $appval_loadsysval -lt 12 ];do
while [ $app_l_count -lt 3 ];do
alg0_array[$appval_loadsysval,3]=`echo "scale=10;var=${alg0_array[$appval_loadsysval,3]};var/=1000;var"|bc -l`
alg1_array[$appval_loadsysval,3]=`echo "scale=10;var=${alg1_array[$appval_loadsysval,3]};var/=1000;var"|bc -l`
alg2_array[$appval_loadsysval,3]=`echo "scale=10;var=${alg2_array[$appval_loadsysval,3]};var/=1000;var"|bc -l`
alg3_array[$appval_loadsysval,3]=`echo "scale=10;var=${alg3_array[$appval_loadsysval,3]};var/=1000;var"|bc -l`
printf "%-15s %25s %25s %25s %25s\n" $[appval_loadsysval+1] ${alg0_array[$appval_loadsysval,3]} ${alg1_array[$appval_loadsysval,3]} ${alg2_array[$appval_loadsysval,3]} ${alg3_array[$appval_loadsysval,3]} >> results-exp2;
let appval_loadsysval=$appval_loadsysval+1
let app_l_count=$app_l_count+1
done 
let app_l_count=0
let fd_mult=$fd_mult+1
folder_appval=$[5*fd_mult]
done
gnuplot -persist <<-EOFMarker
    set title "Exp2 Averages for Context Switches, posterior, anterior, and pincer attacks at different System Loads" font ",10" textcolor rgbcolor "royalblue" center
#set size  1.05,1.01
set xlabel "System Loads with Number of Applications"
set ylabel "Average Number of Context Switches"
set y2label "Average Number ofAttacks" 
    set xrange [0:13]
    set yrange [0:9500]
    set y2range [0:30]
set xtics ("n5low" 1, "n5med" 2, "n5high" 3, "n10low" 4,"n10medium" 5, "n10high" 6, "n15low" 7, "n15medium" 8, "n15high" 9, "n20low" 10, "n20medium" 11, "n20high" 12)
set key on outside Right box lt 5 lc 145
    set grid ytics        # draw lines for each ytics and y2tics
    set grid y2tics
    set y2tics 0.25          # set the spacing for the y2tics
    set ytics 250          # set the spacing for the y1tics
     set grid xtics         # draw lines for each ytics and mytics
     set grid               # enable the grid
set terminal pngcairo size 2400,1800
set output "Exp2_plot_averages_context switches_posterior_anterior_pincer_attacks.png"     
plot "results-exp2" using 1:2 index 0 axes x1y2 with linespoints title "avg posterior attacks in0",\
    "results-exp2" using 1:3 index 0 axes x1y2 with linespoints title "avg posterior attacks in1",\
    "results-exp2" using 1:4 index 0 axes x1y2 with linespoints title "avg posterior attacks in2",\
    "results-exp2" using 1:5 index 0 axes x1y2 with linespoints title "avg posterior attacks in3"		
set terminal pngcairo size 2400,1800
set output "Exp2_plot_averages_context switches_posterior_anterior_pincer_attacks.png"
 replot "results-exp2" using 1:2 index 1 axes x1y2 with linespoints title "avg anterior attacks in0",\
    "results-exp2" using 1:3 index 1 axes x1y2 with linespoints title "avg anterior attacks in1",\
    "results-exp2" using 1:4 index 1 axes x1y2 with linespoints title "avg anterior attacks in2",\
    "results-exp2" using 1:5 index 1 axes x1y2 with linespoints title "avg anterior attacks in3"	
set terminal pngcairo size 2400,1800
set output "Exp2_plot_averages_context switches_posterior_anterior_pincer_attacks.png"
 replot "results-exp2" using 1:2 index 2 axes x1y2 with linespoints title "avg pincer attacks in0",\
    "results-exp2" using 1:3 index 2 axes x1y2 with linespoints title "avg pincer attacks in1",\
    "results-exp2" using 1:4 index 2 axes x1y2 with linespoints title "avg pincer attacks in2",\
    "results-exp2" using 1:5 index 2 axes x1y2 with linespoints title "avg pincer attacks in3"	
set terminal pngcairo size 2400,1800
set output "Exp2_plot_averages_context switches_posterior_anterior_pincer_attacks.png"
    replot "overhead-exp2" using 1:2 axes x1y1 with linespoints title "avg context switches in0",\
    "overhead-exp2" using 1:3 axes x1y1 with linespoints title "avg context switches in1",\
    "overhead-exp2" using 1:4 axes x1y1 with linespoints title "avg context switches in2",\
    "overhead-exp2" using 1:5 axes x1y1 with linespoints title "avg context switches in3"
EOFMarker


		

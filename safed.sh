#!/bin/bash
#Ahmad Buhisi FINAL PROJECT
#12/11/2018 
#####################################################################################################################################################
#First check if ~/TRASH directory exists if not then create ~/TRASH directory
trash_directory=~/TRASH
if [ ! -d "$trash_directory" ] ; then
mkdir $trash_directory
fi
#####################################################################################################################################################
#Second check input file exists if it does not echo Error file DNE
input_file=$1 #input file name from command line
input_file_intrash=$input_file".gz"
DATE=$(date +%m%d%y) #will be used to append to filename if a similar file name already exists in ~/TRASH
if [ ! -e "$input_file" ]; then
echo "Error: input file $input_file does not exist"
else
STR_filetype=`file $input_file|cut -d' ' -f2`
#if file is already a gunzip then copy over to ~/TRASH directory
if [ $STR_filetype == "gzip" ];then
file_name=`echo "$input_file"|awk -F'/' '{print $(NF)}'`
mv $input_file $trash_directory #if file is gunzip file move file to ~/TRASH
echo "Successfully safe deleted the gunzip file $file_name"
#else if file is just regular file first check if file name exists in trash folder, if so append date to file then zip and copy to Trash
elif [ -f "$input_file" ];then #checking if file exists and it is a file
file_name=`echo "$input_file_intrash"|awk -F'/' '{print $(NF)}'`
if [ -e "$trash_directory/$file_name" ]; then #check if filename exists in ~/TRASH directory
mv $input_file $input_file$DATE #moving file over to file with appended date
gzip $input_file$DATE
mv $input_file$DATE".gz" $trash_directory
file_name=`echo "$input_file"|awk -F'/' '{print $(NF)}'`
echo "Successfully safe deleted the file $file_name"
else
gzip $input_file
mv $input_file".gz" $trash_directory
file_name=`echo "$input_file"|awk -F'/' '{print $(NF)}'`
echo "Successfully safe deleted the file $file_name"
fi
#else if inputfile is a directory
elif [ -d "$input_file" ];then #input file is a directory
#first gunzip all of the files recursively in the directory
gzip -r $input_file
## this for loop will traverse through the directory and it will take the name of all of the subdirectories, store to an array, and then gz all subdirectories
cd $input_file
my_dir=`pwd`
arr_subdir=()
final_subdir=""
for DIR in `find $my_dir -type d`
do
arr_subdir=($DIR "${arr_subdir[@]}")
done
for sub_dir in ${arr_subdir[@]}
do
#file_dirname=`echo $sub_dir|awk -F'/' '{print $(NF)}'`
cd $sub_dir
cd ../
file_dirname=`echo $sub_dir|awk -F'/' '{print $(NF)}'`
tar -czf "$file_dirname.tar.gz" $file_dirname
final_subdir="$file_dirname.tar.gz"
rm -r $file_dirname
done
if [ -e "$trash_directory/$final_subdir" ];then #check if newly created tar.gz file for directory already exists in ~/TRASH then rename with date
file_name=`echo "$final_subdir"|awk -F'.' '{print $(1)}'`
mv $final_subdir $file_name$DATE".tar.gz"
mv "$file_name$DATE.tar.gz" $trash_directory
echo "Successfully safe deleted the directory file $file_name"
else
mv $final_subdir $trash_directory
echo "Successfully safe deleted the directory file $final_subdir"
fi
fi
fi
#remove items older than 1 day from ~/TRASH based on mtime[modified time]
find $trash_directory -mmin +1440 -exec rm {} \;




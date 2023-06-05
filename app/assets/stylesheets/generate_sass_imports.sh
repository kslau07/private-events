#! /bin/bash

# This script creates a file named application.sass.scss
# which generates directories and @imports

# Capitalize first letter of directory

# Afterwards: Instead of just overwriting scss file, copy old file to file-previous.sass.scss
# Add time stamp to old copy

# Order is:
# config/variables
# config/reset
# mixins
# layouts
# everything else

# Gets path of current script
SCRIPT_PATH=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Name of sass file
sass_file=$SCRIPT_PATH/'application.sass.scss'

# Clear file
> $sass_file

dir_arr=($(cd $SCRIPT_PATH; find . -print))
len=${#dir_arr[@]}

# Remove dot
for (( i=0; i<$len; i++ )); do
	if [[ "${dir_arr[i]}" == "." ]]; then
		unset "dir_arr[i]"
	fi
done

# demo_multiple_arrays() {
#   local -n arr1=$1
#   local -n arr2=$2
#   printf '2: %q\n' "${arr2[@]}"
#   printf '1: %q\n' "${arr1[@]}"
# 	echo "${arr1[@]}"
# 	echo "${arr2[@]}"
# }
# array_one=( "one argument" "another argument" )
# array_two=( "array two part one" "array two part two" )
# demo_multiple_arrays array_one array_two

temp=()
remove_substr () { 
	local -n arr1=$1
	length=${#arr1[@]}

	temp2=()
	# temp2+=('foo')

	for (( i=0; i<$length; i++ )); do
		str=$(echo "${arr1[i]}" | sed "s/.\///")
		temp2+=($str)
	done

	echo "${temp2[@]}"
}

len_temp=${#temp[@]}
echo $len_temp
# echo "${temp[@]}"

remove_substr dir_arr

# Remove _
# temp=("one" "two")
# dir_arr=()
# dir_arr=("${temp[@]}") # copy array

# len=${#dir_arr[@]}
# echo $len

# Remove first item which is a dot(.)
# dir_arr=("${dir_arr[@]:1}")
# dir_arr=$("$dir_arr" | sed "s/_//g")				# remove _
# dir_arr=$("$dir_arr" | sed "s/.//g")				# remove ./

# Loop through array to see what's in it
# for (( i=0; i<$len; i++ )); do echo item: ${dir_arr[i]}; done

multi_string="// config
@import 'config/variables';
@import 'config/reset';"

# Quote "" to preserve new lines
echo "$multi_string" >> $sass_file

# List of items to remove from dir_arr
not_needed_arr=("config" "sass")
len_not_needed=${#not_needed_arr[*]}

# Remove unwanted items from array
# Uses nested loop, dir_arr & not_needed_arr
for (( i=0; i<$len; i++ )); do
	for (( j=0; j<$len_not_needed; j++ )); do
		if [[ "${dir_arr[i]}" == *"${not_needed_arr[j]}"* ]]; then
			# echo 'a match was found:' "${dir_arr[i]}"
			unset "dir_arr[i]"																# Delete item from array
			# elif [[ $str == *".scss"* ]]; then
			# whatever you want to do when array contains value
		fi
	done
done

for (( i=0; i<$len; i++ )); do												# Remove "config" dir&files from array
	if [[ "${dir_arr[i]}" == *"config"* ]]; then
		unset "dir_arr[i]"																# Delete item from array
	fi
done


for (( i=0; i<$len; i++ )); do

	# For item: remove dot(.) and fwd-slash (\/)
	# Note how echo does not print
	str=$(echo "${dir_arr[i]}" | sed "s/.\///")
	str=$(echo $str | sed "s/_//g") 			# remove _


	# Next if empty string or app file
	# if [[ $str == "application.sass.scss" ]]; then
  #   continue
	# elif [[ $str == "" ]]; then
	# 	continue
  # fi

	# We have 2 groups, .scss files and directory names
	if [[ $str != *"."* ]]; then

		# line count of sass file (< removes directory path from str)
		line_count=$(wc -l < $sass_file)
				
		# Insert new lines for each directory
		# If line_count in sass_file is gt 0
		# (since first line should need a blank line)
		if [ $line_count -gt 0 ]; then
			new_line='
			'
			echo $nl >> $sass_file
		fi

		# Insert directory as comment
		echo "// $str" >> $sass_file

	elif [[ $str == *".scss"* ]]; then

		# Cut file extension, keep name
		edit=$(echo $str | grep -o "^[^\.]*")
		
		# Final string
		echo "@import \"$edit\";" >> $sass_file
	fi
done


#! /bin/bash

# This script automatically adds imports to application.sass.scss

# To do:
# Capitalize first letter of directory

# Order of imports is:
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

# Remove any items that are just a dot
for (( i=0; i<$len; i++ )); do
	if [[ "${dir_arr[i]}" == "." ]]; then
		unset "dir_arr[i]"
	fi
done

# Temp array for dir_arr
array2=()

remove_substr () { 
	index=0
	local -n _array1=$1
	local -n _array2=$2
	substr=$3

	len_array1=${#_array1[@]}

	# for (( i=0; i<$len_array1; i++ )); do
	# 	str=$(echo "${_array1[i]}" | sed "s/$substr//")
	# 	_array2+=($str)
	# done

	# Alternative way
	for item in "${_array1[@]}"; do
			item_cut=$(echo "$item" | sed "s/$substr//")
			_array2["$index"]="$item_cut"
			((index++))
	done
}
remove_substr dir_arr array2 ".\/"

# Set array2 to dir_arr (remember to use parens for setting an arr)
dir_arr=(${array2[@]})

# Manually add config dir first
multi_string="// config
@import 'config/variables';
@import 'config/reset';"
echo "$multi_string" >> $sass_file				# Use "" to keep new lines

# List of items to remove from dir_arr
not_needed_arr=("config" "sass.scss")
len_not_needed=${#not_needed_arr[*]}

# Remove unwanted items from dir_arr
# Uses nested loop (dir_arr & not_needed_arr)
for (( i=0; i<$len; i++ )); do
	for (( j=0; j<$len_not_needed; j++ )); do
		if [[ "${dir_arr[i]}" == *"${not_needed_arr[j]}"* ]]; then
			unset "dir_arr[i]"																# Delete item from array
		fi
	done
done

# Loop through dir_arr and add imports
for item in "${dir_arr[@]}"; do
	# We have 2 groups, .scss files and directory names
	if [[ $item != *"."* ]]; then

		# line count of sass file (< removes dir path from str)
		line_count=$(wc -l < $sass_file)
				
		# Insert new lines for each directory
		# (skip first row 0)
		if [ $line_count -gt 0 ]; then
			new_line='
			'
			echo $new_line >> $sass_file
		fi

		# Insert directory as comment
		echo "// $item" >> $sass_file

	elif [[ $item == *".scss"* ]]; then

		# Cut file extension, keep name
		edit=$(echo $item | grep -o "^[^\.]*")
		
		# Insert import
		echo "@import \"$edit\";" >> $sass_file
	fi
done
#!/usr/bin/env bash

# This file is part of eRCaGuy_hello_world: https://github.com/ElectricRCAircraftGuy/eRCaGuy_hello_world

# GS
# 3 Mar. 2022

# Practice capturing newline-separated string output from `ls -1` and `find` into regular
# bash "indexed" arrays, then printing it.

# keywords: bash arrays; mapfile; read -r; here string; herestring; bash arrays; bash
# regular "indexed" arrays; printing bash arrays; bash array length; bash array indices; bash array
# practice

# Check this script with: `shellcheck array_list_all_files_and_directories.sh`

# Run command:
#       ./array_list_all_files_and_directories.sh

# References:
# 1. How to get the list of files in a directory in a shell script?:
#    https://stackoverflow.com/q/2437452/4561887
#   1. *****+[my own answer there] https://stackoverflow.com/a/71345102/4561887
# 1. How to exclude this / current / dot folder from find "type d" (use also `-mindepth 1`
#    with `find`): https://stackoverflow.com/a/13525005/4561887


echo "Output of 'ls -1'"
echo "-----------------"
ls -1
echo ""

# Capture the output of `ls -1` into a regular bash "indexed" array.
# - includes both files AND directories!
mapfile -t allfilenames_array <<< "$(ls -1)"
# Capture the output of `find` into a regular bash "indexed" array
# - includes directories ONLY!
# Note: for other `-type` options, see `man find` and see my answer here:
# https://stackoverflow.com/a/71345102/4561887
mapfile -t dirnames_array <<< "$(find . -mindepth 1 -maxdepth 1 -type d)"

# Get the number of elements in each array
allfilenames_array_len="${#allfilenames_array[@]}"
dirnames_array_len="${#dirnames_array[@]}"

# 1. Now manually print all elements in each array

echo "All filenames (files AND dirs) (count = $allfilenames_array_len):"
for filename in "${allfilenames_array[@]}"; do
    echo "    $filename"
done
echo "Dirnames ONLY (count = $dirnames_array_len):"
for dirname in "${dirnames_array[@]}"; do
    # remove the `./` from the beginning of each dirname
    dirname="$(basename "$dirname")"
    echo "    $dirname"
done
echo ""

# OR, 2. manually print the index number followed by all elements in the array

echo "All filenames (files AND dirs) (count = $allfilenames_array_len):"
for i in "${!allfilenames_array[@]}"; do
    printf "  %3i: %s\n" "$i" "${allfilenames_array["$i"]}"
done
echo "Dirnames ONLY (count = $dirnames_array_len):"
for i in "${!dirnames_array[@]}"; do
    # remove the `./` from the beginning of each dirname
    dirname="$(basename "${dirnames_array["$i"]}")"
    printf "  %3i: %s\n" "$i" "$dirname"
done
echo ""



# SAMPLE OUTPUT:
#
#       eRCaGuy_hello_world/python$ ../bash/array_list_all_files_and_directories.sh
#       Output of 'ls -1'
#       -----------------
#       autogenerate_c_or_cpp_code.py
#       autogenerated
#       auto_white_balance_img.py
#       enum_practice.py
#       raw_bytes_practice.py
#       slots_practice
#       socket_talk_to_ethernet_device.py
#       textwrap_practice_1.py
#       yaml_import
#
#       All filenames (files AND dirs) (count = 9):
#           autogenerate_c_or_cpp_code.py
#           autogenerated
#           auto_white_balance_img.py
#           enum_practice.py
#           raw_bytes_practice.py
#           slots_practice
#           socket_talk_to_ethernet_device.py
#           textwrap_practice_1.py
#           yaml_import
#       Dirnames ONLY (count = 3):
#           yaml_import
#           slots_practice
#           autogenerated
#
#       All filenames (files AND dirs) (count = 9):
#           0: autogenerate_c_or_cpp_code.py
#           1: autogenerated
#           2: auto_white_balance_img.py
#           3: enum_practice.py
#           4: raw_bytes_practice.py
#           5: slots_practice
#           6: socket_talk_to_ethernet_device.py
#           7: textwrap_practice_1.py
#           8: yaml_import
#       Dirnames ONLY (count = 3):
#           0: yaml_import
#           1: slots_practice
#           2: autogenerated
#

#! /bin/bash
# tga2png.sh
# Batch convert targa files to png files

for p in *.tga; do 
  if [ ! -e "${p/tga/png}" ]; then
    convert "$p" "${p/tga/png}"
	echo "${p/tga/png} has been created."
  fi
done

exit 0

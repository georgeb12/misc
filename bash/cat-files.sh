#! /bin/bash
# Combine similar files into a megafile
# makes it easier for quick reference.
# 24 Jan 2015

if [ $# -ne 2 ]; then
	echo "Usage: $0 root_of_file extension"
	exit 1
fi

mf=$1" combined"


# inform them of file name and let them know it's a new file
# this is mostly saved as a template for file existence testing
if [ ! -e "$mf".$2 ]; then
  echo "$mf.$2 has been created."
fi

for p in $1*.$2; do
  if [ "$p" -nt "$mf".$2 ]; then
    echo -e "\n" >> "$mf"
    echo -e "Adding $p to $mf.$2"
    echo "/*-----------------------" >> "$mf"
    echo -e "Begin $p" >> "$mf"
    echo "-----------------------*/" >> "$mf"
    echo -e "\n" >> "$mf"
    cat "$p" >> "$mf"
  fi
done

# the sas extension is added after the loop to prevent
# it from recursively being added to itself.
# as well as messing with timestamps
if [ -e "$mf" ]; then
  cat "$mf" >> "$mf".$2
  rm "$mf"
  echo "Done."
else
  echo "Files are already up to date."
  echo "No action taken."
  exit 2
fi

unset mf

exit 0


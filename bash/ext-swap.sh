#! /bin/bash
# ext-swap.sh
#  Batch swap the extension for one file type to another
#  (e.g. ex.foo becomes ex.bar)
# 12/17/14 Paul Egeler

# Usage: ./ext-swap.sh current_ext target_ext [recursive(any string)]
if [ $# -lt 2 ] || [ $# -gt 3 ]; then
  echo -e "Usage: $0 extension_in extension_out [r]"
   exit 1
fi
   

# This will do the recursive renaming
if [ $3 ]; then
  for f in **/*.$1; do
   mv "$f" "${f/.$1/.$2}"
  done
fi

# And this will do renaming for the current directory
for f in *.$1; do 
  mv "$f" "${f/.$1/.$2}"
done

#check to see if it worked...
ls -R | grep [crd,cor]

exit 0

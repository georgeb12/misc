#! /bin/bash
# incr.sh
#   Increment group of numbered files by one.
#   (e.g. foo1.bar becomes foo2.bar)
# 8/6/14

# Usage: ./incr.sh root_file low_no. high_no. extension
if [ $# -ne 4 ]
 then
 echo -e "Usage:\r\n $0 root_file low_no. high_no. extension"
 exit 1
fi

 # Initialize counters
 i=$3
 j=`expr $3 + 1`

while [ $i -ge $2 ]
 do
 # Rename file to one file number higher
 mv $1$i.$4 $1$j.$4
 echo "File $1$i.$4 is now $1$j.$4"
 
 # Decrement counters
 i=`expr $i - 1`
 j=`expr $j - 1`
 
done

exit 0 


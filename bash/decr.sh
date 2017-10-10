#! /bin/bash
# decr.sh
#   Decrement group of numbered files by one.
#   (e.g. foo1.bar becomes foo0.bar)
# 8/6/14 Paul Egeler

# Usage: ./decr.sh root_file start_no. final_no. extension
if [ $# -ne 4 ]
 then
 echo -e "Usage:\r\n $0 root_file start_no. final_no. extension"
 exit 1
fi

 #Initialize counters
 i=$2
 j=`expr $2 - 1`

while [ $i -le $3 ]
 do
 #Rename file to one file number lower
 mv $1$i.$4 $1$j.$4
 echo "File $1$i.$4 is now $1$j.$4"
 
 #Increment counters
 i=`expr $i + 1`
 j=`expr $j + 1`
 
done

exit 0 


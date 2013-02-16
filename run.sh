#!/bin/sh

HOME=$PWD

echo $HOME

cd src/; make all

cd $HOME

echo "parsing the abc namespace"
rm -r intermediate/namespace
mkdir intermediate/namespace

cat abc/src/base/abc/abc.h | ./stage-1 | ./stage-2

#find abc/. -name "*.h" | while read i; 
#do 
#  cat $i | ./stage-1 >> intermediate/namespace/$(basename $i); 
#done
#rm -f $(find intermediate/namespace/. -empty)
#
#echo "processing declarations"
#for f in intermediate/namespace/*;
#do
#  echo "\n>>> Auditing $f.  Continue? (press s to skip)"
#  read OK
#  if [ "$OK" = "s" ]; then
#    break;
#  fi
#  cat $f
#done

cd $HOME/src; make clean









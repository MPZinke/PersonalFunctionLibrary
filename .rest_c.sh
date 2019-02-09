
#!/bin/bash

###################################################
#
#	-Bash script to remove contents in main of
#        test.c
#
###################################################

if [ -f test.c ] && rm test.c;
then
    	cp ~/Other/template.c test.c
elif [ ! -f test.c ]
then
    	cp ~/Other/template.c test.c
fi
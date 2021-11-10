# http-dirlist-processing.sh
## this assumes a list of paths obtained from wherever but ultimately put into a list with one path per line and no leading /

if [ -z "$1" ]

        then echo "Usage: ./http-dirlist-processing.sh unprocessed-list.txt"
        else
                inputFile=$1
                midFile=$inputFile.mid

### this determines the max number of / fields in the initial list

                x=$(sed 's/[^/]//g' $inputFile | awk '{ print length }' | sort -rn | uniq | head -n 1)

### loops to assemble enriched list

                cat $inputFile | sort | uniq >> $midFile
                i=1
                while [ $i -le $((x+1)) ]
                        do
                                cat $inputFile | cut -d '/' -f $i- | sort | uniq >> $midFile
                                i=$((i+1))
                        done

                i=1
                while [ $i -le $((x+1)) ]
                        do
                                cat $inputFile | cut -d '/' -f -$i | sort | uniq >> $midFile
                                i=$((i+1))
                        done

### final filter down

                cat $midFile | sort | uniq >> processed-list.txt

### clean up

                rm $midFile

fi

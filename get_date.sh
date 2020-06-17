#!/bin/bash

#
# 

Usage(){
    echo "Usage: " `basename $0` "[option] [date/number]"
    echo "  convert date time to number of minutes from 1996/1/1"
    echo "  or get time from the number"
    echo "    [option] : "
    echo "       -d    : return number of minutes from 1996/1/1 to [date]"
    echo "       -r    : return date from the number"
    echo "       -h    : show this message"
    echo "    If option is empty, retrun the number of minutes from 1996/1/1 to now"
    exit 1
}
start=$(date -d "1996/1/1" +%s)

get_number(){
    if [ "$1" -le $start ];then
        echo -e "\nnot correct date!!\n"
    fi
    echo "( $1 - $start ) / 60" | bc
}

get_date(){
    ds=`expr $1 \* 60 + $start`
    if [ -z "$ds" ];then
        echo -e "\nnot valid date time!!\n"
        exit 1
    fi
    echo $(date -d @$ds)
}


### main ###
if [ -z "$1" ];then
    get_number $(date +%s)
# show usage if using option and set empty parameter
elif [ "$1" == "-h" -o "$1" == "--help" -o -z "$2" ];then
    Usage
elif [ "$1" == "-d" ];then
    # echo "date: $2"
    mydate=$(date -d "$2" +%s)
    if [ -n $mydate ];then
        get_number $mydate
    fi
elif [ "$1" == "-r" ];then
    get_date $2
else
    Usage
fi

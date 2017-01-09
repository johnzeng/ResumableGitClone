#!/bin/bash

DEPTH_RECORD_FILE=.resumable_git_depth
OUT_FILE=rgit.out

if [ 0 -eq $# ]
then
    depth=`cat ${DEPTH_RECORD_FILE}`
    if [[ "" == $depth ]]
    then
        echo "can not find resume record in current dir"
        exit 1
    fi
elif [ 1 -eq $# ]
then
    echo "now clone the 1st layer"
    clone_str=`git clone --depth 1 $1 2>&1|grep Cloning`
    [[ "$clone_str" =~ \'(.*)\' ]] && work_dir=${BASH_REMATCH[1]}

    if [[ "$work_dir" == "" ]]
    then
        echo "fail to clone"
        exit 1
    fi

    cd $work_dir
    depth=2
fi

step=1

while true
do
    echo ${depth} > $DEPTH_RECORD_FILE
    echo "fetch depth $depth"
    git fetch --depth $depth --progress  2>$OUT_FILE
    if [ 0 -eq $? ]
    then
        step=$depth
        depth=`expr $depth + $depth`
    else
        depth=`expr $depth - $step / 2`
        step=`expr $step / 2`
        if [ 0 -eq $step ]
        then
            step=1
        fi
    fi

    cat $OUT_FILE | grep "remote: Total 0 (delta 0), reused 0 (delta 0), pack-reused 0" 

    if [ 0 -eq $? ]
    then
        echo 'fetch over'
        break
    fi
done

# finally , fetch branches
echo 'now fetch branches'
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"; git fetch origin
echo 'done ^_^'
rm $OUT_FILE
rm $DEPTH_RECORD_FILE

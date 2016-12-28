#!/bin/bash

if [ 0 -eq $# ]
then
    echo "use: $0 [clone url]"
    exit 1
fi

echo "now clone one layer"
clone_str=`git clone --depth 1 $1 2>&1|grep Cloning`
[[ "$clone_str" =~ \'(.*)\' ]] && work_dir=${BASH_REMATCH[1]}

if [[ "$work_dir" == "" ]]
then
    echo "fail to clone"
    exit 1
fi

cd $work_dir
depth=2
step=1

while true
do
    echo "fetch depth $depth"
    git fetch --depth $depth --progress  2>../rgit.out
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

    cat ../rgit.out | grep "remote: Total 0 (delta 0), reused 0 (delta 0), pack-reused 0" 

    if [ 0 -eq $? ]
    then
        echo 'fetch over'
        rm ../rgit.out
        break
    fi
done

# finally , fetch branches
echo 'now fetch branches'
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"; git fetch origin
echo 'done ^_^'

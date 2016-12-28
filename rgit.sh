#!/bin/bash

clone_str=`git clone --depth 1 $1 2>&1|grep Cloning`
echo $clone_str
[[ "$clone_str" =~ \'(.*)\' ]] && work_dir=${BASH_REMATCH[1]}

if [[ "$work_dir" == "" ]]
then
    echo "fail to clone"
    exit 1
fi

cd $work_dir
pwd
step=1

while true
do
    echo "depth is $step"
    fetch_str=`git fetch --depth $step`
    if [[ "$fetch_str" -eq "remote: Total 0 (delta 0), reused 0 (delta 0), pack-reused 0" ]]
    then
        break
    fi
    if [ 0 -eq $? ]
    then
        step=`expr $step + $step`
    else
        step=`expr $step / 2`
    fi
done

# finally , fetch branches
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"; git fetch origin

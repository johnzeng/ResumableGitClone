#!/bin/bash

DEPTH_RECORD_FILE=.resumable_git_depth
OUT_FILE=rgit.out

if [ "-h" = "$1" ] || [ "--help" = "$1" ]
then
    cat <<EOF
Clone a large git_repo without retrying again and again.

Usage: $0 [-h|--help] [git_repo_url [dir] [...git_clone_options]]
EOF
    exit 2
fi

if [ 0 -eq $# ]
then
    depth=`cat ${DEPTH_RECORD_FILE}`
    if [[ "" == $depth ]]
    then
        echo "can not find resume record in current dir"
        exit 1
    fi
else
    echo "now clone the 1st layer"

    if [ ! -z "$2" ] && [ "-" != ${2:0:1} ]
    then
        target_dir="$2"
    fi

    clone_str=`git clone --depth 1 "$@" 2>&1 | grep Cloning`

    if [ -z "$target_dir" ]
    then
        if [[ "$clone_str" =~ \'(.*)\' ]]
        then
            work_dir=${BASH_REMATCH[1]}

            if [[ "$work_dir" == "" ]]
            then
                echo "fail to clone"
                exit 1
            fi

            cd $work_dir
        fi
    else
        cd "$target_dir"
    fi

    if [ -e "$DEPTH_RECORD_FILE" ]
    then
        depth=`cat ${DEPTH_RECORD_FILE}`
    else
        depth=2
    fi
fi

step=1
done_time=0
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
        ## should move 2 times over
        echo 'maybe fetch over'
        if [ 2 -eq  $done_time ]
        then
            echo 'fetch over'
            break
        else
            done_time=`expr $done_time + 1`
        fi
    else
        done_time=0
    fi
done

# finally , fetch branches
echo 'now fetch branches'
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"; git fetch origin
echo 'done ^_^'
rm $OUT_FILE
rm $DEPTH_RECORD_FILE

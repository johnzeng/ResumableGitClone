# Resumable git clone

Clone a large repo without retrying again and again.

## how to use

- clone this repo or just download the rgit.sh file into your pc
- `./rgit.sh [-h|--help] [git_repo_url [dir] [...git_clone_options]]`
- sip tee

you can also put `rgit.sh` to your $PATH, so you don't need to open this repo to call this command

## how to resume

if you happened to stop this script ,and you wanna restart the clone,

- `cd` to the dir of your repo
- run `rgit.sh` (so I suggest you to add rgit.sh to your $PATH)

## tricky files

To make this script works, I will create the following files in the cloned repo directory to record the process.

- rgit.out  -> used to record the git output, so rgit can know if the fetch is done or not (You can delete it if you interrupt the process, the script will create a new one, nothing goes wrong)
- .resumable_git_depth -> used to record the git fetched depth, so rgit can know where to start from. This file is necessary if you wanna resume the clone. (deleting this file will stop this script from resuming the clone.You can of course set up a custom depth in this file to continue the clone by yourself)

## Sample output

This is the output about how it works when I try to clone redis from github. It's really a hard fight, you can't image how much work you will have to do if you do it manually

```shell
rgit https://github.com/antirez/redis.git
now clone one layer
fetch depth 2
fetch depth 4
fetch depth 8
fetch depth 16
fetch depth 32
fetch depth 64
fetch depth 128
fetch depth 96
fetch depth 80
fetch depth 72
fetch depth 144
fetch depth 108
fetch depth 90
fetch depth 81
fetch depth 77
fetch depth 154
fetch depth 116
fetch depth 232
fetch depth 464
fetch depth 928
fetch depth 1856
fetch depth 3712
remote: Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
fetch over
now fetch branches
remote: Counting objects: 15775, done.
remote: Compressing objects: 100% (135/135), done.
remote: Total 15775 (delta 3079), reused 3214 (delta 3079), pack-reused 12561
Receiving objects: 100% (15775/15775), 5.56 MiB | 649.00 KiB/s, done.
Resolving deltas: 100% (10834/10834), completed with 279 local objects.
From https://github.com/antirez/redis
 * [new branch]      2.2                      -> origin/2.2
 * [new branch]      2.4                      -> origin/2.4
 * [new branch]      2.6                      -> origin/2.6
 * [new branch]      2.8                      -> origin/2.8
 * [new branch]      3.0                      -> origin/3.0
 * [new branch]      3.2                      -> origin/3.2
 * [new branch]      4.0                      -> origin/4.0
 * [new branch]      aofrdb                   -> origin/aofrdb
 * [new branch]      cow-pipe                 -> origin/cow-pipe
 * [new branch]      current-client-fix       -> origin/current-client-fix
 * [new branch]      dict-clustered-entries   -> origin/dict-clustered-entries
 * [new branch]      dictc                    -> origin/dictc
 * [new branch]      freelist                 -> origin/freelist
 * [new branch]      issue_2175               -> origin/issue_2175
 * [new branch]      latency                  -> origin/latency
 * [new branch]      lazyfree                 -> origin/lazyfree
 * [new branch]      ldb                      -> origin/ldb
 * [new branch]      less-mstime              -> origin/less-mstime
 * [new branch]      less-mstime-28           -> origin/less-mstime-28
 * [new branch]      memsync                  -> origin/memsync
 * [new branch]      module-blocking-commands -> origin/module-blocking-commands
 * [new branch]      module-io-context        -> origin/module-io-context
 * [new branch]      multi-if                 -> origin/multi-if
 * [new branch]      nosync                   -> origin/nosync
 * [new branch]      onepass-bulk             -> origin/onepass-bulk
 * [new branch]      rdbchanges               -> origin/rdbchanges
 * [new branch]      rssmaxmemory             -> origin/rssmaxmemory
 * [new branch]      slave-diskless           -> origin/slave-diskless
 * [new branch]      strcompr                 -> origin/strcompr
 * [new branch]      waitpid-fix              -> origin/waitpid-fix
 * [new branch]      zaddnx                   -> origin/zaddnx
 * [new branch]      zunion                   -> origin/zunion
 * [new tag]         2.2.15                   -> 2.2.15
 * [new tag]         2.4.18                   -> 2.4.18
 * [new tag]         2.2.0                    -> 2.2.0
 * [new tag]         2.2.0-rc2                -> 2.2.0-rc2
 * [new tag]         2.2.0-rc3                -> 2.2.0-rc3
 * [new tag]         2.2.0-rc4                -> 2.2.0-rc4
 * [new tag]         2.2.1                    -> 2.2.1
 * [new tag]         2.2.10                   -> 2.2.10
 * [new tag]         2.2.11                   -> 2.2.11
 * [new tag]         2.2.12                   -> 2.2.12
 * [new tag]         2.2.13                   -> 2.2.13
 * [new tag]         2.2.14                   -> 2.2.14
 * [new tag]         2.2.2                    -> 2.2.2
 * [new tag]         2.2.3                    -> 2.2.3
 * [new tag]         2.2.4                    -> 2.2.4
 * [new tag]         2.2.5                    -> 2.2.5
 * [new tag]         2.2.6                    -> 2.2.6
 * [new tag]         2.2.7                    -> 2.2.7
 * [new tag]         2.2.8                    -> 2.2.8
 * [new tag]         2.2.9                    -> 2.2.9
 * [new tag]         2.4.0                    -> 2.4.0
 * [new tag]         2.4.0-rc1                -> 2.4.0-rc1
 * [new tag]         2.4.0-rc2                -> 2.4.0-rc2
 * [new tag]         2.4.0-rc3                -> 2.4.0-rc3
 * [new tag]         2.4.0-rc4                -> 2.4.0-rc4
 * [new tag]         2.4.0-rc5                -> 2.4.0-rc5
 * [new tag]         2.4.0-rc6                -> 2.4.0-rc6
 * [new tag]         2.4.0-rc7                -> 2.4.0-rc7
 * [new tag]         2.4.0-rc8                -> 2.4.0-rc8
 * [new tag]         2.4.1                    -> 2.4.1
 * [new tag]         2.4.10                   -> 2.4.10
 * [new tag]         2.4.11                   -> 2.4.11
 * [new tag]         2.4.12                   -> 2.4.12
 * [new tag]         2.4.13                   -> 2.4.13
 * [new tag]         2.4.14                   -> 2.4.14
 * [new tag]         2.4.15                   -> 2.4.15
 * [new tag]         2.4.16                   -> 2.4.16
 * [new tag]         2.4.17                   -> 2.4.17
 * [new tag]         2.4.2                    -> 2.4.2
 * [new tag]         2.4.3                    -> 2.4.3
 * [new tag]         2.4.4                    -> 2.4.4
 * [new tag]         2.4.5                    -> 2.4.5
 * [new tag]         2.4.6                    -> 2.4.6
 * [new tag]         2.4.7                    -> 2.4.7
 * [new tag]         2.4.8                    -> 2.4.8
 * [new tag]         2.4.9                    -> 2.4.9
 * [new tag]         2.6.0                    -> 2.6.0
 * [new tag]         2.6.0-rc1                -> 2.6.0-rc1
 * [new tag]         2.6.0-rc2                -> 2.6.0-rc2
 * [new tag]         2.6.0-rc3                -> 2.6.0-rc3
 * [new tag]         2.6.0-rc4                -> 2.6.0-rc4
 * [new tag]         2.6.0-rc5                -> 2.6.0-rc5
 * [new tag]         2.6.0-rc6                -> 2.6.0-rc6
 * [new tag]         2.6.0-rc7                -> 2.6.0-rc7
 * [new tag]         2.6.0-rc8                -> 2.6.0-rc8
 * [new tag]         2.6.1                    -> 2.6.1
 * [new tag]         2.6.10                   -> 2.6.10
 * [new tag]         2.6.11                   -> 2.6.11
 * [new tag]         2.6.12                   -> 2.6.12
 * [new tag]         2.6.13                   -> 2.6.13
 * [new tag]         2.6.14                   -> 2.6.14
 * [new tag]         2.6.15                   -> 2.6.15
 * [new tag]         2.6.16                   -> 2.6.16
 * [new tag]         2.6.17                   -> 2.6.17
 * [new tag]         2.6.2                    -> 2.6.2
 * [new tag]         2.6.3                    -> 2.6.3
 * [new tag]         2.6.4                    -> 2.6.4
 * [new tag]         2.6.5                    -> 2.6.5
 * [new tag]         2.6.6                    -> 2.6.6
 * [new tag]         2.6.7                    -> 2.6.7
 * [new tag]         2.6.8                    -> 2.6.8
 * [new tag]         2.6.9                    -> 2.6.9
 * [new tag]         2.8.0                    -> 2.8.0
 * [new tag]         2.8.0-rc1                -> 2.8.0-rc1
 * [new tag]         2.8.0-rc2                -> 2.8.0-rc2
 * [new tag]         2.8.0-rc3                -> 2.8.0-rc3
 * [new tag]         2.8.0-rc4                -> 2.8.0-rc4
 * [new tag]         2.8.0-rc5                -> 2.8.0-rc5
 * [new tag]         2.8.0-rc6                -> 2.8.0-rc6
 * [new tag]         2.8.1                    -> 2.8.1
 * [new tag]         2.8.10                   -> 2.8.10
 * [new tag]         2.8.11                   -> 2.8.11
 * [new tag]         2.8.12                   -> 2.8.12
 * [new tag]         2.8.13                   -> 2.8.13
 * [new tag]         2.8.14                   -> 2.8.14
 * [new tag]         2.8.15                   -> 2.8.15
 * [new tag]         2.8.16                   -> 2.8.16
 * [new tag]         2.8.17                   -> 2.8.17
 * [new tag]         2.8.18                   -> 2.8.18
 * [new tag]         2.8.19                   -> 2.8.19
 * [new tag]         2.8.2                    -> 2.8.2
 * [new tag]         2.8.20                   -> 2.8.20
 * [new tag]         2.8.21                   -> 2.8.21
 * [new tag]         2.8.22                   -> 2.8.22
 * [new tag]         2.8.23                   -> 2.8.23
 * [new tag]         2.8.24                   -> 2.8.24
 * [new tag]         2.8.3                    -> 2.8.3
 * [new tag]         2.8.4                    -> 2.8.4
 * [new tag]         2.8.5                    -> 2.8.5
 * [new tag]         2.8.6                    -> 2.8.6
 * [new tag]         2.8.7                    -> 2.8.7
 * [new tag]         2.8.8                    -> 2.8.8
 * [new tag]         2.8.9                    -> 2.8.9
 * [new tag]         3.0.0                    -> 3.0.0
 * [new tag]         3.0.0-beta1              -> 3.0.0-beta1
 * [new tag]         3.0.0-beta2              -> 3.0.0-beta2
 * [new tag]         3.0.0-beta3              -> 3.0.0-beta3
 * [new tag]         3.0.0-beta4              -> 3.0.0-beta4
 * [new tag]         3.0.0-beta5              -> 3.0.0-beta5
 * [new tag]         3.0.0-beta6              -> 3.0.0-beta6
 * [new tag]         3.0.0-beta7              -> 3.0.0-beta7
 * [new tag]         3.0.0-beta8              -> 3.0.0-beta8
 * [new tag]         3.0.0-rc1                -> 3.0.0-rc1
 * [new tag]         3.0.0-rc2                -> 3.0.0-rc2
 * [new tag]         3.0.0-rc3                -> 3.0.0-rc3
 * [new tag]         3.0.0-rc4                -> 3.0.0-rc4
 * [new tag]         3.0.0-rc5                -> 3.0.0-rc5
 * [new tag]         3.0.0-rc6                -> 3.0.0-rc6
 * [new tag]         3.0.1                    -> 3.0.1
 * [new tag]         3.0.2                    -> 3.0.2
 * [new tag]         3.0.3                    -> 3.0.3
 * [new tag]         3.0.4                    -> 3.0.4
 * [new tag]         3.0.5                    -> 3.0.5
 * [new tag]         3.0.6                    -> 3.0.6
 * [new tag]         3.0.7                    -> 3.0.7
 * [new tag]         3.2-rc1                  -> 3.2-rc1
 * [new tag]         3.2.0                    -> 3.2.0
 * [new tag]         3.2.0-rc2                -> 3.2.0-rc2
 * [new tag]         3.2.0-rc3                -> 3.2.0-rc3
 * [new tag]         3.2.1                    -> 3.2.1
 * [new tag]         3.2.2                    -> 3.2.2
 * [new tag]         3.2.3                    -> 3.2.3
 * [new tag]         3.2.4                    -> 3.2.4
 * [new tag]         3.2.5                    -> 3.2.5
 * [new tag]         3.2.6                    -> 3.2.6
 * [new tag]         4.0-rc1                  -> 4.0-rc1
 * [new tag]         4.0-rc2                  -> 4.0-rc2
done ^_^
```

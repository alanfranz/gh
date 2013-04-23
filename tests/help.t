setup

  $ gh="$TESTDIR/../gh/gh.py"

summary

  $ $gh
  
  Usage: *gh* COMMAND <options> (glob)
  
  Available commands:
  
   add       mark untracked files to be committed
   branch    create a branch
   branches  list all branches
   diff      show diffs
   glog      graph changesets
   log       list changesets
   revert    restore files to an earlier state
  
  Use "*gh* <command> --help" for individual command help. (glob)
  $ $gh help
  
  Usage: *gh* COMMAND <options> (glob)
  
  Available commands:
  
   add       mark untracked files to be committed
   branch    create a branch
   branches  list all branches
   diff      show diffs
   glog      graph changesets
   log       list changesets
   revert    restore files to an earlier state
  
  Use "*gh* <command> --help" for individual command help. (glob)
  $ $gh --help
  
  Usage: *gh* COMMAND <options> (glob)
  
  Available commands:
  
   add       mark untracked files to be committed
   branch    create a branch
   branches  list all branches
   diff      show diffs
   glog      graph changesets
   log       list changesets
   revert    restore files to an earlier state
  
  Use "*gh* <command> --help" for individual command help. (glob)

branches

  $ $gh help branches
  
  Usage: *gh* branches (glob)
  
  list all branches
  
  $ $gh branches --help
  
  Usage: *gh* branches (glob)
  
  list all branches
  

log

  $ $gh help log
  
  Usage: *gh* log (glob)
  
  list changesets
  
  Options:
  
   -l --limit  list at most N changesets
  

diff

  $ $gh help diff
  
  Usage: *gh* diff (glob)
  
  show diffs
  
  Options:
  
   -c --change  show the diff of the change made by a revision
   -i --index   diff the working dir against the index
   -r --rev     diff the working dir against a revision
   -s --staged  show the diff of the changes in the index
  

add

  $ $gh help add
  
  Usage: *gh* add (glob)
  
  mark untracked files to be committed
  

glog

  $ $gh help glog
  
  Usage: *gh* glog (glob)
  
  graph changesets
  
  Options:
  
   -l --limit  list at most N changesets
  

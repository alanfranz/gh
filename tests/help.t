setup

  $ gh="$TESTDIR/../gh.py"

summary

  $ $gh
  
  Usage: /Users/sjl/src/gh/tests/../gh.py COMMAND <options>
  
  Available commands:
  
   add       mark untracked files to be committed
   branch    create a branch
   branches  list all branches
   diff      show diffs
   glog      graph changesets
   log       list changesets
   revert    restore files to an earlier state
  
  Use "/Users/sjl/src/gh/tests/../gh.py <command> --help" for individual command help.
  $ $gh help
  
  Usage: /Users/sjl/src/gh/tests/../gh.py COMMAND <options>
  
  Available commands:
  
   add       mark untracked files to be committed
   branch    create a branch
   branches  list all branches
   diff      show diffs
   glog      graph changesets
   log       list changesets
   revert    restore files to an earlier state
  
  Use "/Users/sjl/src/gh/tests/../gh.py <command> --help" for individual command help.
  $ $gh --help
  
  Usage: /Users/sjl/src/gh/tests/../gh.py COMMAND <options>
  
  Available commands:
  
   add       mark untracked files to be committed
   branch    create a branch
   branches  list all branches
   diff      show diffs
   glog      graph changesets
   log       list changesets
   revert    restore files to an earlier state
  
  Use "/Users/sjl/src/gh/tests/../gh.py <command> --help" for individual command help.

branches

  $ $gh help branches
  
  Usage: /Users/sjl/src/gh/tests/../gh.py branches
  
  list all branches
  
  $ $gh branches --help
  
  Usage: /Users/sjl/src/gh/tests/../gh.py branches
  
  list all branches
  

log

  $ $gh help log
  
  Usage: /Users/sjl/src/gh/tests/../gh.py log
  
  list changesets
  
  Options:
  
   -l --limit  list at most N changesets
  

diff

  $ $gh help diff
  
  Usage: /Users/sjl/src/gh/tests/../gh.py diff
  
  show diffs
  
  Options:
  
   -c --change  show the diff of the change made by a revision
   -i --index   diff the working dir against the index
   -r --rev     diff the working dir against a revision
   -s --staged  show the diff of the changes in the index
  

add

  $ $gh help add
  
  Usage: /Users/sjl/src/gh/tests/../gh.py add
  
  mark untracked files to be committed
  

glog

  $ $gh help glog
  
  Usage: /Users/sjl/src/gh/tests/../gh.py glog
  
  graph changesets
  
  Options:
  
   -l --limit  list at most N changesets
  

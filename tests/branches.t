setup

  $ gh="$TESTDIR/../gh/gh.py"
  $ GIT_AUTHOR_NAME='test'; export GIT_AUTHOR_NAME
  $ GIT_AUTHOR_EMAIL='test@example.org'; export GIT_AUTHOR_EMAIL
  $ GIT_AUTHOR_DATE="2007-01-01 00:00:00 +0000"; export GIT_AUTHOR_DATE
  $ GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"; export GIT_COMMITTER_NAME
  $ GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"; export GIT_COMMITTER_EMAIL
  $ GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"; export GIT_COMMITTER_DATE

create a git repo

  $ git init -q test
  $ cd test

  $ echo c1 > f1
  $ git add .
  $ git commit -qm '1'

one branch

  $ $gh branches
  * master

multiple branches

  $ git checkout -b b1
  Switched to a new branch 'b1'
  $ $gh branches
  * b1
    master

remote branches

  $ cd ..
  $ git clone -q test test2
  $ cd test2
  $ $gh branches
  * master
    remotes/origin/HEAD -> origin/master
    remotes/origin/b1
    remotes/origin/master

remote branches and multiple local branches

  $ git checkout -b b2
  Switched to a new branch 'b2'
  $ $gh branches
  * b2
    master
    remotes/origin/HEAD -> origin/master
    remotes/origin/b1
    remotes/origin/master

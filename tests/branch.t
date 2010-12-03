setup

  $ gh="$TESTDIR/../gh.py"
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

branch

  $ git branch
  * master
  $ $gh branch b1
  Switched to a new branch 'b1'
  $ git branch
  * b1
    master

errors

  $ $gh branch
  Required argument 'name' not given
  [1]

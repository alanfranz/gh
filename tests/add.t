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

add untracked files

  $ git status -s
  $ echo c2 > f2
  $ git status -s
  ?? f2
  $ $gh add
  $ git status -s
  A  f2
  $ echo c3 > f3
  $ git status -s
  A  f2
  ?? f3
  $ $gh add
  $ git status -s
  A  f2
  A  f3


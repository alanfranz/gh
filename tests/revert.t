setup

  $ gh="$TESTDIR/../gh.py"
  $ GIT_AUTHOR_NAME='test'; export GIT_AUTHOR_NAME
  $ GIT_AUTHOR_EMAIL='test@example.org'; export GIT_AUTHOR_EMAIL
  $ GIT_AUTHOR_DATE="2007-01-01 00:00:00 +0000"; export GIT_AUTHOR_DATE
  $ GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"; export GIT_COMMITTER_NAME
  $ GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"; export GIT_COMMITTER_EMAIL
  $ GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"; export GIT_COMMITTER_DATE

create a git repo with two revisions

  $ git init -q test
  $ cd test
  $ mkdir d

  $ echo c1 > f1
  $ echo c1 > f2
  $ echo c1 > d/f3
  $ git add .
  $ git commit -qm '1'

  $ echo c2 > f1
  $ echo c2 > f2
  $ echo c2 > d/f3
  $ git add .
  $ git commit -qm '2'

revert one file

  $ echo junk > f1
  $ cat f1
  junk
  $ $gh revert f1
  $ cat f1
  c2
  $ cat f1.orig
  junk
  $ rm f1.orig

revert multiple files

  $ echo junk > f1
  $ echo junk > f2
  $ cat f1
  junk
  $ cat f2
  junk
  $ $gh revert f1 f2
  $ cat f1
  c2
  $ cat f1.orig
  junk
  $ rm f1.orig
  $ cat f2
  c2
  $ cat f2.orig
  junk
  $ rm f2.orig

reverting files in a different directory

  $ echo junk > d/f3
  $ cat d/f3
  junk
  $ $gh revert d/f3
  $ cat d/f3
  c2
  $ cat d/f3.orig
  junk
  $ rm d/f3.orig

  $ cd d
  $ echo junk > f3
  $ cat f3
  junk
  $ $gh revert f3
  $ cat f3
  c2
  $ cat f3.orig
  junk
  $ rm f3.orig

  $ cd ..

reverting adds

  $ echo c4 > f4
  $ git status -s
  ?? f4

  $ git add f4
  $ git status -s
  A  f4

  $ $gh revert --all
  $ git status -s
  ?? f4
  $ cat f4
  c4

  $ git add f4
  $ git status -s
  A  f4

  $ echo c5 > f4
  $ git status -s
  AM f4

  $ $gh revert f4
  $ git status -s
  ?? f4
  $ cat f4
  c5

reverting adds and modifications at the same time. sample status:

- MM f1
-  M f2
- AM f4
- A  f5


  $ git add f4
  $ echo crevert > f4

  $ echo crevert > f5
  $ git add f5

  $ echo crevert > f1
  $ git add f1
  $ echo crevert > f1

  $ echo crevert > f2

  $ git status -s
  M  f1
   M f2
  AM f4
  A  f5

  $ $gh revert --all
  $ cat f1
  c2
  $ cat f1.orig
  crevert
  $ cat f2
  c2
  $ cat f2.orig
  crevert
  $ cat f4
  crevert
  $ cat f5
  crevert
  $ ls
  d
  f1
  f1.orig
  f2
  f2.orig
  f4
  f5

errors

  $ $gh revert
  abort: specify files to revert or use --all to revert all files
  [1]
  $ $gh revert --all f1
  abort: cannot use --all when specifying files
  [1]

setup

  $ gh="$TESTDIR/../gh.py"
  $ GIT_AUTHOR_NAME='test'; export GIT_AUTHOR_NAME
  $ GIT_AUTHOR_EMAIL='test@example.org'; export GIT_AUTHOR_EMAIL
  $ GIT_AUTHOR_DATE="2007-01-01 00:00:00 +0000"; export GIT_AUTHOR_DATE
  $ GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"; export GIT_COMMITTER_NAME
  $ GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"; export GIT_COMMITTER_EMAIL
  $ GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"; export GIT_COMMITTER_DATE

create a git repo containing:

- two revisions
- one staged change
- one unstaged change

  $ git init -q test
  $ cd test

  $ echo c1 > f1
  $ git add .
  $ git commit -qm '1'

  $ echo c2 > f2
  $ git add .
  $ git commit -qm '2'

  $ echo c3 > f1
  $ git add f1

  $ echo c4 > f2

diff

  $ $gh diff
  diff --git a/f1 b/f1
  index ae93045..0771aea 100644
  --- a/f1
  +++ b/f1
  @@ -1 +1 @@
  -c1
  +c3
  diff --git a/f2 b/f2
  index 16f9ec0..a103f67 100644
  --- a/f2
  +++ b/f2
  @@ -1 +1 @@
  -c2
  +c4

diff --change

  $ $gh diff --change HEAD
  diff --git a/f2 b/f2
  deleted file mode 100644
  index 16f9ec0..0000000
  --- a/f2
  +++ /dev/null
  @@ -1 +0,0 @@
  -c2

diff --rev

  $ $gh diff --rev HEAD
  diff --git a/f1 b/f1
  index ae93045..0771aea 100644
  --- a/f1
  +++ b/f1
  @@ -1 +1 @@
  -c1
  +c3
  diff --git a/f2 b/f2
  index 16f9ec0..a103f67 100644
  --- a/f2
  +++ b/f2
  @@ -1 +1 @@
  -c2
  +c4
  $ $gh diff --rev HEAD^
  diff --git a/f1 b/f1
  index ae93045..0771aea 100644
  --- a/f1
  +++ b/f1
  @@ -1 +1 @@
  -c1
  +c3
  diff --git a/f2 b/f2
  new file mode 100644
  index 0000000..a103f67
  --- /dev/null
  +++ b/f2
  @@ -0,0 +1 @@
  +c4

diff --index

  $ $gh diff --index
  diff --git a/f2 b/f2
  index 16f9ec0..a103f67 100644
  --- a/f2
  +++ b/f2
  @@ -1 +1 @@
  -c2
  +c4

diff --staged

  $ $gh diff --staged
  diff --git a/f1 b/f1
  index ae93045..0771aea 100644
  --- a/f1
  +++ b/f1
  @@ -1 +1 @@
  -c1
  +c3

errors

  $ $gh diff --rev abc --change abc
  abort: --rev, --change, --index and --staged are mutually exclusive
  [1]
  $ $gh diff --rev abc --index
  abort: --rev, --change, --index and --staged are mutually exclusive
  [1]
  $ $gh diff --rev abc --staged
  abort: --rev, --change, --index and --staged are mutually exclusive
  [1]
  $ $gh diff --change abc --index
  abort: --rev, --change, --index and --staged are mutually exclusive
  [1]
  $ $gh diff --change abc --staged
  abort: --rev, --change, --index and --staged are mutually exclusive
  [1]
  $ $gh diff --index --staged
  abort: --rev, --change, --index and --staged are mutually exclusive
  [1]
  $ $gh diff --rev abc --change abc --index
  abort: --rev, --change, --index and --staged are mutually exclusive
  [1]
  $ $gh diff --rev abc --change abc --staged
  abort: --rev, --change, --index and --staged are mutually exclusive
  [1]
  $ $gh diff --rev abc --change abc --index --staged
  abort: --rev, --change, --index and --staged are mutually exclusive
  [1]

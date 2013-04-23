setup

  $ gh="$TESTDIR/../gh/gh.py"
  $ GIT_AUTHOR_NAME='test'; export GIT_AUTHOR_NAME
  $ GIT_AUTHOR_EMAIL='test@example.org'; export GIT_AUTHOR_EMAIL
  $ GIT_AUTHOR_DATE="2007-01-01 00:00:00 +0000"; export GIT_AUTHOR_DATE
  $ GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"; export GIT_COMMITTER_NAME
  $ GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"; export GIT_COMMITTER_EMAIL
  $ GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"; export GIT_COMMITTER_DATE

create a git repo with two revisions

  $ git init -q test
  $ cd test

  $ echo c1 > f1
  $ git add .
  $ git commit -qm '1'

  $ echo c2 > f2
  $ git add .
  $ git commit -qm '2'

glog

  $ $gh glog
  * commit e5f0882e7f596dbda877a82785e0eac604e1b69d
  | Author: test <test@example.org>
  | Date:   Mon Jan 1 00:00:00 2007 +0000
  | 
  |     2
  |  
  * commit 44706c243491b45638cb31ffad4613df5e8f6308
    Author: test <test@example.org>
    Date:   Mon Jan 1 00:00:00 2007 +0000
    
        1

glog --limit

  $ $gh glog --limit 1
  * commit e5f0882e7f596dbda877a82785e0eac604e1b69d
  | Author: test <test@example.org>
  | Date:   Mon Jan 1 00:00:00 2007 +0000
  | 
  |     2
  $ $gh log --limit 10
  commit e5f0882e7f596dbda877a82785e0eac604e1b69d
  Author: test <test@example.org>
  Date:   Mon Jan 1 00:00:00 2007 +0000
  
      2
  
  commit 44706c243491b45638cb31ffad4613df5e8f6308
  Author: test <test@example.org>
  Date:   Mon Jan 1 00:00:00 2007 +0000
  
      1

glog should show changesets from all branches

  $ git checkout HEAD^ -b b1
  Switched to a new branch 'b1'
  $ echo c3 > f3
  $ git add .
  $ git commit -qm 3
  $ $gh glog
  * commit 1b1979a7aa38d58a1a06d2fc49815a950fde6b7e
  | Author: test <test@example.org>
  | Date:   Mon Jan 1 00:00:00 2007 +0000
  | 
  |     3
  |    
  | * commit e5f0882e7f596dbda877a82785e0eac604e1b69d
  |/  Author: test <test@example.org>
  |   Date:   Mon Jan 1 00:00:00 2007 +0000
  |   
  |       2
  |  
  * commit 44706c243491b45638cb31ffad4613df5e8f6308
    Author: test <test@example.org>
    Date:   Mon Jan 1 00:00:00 2007 +0000
    
        1


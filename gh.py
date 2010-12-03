#!/usr/bin/env python

import os, sys

BASE_DIR = os.path.split(os.path.abspath(__file__))[0]
BAKER_PATH = os.path.join(BASE_DIR, 'bundled', 'baker')
sys.path.insert(0, BAKER_PATH)

import baker
import subprocess

DEBUG = False

def git(*args):
    cmd = map(str, ['git'] + list(args))

    if DEBUG:
        print 'DEBUG:', ' '.join(cmd) + '\n'

    return subprocess.call(cmd, shell=False)

def abort(msg):
    sys.stderr.write('abort: %s\n' % msg)
    sys.exit(1)


@baker.command(
        params={'limit': 'list at most N changesets'},
        shortopts={'limit': 'l'})
def log(limit=0):
    '''list changesets'''
    cmd = ['log', '--all']

    if limit:
        cmd.extend(['-%s' % limit])

    sys.exit(git(*cmd))


@baker.command(
        params={'limit': 'list at most N changesets'},
        shortopts={'limit': 'l'})
def glog(limit=0):
    '''graph changesets'''
    cmd = ['log', '--graph', '--all']

    if limit:
        cmd.extend(['-%s' % limit])

    sys.exit(git(*cmd))


@baker.command(
        params={'rev':    'diff the working dir against a revision',
                'change': 'show the diff of the change made by a revision',
                'index':  'diff the working dir against the index',
                'staged': 'show the diff of the changes in the index', },
        shortopts={'rev':    'r',
                   'change': 'c',
                   'index':  'i',
                   'staged': 's', })
def diff(rev='', change='', index=False, staged=False):
    '''show diffs'''
    cmd = ['diff']

    if len(filter(None, [rev, change, index, staged])) > 1:
        abort('--rev, --change, --index and --staged are mutually exclusive')

    if rev:
        cmd.extend([rev])
    elif change:
        cmd.extend([change, change + '^'])
    elif index:
        pass
    elif staged:
        cmd.extend(['--cached'])
    else:
        cmd.extend(['HEAD'])

    sys.exit(git(*cmd))


@baker.command(
        params={},
        shortopts={})
def branch(name):
    '''create a branch'''
    cmd = ['checkout', '-b', name]

    sys.exit(git(*cmd))

@baker.command(
        params={},
        shortopts={})
def branches():
    '''list all branches'''
    cmd = ['branch', '-a']

    sys.exit(git(*cmd))


@baker.command(
        params={},
        shortopts={})
def add():
    '''mark untracked files to be committed'''
    cmd = ['add', '-A']

    sys.exit(git(*cmd))



if __name__ == '__main__':
    baker.run()

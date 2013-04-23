#!/usr/bin/env python

import os, shutil, sys

import baker
import subprocess

DEBUG = False

def git(*args):
    cmd = map(str, ['git'] + list(args))

    if DEBUG:
        print 'DEBUG:', ' '.join(cmd) + '\n'

    return subprocess.call(cmd, shell=False)

def _git_status():
    lines = subprocess.check_output(['git', 'status', '-s']).splitlines()

    status = []
    for line in lines:
        if line[0] == ' ':
            line = '_' + line[1:]
        if line[1] == ' ':
            line = line[0] + '_' + line[2:]
        s, _, path = line.strip().partition(' ')
        status.append([s, path.strip()])

    return status

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


@baker.command(
        params={'all': 'restore all files if no files are given'},
        shortopts={})
def revert(*args, **kwargs):
    '''restore files to an earlier state

    Specifying directories is NOT supported yet!
    '''
    _all = kwargs.get('all')


    if not _all and not args:
        abort('specify files to revert or use --all to revert all files')

    if (_all and args) or (_all and _all != True):
        abort('cannot use --all when specifying files')

    status = _git_status()

    def _status_changed(s):
        return any(c in s for c in 'MA')

    if _all:
        args = [(s, path) for s, path in status if _status_changed(s)]
    else:
        absargs = [os.path.abspath(arg) for arg in args]

        args = [(s, path) for s, path in status
                if _status_changed(s) and os.path.abspath(path) in absargs]

    adds = [(s[0], s[1], path) for s, path in args if 'A' in s]
    mods = [(s[0], s[1], path) for s, path in args
            if 'M' in s
            and not path in [add[2] for add in adds]]

    if adds:
        cmd = ['reset', '-q', 'HEAD', '--'] + [path for index, wdir, path in adds]
        git(*cmd)

    if mods:
        for _, _, path in mods:
            shutil.copyfile(path, path + '.orig')

        # If there are staged changes that we revert they'll turn into wdir
        # changes, which we then need to revert as well.
        indexmods = [path for index, wdir, path in mods if index == 'M']
        wdirmods = [path for index, wdir, path in mods]

        if indexmods:
            cmd = ['reset', '-q', 'HEAD', '--'] + indexmods
            git(*cmd)

        if wdirmods:
            cmd = ['checkout', '-q', '--'] + wdirmods
            git(*cmd)

    sys.exit(0)


def main():
    baker.run()

if __name__ == '__main__':
    main()

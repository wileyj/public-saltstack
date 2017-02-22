#!/usr/bin/env python
from __future__ import print_function, unicode_literals

import os
import fnmatch


# noinspection PyShadowingBuiltins
def file(name, indent=0):
    ind = ' ' * indent
    with open(name, 'rt') as fin:
        for ln in fin:
            yield '{0}{1}'.format(ind, ln.rstrip('\r\n'))
    return


def directory(name, recurse=False, indent=0, file_filter='*', dir_filter='*'):
    for root, dirs, files in os.walk(name):
        root_base = os.path.basename(root)
        if fnmatch.fnmatch(root_base, dir_filter):
            for fn in files:
                if fnmatch.fnmatch(fn, file_filter):
                    for ln in file(os.path.join(root, fn), indent=indent):
                        yield ln
        if not recurse:
            break
    return

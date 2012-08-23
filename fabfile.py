from fabric.api import *
from fabric.contrib.project import rsync_project

env.hosts = ['root@node.philipcristiano.com']

def upload():
    rsync_project('/var/www', 'philipcristiano')

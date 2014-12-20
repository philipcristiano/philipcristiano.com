from fabric.api import *
from fabric.contrib.project import rsync_project

env.hosts = ['root@philipcristiano.com']

def upload():
    rsync_project('/var/www/philipcristiano', 'output/*')

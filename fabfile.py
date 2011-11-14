from fabric.api import *

env.hosts = ['root@node.philipcristiano.com']

def upload():
    put("philipcristiano", "/var/www")
    sudo("chown www-data /var/www/philipcristiano")

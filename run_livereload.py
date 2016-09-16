#!/usr/bin/env python
from livereload import Server, shell
server = Server()
for path in ['posts/', 'src/']:
    server.watch(path, shell('make build'))
server.serve(root='output')

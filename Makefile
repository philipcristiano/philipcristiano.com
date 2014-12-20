upload: build
	fab upload

build:
	nikola build

server:
	nikola serve

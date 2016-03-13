upload: build
	S3CMD_CONFIG=.s3cfg s3cmd sync output/* s3://site-philipcristiano

build:
	nikola build

server:
	nikola serve

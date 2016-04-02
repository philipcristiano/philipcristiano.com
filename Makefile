upload: build
	S3CMD_CONFIG=.s3cfg s3cmd sync output/* s3://philipcristiano.com
	cloudflare cache purge philipcristiano.com

build:
	nikola build

server:
	nikola serve

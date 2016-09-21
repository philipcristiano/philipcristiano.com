upload: clean build
	S3CMD_CONFIG=.s3cfg s3cmd sync output/* s3://philipcristiano.com
	cloudflare cache purge philipcristiano.com

clean:
	rm -rf output

build:
	nikola build
	cp -r src/images output

server: build
	./run_livereload.py

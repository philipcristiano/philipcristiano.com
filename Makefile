upload: clean build
	aws s3 sync output/ s3://philipcristiano.com
	cloudflare cache purge philipcristiano.com

clean:
	rm -rf output

build:
	nikola build
	cp -r src/images output

server: build
	./run_livereload.py

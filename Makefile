upload: clean build
	aws s3 sync output/ s3://philipcristiano.com

clean:
	rm -rf output

build: deps
	nikola build
	cp -r src/images output

deps:
	pip install -r requirements.txt

server: build
	./run_livereload.py

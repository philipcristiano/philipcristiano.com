upload: build
	fab upload

build:
	cd src; jekyll --no-auto --no-server
	-rm -rf philipcristiano
	cp -r src/_site philipcristiano

requirements:
	gem install jekyll
	gem uninstall liquid
	gem install liquid -v 2.2.2
	pip install pygments

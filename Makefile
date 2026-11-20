.PHONEY: build
build: build_zola

build_preview: build_zola_preview

build_zola:
	zola build
	mkdir -p public/.well-known/
	cp public/opml/index.html public/.well-known/following.opml

build_zola_preview:
	zola build --base-url "/"

serve:
	zola serve

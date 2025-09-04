.PHONEY: build
build: build_zola

build_preview: build_zola_preview

build_zola:
	zola build

build_zola_preview:
	zola build --base-url "/"

serve:
	zola serve

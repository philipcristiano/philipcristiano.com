

.PHONEY: build
build: build_tailwind build_zola

.PHONEY: build_tailwind
build_tailwind:
	tailwindcss -i ./tailwind/input.css -o ./static/site.css

build_zola: build_tailwind
	zola build

serve:
	zola serve

watch_tailwind:
	tailwindcss -i ./tailwind/input.css -o ./static/site.css --watch

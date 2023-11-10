

.PHONEY: build
build: build_tailwind build_zola

build_preview: build_tailwind build_zola_preview

.PHONEY: build_tailwind
build_tailwind:
	tailwindcss -i ./tailwind/input.css -o ./static/site.css

build_zola: build_tailwind
	zola build

build_zola_preview: build_tailwind
	zola build --base-url $DEPLOY_PRIME_URL

serve:
	zola serve

watch_tailwind:
	tailwindcss -i ./tailwind/input.css -o ./static/site.css --watch

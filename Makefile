# Makefile helpers for common flows
.PHONY: run-dev run-prod build-apk-dev build-apk-prod

run-dev:
	./scripts/run_dev.sh

run-prod:
	./scripts/run_prod.sh

build-apk-dev:
	./scripts/build_apk_dev.sh

build-apk-prod:
	./scripts/build_apk_prod.sh

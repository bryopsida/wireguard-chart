CHART_PATH = helm/wireguard
OVERRIDE_PATH ?= ci/default.yaml

lint:
	helm lint $(CHART_PATH) -f $(OVERRIDE_PATH)

template:
	helm template --debug  --disable-openapi-validation $(CHART_PATH) -f $(OVERRIDE_PATH)

docs-update:
	docker run --rm --volume "$$PWD:/helm-docs" jnorwood/helm-docs:latest

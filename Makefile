CHART_PATH = helm/wireguard
OVERRIDE_PATH ?= ci/default.yaml
TEMPLATE_ARGS ?= '--disable-openapi-validation'
HELM_NAMESPACE ?= wireguard-test
HELM_RELEASE_NAME ?= wireguard-test

lint:
	helm lint $(CHART_PATH) -f $(OVERRIDE_PATH)

template:
	helm template --debug  $(TEMPLATE_ARGS) $(CHART_PATH) -f $(OVERRIDE_PATH)
	
deploy:
	helm --namespace $(HELM_NAMESPACE) upgrade --install $(HELM_RELEASE_NAME) ./helm/wireguard/ -f $(OVERRIDE_PATH) $(HELM_EXTRA_ARGS)

clean-secret:
	kubectl --namespace $(HELM_NAMESPACE) delete secret $(HELM_RELEASE_NAME)-wg-generated

clean:
	helm --namespace $(HELM_NAMESPACE) del $(HELM_RELEASE_NAME)

docs-update:
	docker run --rm --volume "$$PWD:/helm-docs" jnorwood/helm-docs:latest

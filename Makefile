CHART_PATH = helm/wireguard
OVERRIDE_PATH ?= ci/default.yaml
TEMPLATE_ARGS ?= '--disable-openapi-validation'
HELM_NAMESPACE ?= wireguard-test
HELM_RELEASE_NAME ?= wireguard-test
HELM_IMAGE_TAG ?= local
HELM_IMAGE_PULL_POLICY ?= IfNotPresent
HELM_IMAGE_REPO ?= ghcr.io/bryopsida/wireguard

lint:
	helm lint $(CHART_PATH) -f $(OVERRIDE_PATH)

template:
	helm template --debug  $(TEMPLATE_ARGS) $(CHART_PATH) -f $(OVERRIDE_PATH)
	
deploy:
	helm --namespace $(HELM_NAMESPACE) upgrade --install $(HELM_RELEASE_NAME) ./helm/wireguard/ --set image.repository=$(HELM_IMAGE_REPO) --set image.tag=$(HELM_IMAGE_TAG) --set image.pullPolicy=$(HELM_IMAGE_PULL_POLICY) -f $(OVERRIDE_PATH) $(HELM_EXTRA_ARGS)

clean-secret:
	kubectl --namespace $(HELM_NAMESPACE) delete secret $(HELM_RELEASE_NAME)-wg-generated

clean:
	helm --namespace $(HELM_NAMESPACE) del $(HELM_RELEASE_NAME)

docs-update:
	docker run --rm --volume "$$PWD:/helm-docs" --network host jnorwood/helm-docs:latest

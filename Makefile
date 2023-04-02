CHART_PATH = helm/wireguard

lint:
	helm lint $(CHART_PATH)

template:
	helm template --debug  --disable-openapi-validation $(CHART_PATH)

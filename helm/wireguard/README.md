# wireguard

![Version: 0.23.0](https://img.shields.io/badge/Version-0.23.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.0](https://img.shields.io/badge/AppVersion-0.0.0-informational?style=flat-square)

A Helm chart for managing a wireguard vpn in kubernetes

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| bryopsida |  |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{"podAntiAffinity":{"requiredDuringSchedulingIgnoredDuringExecution":[{"labelSelector":{"matchLabels":{"app":"{{ .Release.Name }}-wireguard","role":"vpn"}},"topologyKey":"kubernetes.io/hostname"}]}}` | Set pod affinity or antiAffinity |
| autoscaling.enabled | bool | `true` |  |
| autoscaling.maxReplicas | int | `10` |  |
| autoscaling.minReplicas | int | `3` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `75` |  |
| configSecretName | string | `nil` | If provided, this secret will be used instead of the config created from the helm value scope |
| configSecretProperty | string | `"wg0.conf"` | The property/key on the secret holding the wireguard configuration file |
| daemonSet | bool | `false` | Run as a DaemonSet instead of Deployment |
| deploymentStrategy.rollingUpdate.maxSurge | int | `1` |  |
| deploymentStrategy.rollingUpdate.maxUnavailable | int | `0` |  |
| deploymentStrategy.type | string | `"RollingUpdate"` |  |
| disableConfigManagement | bool | `false` | Disable creation and any mount of the wireguard confifugration file, this assumes another mechanism is provided/used to manage a configuration file |
| disablePrivateKeyManagement | bool | `false` | Disable creation and any mounting of a private key, this assumes another mechanism is provided/used at the container level to fetch the private key |
| disruptionBudget.enabled | bool | `true` |  |
| disruptionBudget.minAvailable | int | `2` |  |
| extraEnv | object | `{}` | Provide additional environment variables to the wireguard container |
| healthSideCar.enabled | bool | `false` | Opt in side car to expose a http health end point for external load balancers that are not kubernetes aware, in most cases this is not needed |
| healthSideCar.hostPort | int | `13000` | When useHostPort is true this is the host port defined |
| healthSideCar.image.pullPolicy | string | `"Always"` | Pull Policy always to avoid cached rolling tags, if you change this you should use a non rolling tag |
| healthSideCar.image.repository | string | `"ghcr.io/bryopsida/http-healthcheck-sidecar"` | Override repo if you prefer to use your own image |
| healthSideCar.image.tag | string | `"main"` | Rolling tag used by default to take patches automatically |
| healthSideCar.resources | object | `{"limits":{"cpu":"100m","memory":"256Mi"},"requests":{"cpu":"100m","memory":"256Mi"}}` | set resource constraints, set to nil to remove |
| healthSideCar.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsGroup":10001,"runAsNonRoot":true,"runAsUser":10001,"seccompProfile":{"type":"RuntimeDefault"}}` | Secure settings by default, can be overriden to reduce security posture if needed |
| healthSideCar.service.enabled | bool | `true` | Toggle to enable the service, if the pod is a daemonset healthSideCar.useHostPort can be used instead |
| healthSideCar.service.nodePort | int | `31313` | The port for the service exposed on each node |
| healthSideCar.service.port | int | `3000` | Override service port if needed |
| healthSideCar.service.type | string | `"NodePort"` | Service type, given the use case, in most cases this should be NodePort |
| healthSideCar.useHostPort | bool | `false` | When enabled the container will define a host port, in most cases this should only be used when deploying with daemonSet: true |
| hostPort | int | `51820` | Host port to expose the VPN service on |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"ghcr.io/bryopsida/wireguard"` |  |
| image.tag | string | `"main"` |  |
| keygenJob.command | list | `["/job/entry-point.sh"]` | Specify the script to run to generate the private key |
| keygenJob.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| keygenJob.containerSecurityContext.privileged | bool | `false` |  |
| keygenJob.containerSecurityContext.readOnlyRootFilesystem | bool | `true` |  |
| keygenJob.containerSecurityContext.runAsGroup | int | `1000` |  |
| keygenJob.containerSecurityContext.runAsNonRoot | bool | `true` |  |
| keygenJob.containerSecurityContext.runAsUser | int | `1000` |  |
| keygenJob.extraEnv | object | `{}` | Add additional environment variables to the key generation job, supports helm templating |
| keygenJob.extraScripts | object | `{}` | Inject additional scripts into the key generation job |
| keygenJob.image.pullPolicy | string | `"Always"` |  |
| keygenJob.image.repository | string | `"ghcr.io/curium-rocks/wg-kubectl"` |  |
| keygenJob.image.tag | string | `"latest"` |  |
| keygenJob.podSecurityContext.fsGroup | int | `1000` |  |
| keygenJob.podSecurityContext.fsGroupChangePolicy | string | `"Always"` |  |
| keygenJob.podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| keygenJob.useWireguardManager | bool | `false` | when enabled, uses a image with go bindings for k8s and wg    to create the secret if it does not exist, on re-runs it    it leaves the existing secret in place and exits succesfully |
| keygenJob.wireguardMgrImage | object | `{"pullPolicy":"Always","repository":"ghcr.io/bryopsida/k8s-wireguard-mgr","tag":"latest"}` | When useWireguardManager is enabled this image is used instead of the kubectl image |
| labels | object | `{}` |  |
| metrics.dashboard.annotations | object | `{}` | Grafana dashboard annotations |
| metrics.dashboard.enabled | bool | `true` | Create a ConfigMap with a Grafana dashboard |
| metrics.dashboard.labels | object | `{"grafana_dashboard":"1"}` | Grafana dashboard labels |
| metrics.enabled | bool | `false` | Enable exposing Wireguard metrics |
| metrics.extraEnv.EXPORT_LATEST_HANDSHAKE_DELAY | string | `"true"` | Adds the wireguard_latest_handshake_delay_seconds metric that automatically calculates the seconds passed since the last handshake |
| metrics.extraEnv.PROMETHEUS_WIREGUARD_EXPORTER_ADDRESS | string | `"0.0.0.0"` | Specify the service address. This is the address your Prometheus instance should point to |
| metrics.extraEnv.PROMETHEUS_WIREGUARD_EXPORTER_CONFIG_FILE_NAMES | string | `"/etc/wireguard/{{ .Values.configSecretProperty }}"` | This flag adds the friendly_name attribute or the friendly_json attributes to the exported entries. See [Friendly tags](https://mindflavor.github.io/prometheus_wireguard_exporter/#friendly-tags) for more details. Multiple files are allowed (they will be merged as a single file in memory so avoid duplicates) |
| metrics.extraEnv.PROMETHEUS_WIREGUARD_EXPORTER_EXPORT_REMOTE_IP_AND_PORT_ENABLED | string | `"true"` | Exports peer’s remote ip and port as labels (if available) |
| metrics.extraEnv.PROMETHEUS_WIREGUARD_EXPORTER_INTERFACES | string | `"all"` | Specifies the interface(s) passed to the wg show <interface> dump parameter. Multiple parameters are allowed |
| metrics.extraEnv.PROMETHEUS_WIREGUARD_EXPORTER_PREPEND_SUDO_ENABLED | string | `"false"` | Prepends sudo to wg commands |
| metrics.extraEnv.PROMETHEUS_WIREGUARD_EXPORTER_SEPARATE_ALLOWED_IPS_ENABLED | string | `"true"` | Enable the allowed ip + subnet split mode for the labels |
| metrics.extraEnv.PROMETHEUS_WIREGUARD_EXPORTER_VERBOSE_ENABLED | string | `"false"` | Enable verbose mode |
| metrics.image | object | `{"pullPolicy":"IfNotPresent","repository":"docker.io/mindflavor/prometheus-wireguard-exporter","tag":"3.6.6"}` | Wireguard Exporter image |
| metrics.prometheusRule.annotations | object | `{}` | Annotations |
| metrics.prometheusRule.enabled | bool | `false` | Create PrometheusRule Resource for scraping metrics using PrometheusOperator |
| metrics.prometheusRule.groups | list | `[]` | Groups, containing the alert rules. Example:   groups:     - name: Wireguard       rules:         - alert: WireguardInstanceNotAvailable           annotations:             message: "Wireguard instance in namespace {{ `{{` }} $labels.namespace {{ `}}` }} has not been available for the last 5 minutes."           expr: |             absent(kube_pod_status_ready{namespace="{{ include "common.names.namespace" . }}", condition="true"} * on (pod) kube_pod_labels{pod=~"{{ include "common.names.fullname" . }}-\\d+", namespace="{{ include "common.names.namespace" . }}"}) != 0           for: 5m           labels:             severity: critical |
| metrics.prometheusRule.labels | object | `{}` | Additional labels that can be used so PrometheusRule will be discovered by Prometheus |
| metrics.prometheusRule.namespace | string | `""` | Namespace of the ServiceMonitor. If empty, current namespace is used |
| metrics.service.annotations | object | `{}` | Annotations for enabling prometheus to access the metrics endpoints |
| metrics.service.labels | object | `{}` | Additional service labels |
| metrics.service.port | int | `9586` | Metrics service HTTP port |
| metrics.serviceMonitor.annotations | object | `{}` | Annotations |
| metrics.serviceMonitor.enabled | bool | `true` | Create ServiceMonitor Resource for scraping metrics using PrometheusOperator |
| metrics.serviceMonitor.honorLabels | bool | `false` | honorLabels chooses the metric's labels on collisions with target labels |
| metrics.serviceMonitor.interval | string | `"30s"` | Interval at which metrics should be scraped |
| metrics.serviceMonitor.jobLabel | string | `""` | The name of the label on the target service to use as the job name in prometheus. |
| metrics.serviceMonitor.labels | object | `{}` | Additional labels that can be used so ServiceMonitor will be discovered by Prometheus |
| metrics.serviceMonitor.metricRelabelings | list | `[]` | MetricRelabelConfigs to apply to samples before ingestion |
| metrics.serviceMonitor.namespace | string | `""` | Namespace of the ServiceMonitor. If empty, current namespace is used |
| metrics.serviceMonitor.path | string | `"/metrics"` | The endpoint configuration of the ServiceMonitor. Path is mandatory. Interval, timeout and relabelings can be overwritten. |
| metrics.serviceMonitor.port | string | `"exporter"` | Metrics service HTTP port |
| metrics.serviceMonitor.relabelings | list | `[]` | RelabelConfigs to apply to samples before scraping |
| metrics.serviceMonitor.scrapeTimeout | string | `""` | Specify the timeout after which the scrape is ended e.g:   scrapeTimeout: 30s |
| metrics.serviceMonitor.selector | object | `{}` | Prometheus instance selector labels ref: https://github.com/bitnami/charts/tree/main/bitnami/prometheus-operator#prometheus-configuration |
| nodeSelector | object | `{}` | Set pod nodeSelector, a simplified version of affinity |
| podAnnotations | object | `{}` |  |
| replicaCount | int | `3` |  |
| resources.limits.cpu | string | `"100m"` |  |
| resources.limits.memory | string | `"256Mi"` |  |
| resources.requests.cpu | string | `"100m"` |  |
| resources.requests.memory | string | `"256Mi"` |  |
| runtimeClassName | string | `nil` | Override the default runtime class of the container, if not provided `runc` will most likely be used |
| secretName | string | `nil` | Name of a secret with a wireguard private key on key privatekey, if not provided on first install a hook generates one. |
| securityContext.allowPrivilegeEscalation | bool | `true` |  |
| securityContext.privileged | bool | `false` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `1000` |  |
| service.annotations | object | `{}` | Annotations |
| service.enabled | bool | `true` | Whether the service will be created or not |
| service.externalTrafficPolicy | string | `""` | External Traffic Policy for the service |
| service.loadBalancerIP | string | `""` | IP to assign to the LoadBalancer service |
| service.nodePort | int | `31820` | Node port, only valid with service type: NodePort |
| service.port | int | `51820` | Service port, default is 51820 UDP |
| service.type | string | `"LoadBalancer"` | Service type, to keep internal to cluster use ClusterIP or NodePort |
| tolerations | list | `[]` | Set pod tolerations |
| useHostPort | bool | `false` | Expose VPN service on hostPort |
| volumeMounts | object | `{}` | Passthrough pod volume mounts |
| volumes | object | `{}` | Passthrough pod volumes |
| wireguard.clients | list | `[]` | A collection of clients that will be added to wg0.conf, accepts objects with keys PublicKey and AllowedIPs (mandatory) and optional FriendlyName or FriendlyJson (https://github.com/MindFlavor/prometheus_wireguard_exporter#friendly-tags) and PersistentKeepalive (https://www.wireguard.com/quickstart/#nat-and-firewall-traversal-persistence), stored in secret |
| wireguard.natAddSourceNet | bool | `true` | Add the serverCidr to the nat source net option |
| wireguard.serverAddress | string | `"10.34.0.1/24"` | Address of the VPN server |
| wireguard.serverCidr | string | `"10.34.0.0/24"` | Subnet for your VPN, take care not to clash with cluster POD cidr |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.13.1](https://github.com/norwoodj/helm-docs/releases/v1.13.1)

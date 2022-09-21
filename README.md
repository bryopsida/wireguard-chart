# Wireguard Chart
A simple chart that can be used to run wireguard inside of a Kubernetes cluster.

## Add the helm repo
To add this helm repo, run `helm repo add wireguard https://bryopsida.github.io/wireguard-chart` followed by a `helm repo update` to fetch the contents.

## Deploy
To deploy with defaults and use the automatically generated private key you can use `helm upgrade --install wg-vpn-1 wireguard/wireguard --namespace <your namespace>`.
This will create a load balancer service exposing UDP port `51820`, to run multiple wireguard releases you will need to change the service port to avoid collisions, 
you can find the helm values documentation [here](helm/wireguard/README.md). By default no client configurations are added. The default CIDR for the VPN network is `10.34.0.1/24`

## Maintain client configurations
Follow the wireguard [documentation](https://www.wireguard.com/quickstart/) for generating keys and determining client IPs. Clients can be set by providing the following yaml override values.

``` yaml
wireguard:
  clients:
    PublicKey: <your client public key here>
    AllowedIPs: 10.34.0.2/32
```

And feeding it into helm `helm upgrade --install wg-vpn-1 wireguard/wireguard --namespace <your namespace> -f <path-to-your-overides>`

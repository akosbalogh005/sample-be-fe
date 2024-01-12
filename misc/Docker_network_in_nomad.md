# Docker network in NOMAD

## COMMON

https://developer.hashicorp.com/nomad/docs/networking
https://developer.hashicorp.com/nomad/docs/integrations/consul-connect


## HOST ONLY Network
https://mrkaran.dev/posts/nomad-networking-explained/

- port allocation for the host

Working 


## BRIDGE  Network

### nomad 
- gcr.io/google_containers/pause-amd64:3.0 -> create local registry (https://docs.docker.com/registry/deploying/)
- nomad.hcl
plugin "docker" {
  config {
    infra_image = "localhost:5000/pause-amd64:3.0"
  }
}

- consul.hcl  (enable grcp for sidecar)
connect {
  enabled = true
}
ports {
    grpc = 8502
    grpc_tls = 8503
}

Not Working !!!!!!!

failed to setup alloc: pre-run hook "network" failed: failed to configure networking for alloc: 
failed to initialize table forwarding rules: failed to list iptables chains: running [/usr/sbin/iptables -t filter -S --wait]: 
exit status 1: iptables v1.8.2 (nf_tables): table `filter' is incompatible, use 'nft' tool.


https://www.redhat.com/en/blog/using-iptables-nft-hybrid-linux-firewall


### MANUAL bridge net

docker network create -d bridge --subnet=10.11.0.0/24  --attachable my-bridge-net

docker network create -d bridge --attachable my-bridge-net

docker network create -d bridge --subnet=0.0.0.0/24 --gateway=0.0.0.0  --attachable my-0-bridge-net


docker network create -d bridge --subnet=172.21.0.0/16 --gateway=172.21.0.1 -o "com.docker.network.bridge.host_binding_ipv4"="10.11.0.4"  --attachable my-bridge-net

docker network create -d bridge --subnet=10.11.0.0/24 --gateway=10.11.0.254 -o "com.docker.network.bridge.host_binding_ipv4"="10.11.0.4"  --attachable my-bridge-net


ip r add 10.11.0.240 dev <docker-bridge>

wg set wg0 peer "04TNrFL+sf9xwoVlr4P0dhEZmCmM81d0C2C/Dkc3bHY=" allowed-ips "10.11.0.39/32, 10.11.0.187/32, 10.11.0.186/32, 10.11.0.83/32, 10.11.0.123/32, 10.11.0.127/32, 10.11.0.88/32, 10.11.0.142/32, 10.11.0.99/32, 10.11.0.240/32, 10.11.0.241/32, 10.11.0.0/24, 10.11.0.19/32, 10.11.0.28/32, 10.11.0.29/32, 10.11.0.30/32, 10.11.0.164/32, 10.11.0.9/32, 10.11.0.74/32, 10.11.0.79/32, 10.11.0.82/32, 10.11.0.7/32, 10.11.0.175/32, 10.11.0.14/32, 10.11.0.166/32, 10.11.0.190/32, 10.11.0.8/32, 10.11.0.37/32, 10.11.0.27/32, 10.11.0.73/32, 10.11.0.11/32, 10.11.0.240/32, 10.11.0.241/32"

--nft add rule ip nat prerouting ip daddr 10.11.0.240 tcp dport 9090 dnat 172.17.0.10:9090
--nft add rule ip nat prerouting ip daddr 10.11.0.241 tcp dport 8080 dnat 172.17.0.11:8080

nft add rule ip nat prerouting ip daddr 10.11.0.241  dnat 172.17.0.11
nft add rule ip nat prerouting ip daddr 10.11.0.240  dnat 172.17.0.10

nft delete rule nat prerouting handle 21

--ip r add 10.11.0.240 dev docker1
--ip r add 10.11.0.241 dev docker1

--nft add rule ip filter input iifname docker1 counter accept


!!!!!!!!!!!!
nft add rule ip filter forward oifname "docker1" counter  accept


## macvlan

```
ip link add name asdf type veth
docker network create -d macvlan --subnet=10.11.0.0/24 --gateway=10.11.0.4  -o parent=asdf wg0_net
ip link set up veth0
ip link set up asdf

```

## ipvlan

docker network create -d ipvlan --subnet=10.11.0.0/24 -o parent=wg0 -o ipvlan_mode=l3 wg0_net

docker network create -d ipvlan --subnet=10.11.0.0/24 -o parent=wg0 -o ipvlan_mode=l3 ipvlan1


docker run -it --rm --network ipvlan1 --ip  10.11.0.240  --name be_test backend-test:1




ip link add ipvlanif link eno1 type ipvlan mode l3

ip addr add 172.22.0.255/32 dev ipvlanif
ip link set ipvlanif up
ip route add 172.22.0.0/24 dev ipvlanif



docker network create -d ipvlan --subnet=172.22.0.0/24 -o parent=ipvlanif -o ipvlan_mode=l3 ipvlan1

docker run -it --rm --network ipvlan1 --ip  172.22.0.240  --name be_test backend-test:1

nft add rule ip nat prerouting ip daddr 10.11.0.240  dnat 172.22.0.240



egy hasznos parancs debuggoláshoz: 

nsenter -n -t 10532 ip link 

ahol a -t a konténerben futó process pidje.



## OVERLAY Network

### weave
curl -L git.io/weave -o weave

https://www.weave.works/docs/net/latest/overview/
https://github.com/hashicorp/nomad/blob/6b3ae9acd87a5016d480f516e946f78a7f79807c/scripts/example_weave.bash
https://speakerdeck.com/carlpett/deploying-on-an-overlay-network-with-nomad-and-weave?slide=11

Problem: weave launch need docker registry


### docker overlay

https://docs.docker.com/network/drivers/overlay/

1) swarm

docker swarm init --advertise-addr 10.11.0.4
docker swarm join --token SWMTKN-1-4i4s6k9megcepcr5fufspnbbidmxcibzx0azpvhc2d1dyomajo-75jadxoixd5sgkkculbslaxkp 10.11.0.4:2377

docker swarm join-token manager

docker node ls


2) overlay net

docker network create -d overlay --subnet=168.11.0.0/16  --attachable my-overlay-net



iwtwjxr44rq18t49eniw1ttd7





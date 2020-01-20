#!/bin/bash

ip netns add source_1
ip netns add source_2
ip netns add dest_1
ip netns add dest_2
ip netns add router_1
ip netns add router_2
ip link add source_eth_1 type veth peer name router_eth_1_1
ip link add source_eth_2 type veth peer name router_eth_1_2
ip link set source_eth_1 netns source_1
ip link set source_eth_2 netns source_2
ip link set router_eth_1_1 netns router_1
ip link set router_eth_1_2 netns router_1
ip link add router_eth_1_3 type veth peer name router_eth_2_1
ip link set router_eth_1_3 netns router_1
ip link set router_eth_2_1 netns router_2
ip link add router_eth_2_2 type veth peer name dest_eth_1
ip link add router_eth_2_3 type veth peer name dest_eth_2
ip link set router_eth_2_2 netns router_2
ip link set router_eth_2_3 netns router_2
ip link set dest_eth_1 netns dest_1
ip link set dest_eth_2 netns dest_2
ip netns exec source_1 ip link set lo up
ip netns exec source_1 ip link set source_eth_1 up
ip netns exec source_2 ip link set lo up
ip netns exec source_2 ip link set source_eth_2 up
ip netns exec router_1 ip link set lo up
ip netns exec router_1 ip link set router_eth_1_1 up
ip netns exec router_1 ip link set router_eth_1_2 up
ip netns exec router_1 ip link set router_eth_1_3 up
ip netns exec router_2 ip link set lo up
ip netns exec router_2 ip link set router_eth_2_1 up
ip netns exec router_2 ip link set router_eth_2_2 up
ip netns exec router_2 ip link set router_eth_2_3 up
ip netns exec dest_1 ip link set lo up
ip netns exec dest_1 ip link set dest_eth_1 up
ip netns exec dest_2 ip link set lo up
ip netns exec dest_2 ip link set dest_eth_2
ip netns exec source_1 ip address add 10.0.0.1/24 dev source_eth_1
ip netns exec source_2 ip address add 10.0.0.2/24 dev source_eth_2
ip netns exec router_1 ip address add 10.0.0.3/24 dev router_eth_1_1
ip netns exec router_1 ip address add 10.0.0.4/24 dev router_eth_1_2
ip netns exec router_1 ip address add 10.0.0.5/24 dev router_eth_1_3
ip netns exec router_2 ip address add 10.0.0.6/24 dev router_eth_2_1
ip netns exec router_2 ip address add 10.0.0.7/24 dev router_eth_2_2
ip netns exec router_2 ip address add 10.0.0.8/24 dev router_eth_2_3
ip netns exec dest_1 ip address add 10.0.0.9/24 dev dest_eth_1
ip netns exec dest_2 ip address add 10.0.0.10/24 dev dest_eth_2
ip netns exec source_1 tc qdisc add dev source_eth_1 root tbf rate 1024kbit latency 2ms burst 1540
ip netns exec source_2 tc qdisc add dev source_eth_2 root tbf rate 1024kbit latency 2ms burst 1540
ip netns exec router_1 tc qdisc add dev router_eth_1_3 root tbf rate 100mbit latency 50ms burst 1540
ip netns exec router_2 tc qdisc add dev router_eth_2_2 root tbf rate 1024kbit latency 2ms burst 1540
ip netns exec router_2 tc qdisc add dev router_eth_2_3 root tbf rate 1024kbit latency 2ms burst 1540












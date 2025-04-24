一些脚本
```shell
vyos@wireguard1:/$ generate pki wireguard key-pair
Private key: 8P5/eTQJeBEuogGbTASDo7xH6/1F/LZOBe490VpjE18=
Public key: JFyVij2YkVp70DkjndVz5EGXE+Z9zs+Y6zkcAetkgFM=

root@wireguard2:/# generate pki wireguard key-pair
Private key: oIX4TR+0EHj9xaFAlKjSXomOJtSQYurKfG7KKo/rH3A=
Public key: GqOXVyKMCsFj03pewvtadTX8DjAmgjwBEqONDZzzaHM=



# vyos-wireguard1
set interfaces wireguard wg1 private-key '8P5/eTQJeBEuogGbTASDo7xH6/1F/LZOBe490VpjE18='
set interfaces wireguard wg1 address '10.1.0.1/30'
set interfaces wireguard wg1 peer to-wg02 allowed-ips '10.244.2.0/24'
set interfaces wireguard wg1 peer to-wg02 address '10.1.8.10'
set interfaces wireguard wg1 peer to-wg02 port '51820'
set interfaces wireguard wg1 peer to-wg02 public-key 'GqOXVyKMCsFj03pewvtadTX8DjAmgjwBEqONDZzzaHM='
set interfaces wireguard wg1 port '51820'
set protocols static route 10.244.2.0/24 interface wg1

# vyos-wireguard2
set interfaces wireguard wg1 private-key 'oIX4TR+0EHj9xaFAlKjSXomOJtSQYurKfG7KKo/rH3A='
set interfaces wireguard wg1 address '10.1.0.2/30'
set interfaces wireguard wg1 peer to-wg02 allowed-ips '10.244.1.0/24'
set interfaces wireguard wg1 peer to-wg02 address '10.1.5.10'
set interfaces wireguard wg1 peer to-wg02 port '51820'
set interfaces wireguard wg1 peer to-wg02 public-key 'JFyVij2YkVp70DkjndVz5EGXE+Z9zs+Y6zkcAetkgFM='
set interfaces wireguard wg1 port '51820'
set protocols static route 10.244.1.0/24 interface wg1
```
参考链接1
https://dev.to/leroykayanda/setting-an-ipsec-vpn-using-vyos-in-aws-48fl


通过内核的 ip xfrm 工具导出密钥
```shell
sudo ip xfrm state
```
结构如下, 可以看到AES_CBC、HMAC_256_128
```
root@vyos-ipsec1:/# sudo ip xfrm state
src 10.1.5.10 dst 10.1.8.10
	proto esp spi 0xc351239f reqid 1 mode tunnel
	replay-window 0 flag af-unspec
	auth-trunc hmac(sha256) 0x5cd19c945c7b7e0ea34596ca36bb16f25586e5bf6f06602562c6ec9f16aa2f91 128
	enc cbc(aes) 0xcb70311885ff5118241a5d6b7cde6c8bcdbc3579567caad1a6af84a61563bb7a
	anti-replay context: seq 0x0, oseq 0x0, bitmap 0x00000000
src 10.1.8.10 dst 10.1.5.10
	proto esp spi 0xcafe0be1 reqid 1 mode tunnel
	replay-window 32 flag af-unspec
	auth-trunc hmac(sha256) 0x40e12f29a1efa405fa403f051dffc605e24a88cb5067c2aff42c88005d1f3d09 128
	enc cbc(aes) 0x24b010f07fec1206f8d3d81ba71040437e884957e7c6b6e4582ab8c7d5eb97c0
	anti-replay context: seq 0x0, oseq 0x0, bitmap 0x00000000
```

查看对应的加密算法
```shell
swanctl --list-sas --raw
```
结果如下
```shell
list-sa event {VyOS-B {uniqueid=1 version=2 state=ESTABLISHED local-host=10.1.5.10 local-port=4500 local-id=10.1.5.10 remote-host=10.1.8.10 remote-port=4500 remote-id=10.1.8.10 initiator=yes initiator-spi=94fe0de3ab9ca06a responder-spi=9c1f4b059b81071d encr-alg=AES_CBC encr-keysize=256 integ-alg=HMAC_SHA2_256_128 prf-alg=PRF_HMAC_SHA2_256 dh-group=ECP_256 established=1866 rekey-time=26451 child-sas {VyOS-B-tunnel-1-1 {name=VyOS-B-tunnel-1 uniqueid=1 reqid=1 state=INSTALLED mode=TUNNEL protocol=ESP spi-in=cafe0be1 spi-out=c351239f encr-alg=AES_CBC encr-keysize=256 integ-alg=HMAC_SHA2_256_128 bytes-in=588 packets-in=7 use-in=1790 bytes-out=588 packets-out=7 use-out=1790 rekey-time=1206 life-time=1734 install-time=1866 local-ts=[10.244.1.0/24] remote-ts=[10.244.2.0/24]}}}}
list-sas reply {}
```
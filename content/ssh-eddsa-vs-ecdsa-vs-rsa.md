---
title: "Ssh EdDSA vs ECDSA vs RSA"
date: 2020-08-27T15:29:34-04:00
tags: ["sysadmin", "security"]
---

EdDSA is preferred over ECDSA/DSA for SSH or any other secure protocol. ECDSA relies on a random number nonce which if found could allow the private key to be derived.

> What Makes Them Different?
> RSA: Integer Factorization
> DSA: Discrete Logarithm Problem & Modular Exponentiation
> ECDSA & EdDSA: Elliptic Curve Discrete Logarithm Problem

> The computational complexity of the discrete log problem allows both classes of algorithms to achieve the same level of security as RSA with significantly smaller keys.

So effectively ECDSA/EdDSA achieve the same thing as RSA but with more efficient key generation and smaller keys. They are not inherently more secure than RSA.

>  Functionally, where RSA and DSA require key lengths of 3072 bits to provide 128 bits of security, ECDSA can accomplish the same with only 256-bit keys. However, ECDSA relies on the same level of randomness as DSA, so the only gain is speed and length, not security.

> Bit security measures the number of trials required to brute-force a key. 128 bit security means 2128 trials to break.

> Taking a step back, the use of elliptic curves does not automatically guarantee some level of security. Not all curves are the same. Only a few curves have made it past rigorous testing. Luckily, the PKI industry has slowly come to adopt Curve25519 in particular for EdDSA. Put together that makes the public-key signature algorithm, Ed25519.

Curve 25519 was chosen because it was believed that the NSA had potentially implemented a backdoor into the random number generator used by ECDSA. See https://en.wikipedia.org/wiki/Curve25519

Source https://gravitational.com/blog/comparing-ssh-keys/

Read up on how the SSH handshake works in a related blog post https://gravitational.com/blog/ssh-handshake-explained/  and https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange .

<!--more-->

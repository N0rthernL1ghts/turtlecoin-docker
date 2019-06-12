# TutleCoin Node (Docker) 
![Turtle](https://cdn.elite7hackers.net/serve/imgx/images/2019/06/11/download-Turtle-PNG-transparent-images-transparent-backgrounds-PNGRIVER-COM-10680-turtlee4ef80440abedca1.png)
![Plus](https://cdn.elite7hackers.net/serve/imgx/images/2019/06/11/plus7dd106792bdd1aad.png)
![Docker](https://cdn.elite7hackers.net/serve/imgx/images/2019/06/11/docker_logofeb6d2d7a51a3825.png)

## Introduction

> s6 supervised docker image for TurtleCoin node

## Installation

How to install/run:

First create volume:
```
docker volume create turtlecoin_data
```

If you want to run free node:
```
docker run \
 --name turtlecoin_free_node \
 -v turtlecoin_data:/home/turtle \
 -p 11898:11898 \
 --restart unless-stopped \
 nlss/turtlecoin-docker
```

If you want to run premium node:
```
docker run \
--name turtlecoin_premium_node \
 -e WALLET_ADDRESS=TRTLv3Y2Kt5dC7S4Rmtt8X6Z3nGyvPUCWJy84jtHYwvk395mEVV6JKqDG2Zvp2KXusNVzTpEzeNn6B9WtbMPN2mJ5hgwTLj5mBV \
 -e NODE_FEE=50000 \
 -p 11898:11898 \
 -v turtlecoin_data:/home/turtle \
 --restart unless-stopped \
 nlss/turtlecoin-docker
```

## Available environment variables
```
WALLET_ADDRESS = TRTLv3Y2Kt5dC7S4Rmtt8X6Z3nGyvPUCWJy84jtHYwvk395mEVV6JKqDG2Zvp2KXusNVzTpEzeNn6B9WtbMPN2mJ5hgwTLj5mBV
FEE_AMOUNT = 50000
```

## Persistent storage
As this is docker storage, by default it has no persistent storage. 

This image comes with preconfigured volume which will be automatically assigned by docker.

It servers purpose to hold TurtleCoin node data (eg. database).

Please remember that you SHOULD assign this to your own volume as docker assigned volumes are perishable.


## TODO
- Compatibility with brandonlehmann/turtlecoin-api-proxy
- Possibility to run in cluster

## Contributing
Fork -> Patch -> Push -> Pull Request

## Buy me a beer
If you like this project, buy me a beer. :)  
Donations of any amount are appreciated.

Donate beloved TRTL:
> TRTLv3Y2Kt5dC7S4Rmtt8X6Z3nGyvPUCWJy84jtHYwvk395mEVV6JKqDG2Zvp2KXusNVzTpEzeNn6B9WtbMPN2mJ5hgwTLj5mBV

Donate BTC:
> bc1q2xur3reqen390xq8nrysrjk36jkz2e3k7mdn0r

> 1EYfxRzwgV9hPzDW3ATVYz23M6ZBsHM9zy

Donate ETH:
> 0x6585A9F01A2adb499C4ec46757b4B19Ff7De37b6

## Special thanks to
- [@andrewnk](https://github.com/andrewnk) - his [turtlecoin Alpine build](https://github.com/andrewnk/turtlecoin-docker/tree/master/dockerfiles/base) is in use

## Disclaimer
Please see [License File](LICENSE) for more information.

## License
The MIT License (MIT). Please see [License File](LICENSE) for more information.
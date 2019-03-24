# Lunarium Docker Image
Docker image of the Lunarium daemon

## Setup
The following steps below should start your Lunarium docker instance.
```
git clone https://github.com/LunariumCoin/lunarium-docker.git
cd lunarium-docker
docker build -t lunarium-docker .
docker run -it -d lunarium-docker:latest
```
## Accessing the daemon
```
sudo docker exec -it CONTAINER_ID /bin/bash
```
Use the daemon as you normally would.
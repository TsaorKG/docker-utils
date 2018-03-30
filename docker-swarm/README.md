# Docker Swarm <a href="../docker-swarm"><img src="../images/swarm.png" alt="alt text" width="50px" height="50px"></a>
This folder contains a variety of scripts used to simplify the work with docker swarm in local

## [swarm_init.sh](./swarm_init.sh)

### What for ? 
This script is used to deploy a swarm in local on mac or windows using docker-machine.
You can choose between two sizes of swarm:
-   3 nodes = 1 manager + 2 workers
-   6 nodes = 3 managers + 3 workers
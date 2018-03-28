# Blue-Green deployment
This folder contains a ready to use example of a blue green deployment strategy running in a swarm mode
<a href="../blue-green-deployment"><img src="../images/bg.png" alt="alt text"></a>

## How to ? 
Clone the repository:

    git clone git@github.com:GabrielWal/docker-utils.git
    cd blue-green-deployment

Simply run the build & deploy script:

    ./build-deploy.sh

Then open your favorite browser and check the following url (By default the blue stack is online)
>http://localhost:80

Then use the switch script:

    ./switch.sh

This will switch from current color blue to green.
The next time you call switch it will swith from green to blue.

In order to test the switch use the test-site script which will infinitely curl the color page of the sample app. 
Run it in another terminal window then run the switch script, this will show the impact of the switch.
You should have an output like below

    ./test-site.sh
    blue
    blue
    blue
    blue
    (...)
    blue
    green
    blue
    green
    blue
    (...)
    green
    green
    green
    green

## Prerequisite
This project requires

    docker
    docker-compose

It has been tested with the following versions

#### Docker

    Client:
     Version:	18.03.0-ce
     API version:	1.37
     Go version:	go1.9.4
     Git commit:	0520e24
     Built:	Wed Mar 21 23:06:22 2018
     OS/Arch:	darwin/amd64
     Experimental:	false
     Orchestrator:	swarm

    Server:
     Engine:
     Version:	18.03.0-ce
     API version:	1.37 (minimum version 1.12)
     Go version:	go1.9.4
     Git commit:	0520e24
     Built:	Wed Mar 21 23:14:32 2018
     OS/Arch:	linux/amd64
     Experimental:	false

#### Docker-Compose

    docker-compose version 1.20.1, build 5d8c71b
    docker-py version: 3.1.4
    CPython version: 3.6.4
    OpenSSL version: OpenSSL 1.0.2n  7 Dec 2017

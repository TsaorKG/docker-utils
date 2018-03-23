# Docker Scripts
This folder contains a variety of scripts that could be use in order to facilitate the work of DevOps team.

## Cluster Swarm + VM d'admin
In the case we have the following architecture --> a cluster swarm paired with an administration server with ssh capabilities on the whole cluster.

    ______________     SSH   ______________
    |  VM admin  |_ _ _ _ _ _|Docker-Swarm|
    |____________|           |____________|

### [exec_container.sh](./exec_container.sh)
**|This scripts is to be used on the VM admin|**

#### What for ? 
When you need to exec into a container, instead of checking on a manager which node the container is running on, simply use this script from the admin. 
It will connect you directly to the node where the container your are looking for is running and print you the "docker exec" command to run.
One copy-paste and you'r in. 

#### How ? 
Configure the script : 
* USER='...'
    > Set the ssh user to connect with
* MANAGER='...'
    > Set one swarm manager hostname
* SSHKEY='...'
    > Set the ssh private key path 

Then simply call the script with the name of the service your container belongs to.
Sample : 
> ./exec_container.sh drupal

#### Adds-on 
In the given command you will also see a 'stty cols \*value\*' this is done in order to avoid term size issues. 
When  you do a docker exec by default the given term size is 80x24. And it will be adjust to your current size only if you change the size of the window. 
In order to avoid any prompt issues I directly set the right size in the container terminal.

### [inspect.sh](./inspect.sh)
**|This scripts is to be used on the VM admin|**

#### What for ? 
When you need to have multiple informations about a running container, instead of checking on a manager which node the container is running on and executing multiple commands, simply use this script from the admin.
It will print you all most important informations about your running container.

#### How ? 
Configure the script : 
* USER='...'
    > Set the ssh user to connect with
* MANAGER='...'
    > Set one swarm manager hostname
* SSHKEY='...'
    > Set the ssh private key path 

Then simply call the script with the name of the service your container belongs to.
Sample : 
> ./inspect.sh drupal

# Docker Secrets <a href="../docker-secret"><img src="../images/secret.png" alt="alt text" width="50px" height="50px"></a>
This folder contains the ressources to build a sample docker image in order to show a way of using the docker secrets to protect sensitive data.

## How to ?
Clone the repository:

    git clone git@github.com:GabrielWal/docker-utils.git
    cd blue-green-deployment

Fulfill the secret file with your own sample values (name, date, password, port)

Simply run the build & deploy script:

    ./build-run.sh

Then open your favorite browser and check the following url
>http://localhost:8080

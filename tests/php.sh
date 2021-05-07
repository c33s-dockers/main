docker build --file php/base/Dockerfile-8.0 ./php/base
#docker build --file php/base/Dockerfile-7.4 ./php/base
#docker build --file php/base/Dockerfile-7.3 ./php/base
#docker build --file php/base/Dockerfile-7.2 ./php/base
#docker build --file php/base/Dockerfile-7.1 ./php/base
#docker build --file php/base/Dockerfile-7.0 ./php/base
#docker build --file php/base/Dockerfile-5.6 ./php/base


#Using docker image sha256:d2979b152a7d43f040c7aef88c4c83de4e545227622b1045adf6fe409293f803 for docker:latest with digest docker@sha256:ad50b8d78b41dc52f42ab123ce0e3f48c5443   w  7ed70ecc2a44c99e889924c8e56 ...
#$ chmod +x tests/php.sh
#$ ./tests/php.sh
#error during connect: Post http://docker:2375/v1.24/build?buildargs=%7B%7D&cachefrom=%5B%5D&cgroupparent=&cpuperiod=0&cpuquota=0&cpusetcpus=&cpusetmems=&cpushares=0&dockerfile=Dockerfile-8.0&labels=%7B%7D&memory=0&memswap=0&networkmode=default&rm=1&shmsize=0&target=&ulimits=null&version=1: dial tcp: lookup docker on 169.254.169.254:53: no such host
#error during connect: Post http://docker:2375/v1.24/build?buildargs=%7B%7D&cachefrom=%5B%5D&cgroupparent=&cpuperiod=0&cpuquota=0&cpusetcpus=&cpusetmems=&cpushares=0&dockerfile=Dockerfile-7.4&labels=%7B%7D&memory=0&memswap=0&networkmode=default&rm=1&shmsize=0&target=&ulimits=null&version=1: dial tcp: lookup docker on 169.254.169.254:53: no such host
#Cleaning up file based variables 00:01
#ERROR: Job failed: exit code 1

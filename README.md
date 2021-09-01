# training plan 

<img src="plan.png">

# Docker revision 

<img src="rev.png">

## Docker compose file version discussion 

<img src="composef.png">

## Cleaning up docker engine 

```
282  docker  rmi $(docker  images -q)
  283  docker  rmi $(docker  images -q) -f
  284  docker  ps  -a
  285  docker  images
  286  docker  network  ls
  287  docker  volume ls
  288  docker  volume ls  -q
  289  docker  volume  rm $(docker  volume ls  -q)
  290  docker  volume ls
  
```

## COmpose example 1 

```
[ashu@ip-172-31-29-98 ashucompose1]$ docker-compose up -d 
Creating network "ashucompose1_default" with the default driver
Pulling ashuapp1 (alpine:)...
latest: Pulling from library/alpine
a0d0a0d46f8b: Downloading [>                                                  ]  33.32kB/2.814a0d0a0d46f8b: Downloading [==================================================>]  2.814MB/2.814a0d0a0d46f8b: Extracting [>                                                  ]  32.77kB/2.814Ma0d0a0d46f8b: Extracting [=============>                                     ]  753.7kB/2.814Ma0d0a0d46f8b: Extracting [==================================================>]  2.814MB/2.814Ma0d0a0d46f8b: Extracting [==================================================>]  2.814MB/2.814Ma0d0a0d46f8b: Pull complete
Digest: sha256:e1c082e3d3c45cccac829840a25941e679c25d438cc8412c2fa221cf1a824e6a
Status: Downloaded newer image for alpine:latest
Creating ashuc1 ... done

```

### more compose commands 

```
 298  docker-compose up -d 
  299  docker-compose  ps
  300  docker-compose  images
  301  docker-compose  logs 
  302  history 
[ashu@ip-172-31-29-98 ashucompose1]$ docker-compose  ps
 Name       Command       State   Ports
---------------------------------------
ashuc1   ping localhost   Up           
[ashu@ip-172-31-29-98 ashucompose1]$ docker-compose  images
Container   Repository    Tag       Image Id       Size  
---------------------------------------------------------
ashuc1      alpine       latest   14119a10abf4   5.595 MB

===

ashu@ip-172-31-29-98 ashucompose1]$ docker-compose  stop 
Stopping ashuc1 ... done
[ashu@ip-172-31-29-98 ashucompose1]$ docker-compose  ps
 Name       Command        State     Ports
------------------------------------------
ashuc1   ping localhost   Exit 137        
[ashu@ip-172-31-29-98 ashucompose1]$ docker-compose  start
Starting ashuapp1 ... done
[ashu@ip-172-31-29-98 ashucompose1]$ docker-compose  ps
 Name       Command       State   Ports
---------------------------------------
ashuc1   ping localhost   Up           
[ashu@ip-172-31-29-98 ashucompose1]$ docker-compose  kill 
Killing ashuc1 ... done
[ashu@ip-172-31-29-98 ashucompose1]$ docker-compose  ps
 Name       Command        State     Ports
------------------------------------------
ashuc1   ping localhost   Exit 137        

```

### help in compose 

```
ashu@ip-172-31-29-98 ashucompose1]$ mv  docker-compose.yaml   a.ym
[ashu@ip-172-31-29-98 ashucompose1]$ ls
a.ym
[ashu@ip-172-31-29-98 ashucompose1]$ docker-compose ps 
ERROR: 
        Can't find a suitable configuration file in this directory or any
        parent. Are you in the right directory?

        Supported filenames: docker-compose.yml, docker-compose.yaml, compose.yml, compose.yaml
        
[ashu@ip-172-31-29-98 ashucompose1]$ docker-compose -f  a.ym  ps
 Name       Command        State     Ports
------------------------------------------
ashuc1   ping localhost   Exit 137    

```

### remove components in compose 

```
[ashu@ip-172-31-29-98 ashucompose1]$ docker-compose down 
Removing ashuc1 ... done
Removing network ashucompose1_default

```

### Compose example 2 

```
version: '3.8' # compose file version 
services:
 ashuapp2:
  image: centos
  command: ping fb.com 
 ashuapp1:
  image: alpine
  container_name: ashuc1
  command: ping localhost 
  
```

### up 

```
[ashu@ip-172-31-29-98 ashucompose1]$ docker-compose -f  example2.yaml up  -d 
Creating network "ashucompose1_default" with the default driver
Creating ashucompose1_ashuapp2_1 ... done
Creating ashuc1                  ... done
[ashu@ip-172-31-29-98 ashucompose1]$ docker-compose -f  example2.yaml  ps
         Name                Command       State   Ports
--------------------------------------------------------
ashuc1                    ping localhost   Up           
ashucompose1_ashuapp2_1   ping fb.com      Up 

```

### more commands 

```
[ashu@ip-172-31-29-98 ashucompose1]$ docker-compose -f  example2.yaml  ps ashuapp1
 Name       Command       State   Ports
---------------------------------------
ashuc1   ping localhost   Up           
[ashu@ip-172-31-29-98 ashucompose1]$ docker-compose -f  example2.yaml kill ashuapp1
Killing ashuc1 ... done
[ashu@ip-172-31-29-98 ashucompose1]$ docker-compose -f  example2.yaml  ps
         Name                Command        State     Ports
-----------------------------------------------------------
ashuc1                    ping localhost   Exit 137        
ashucompose1_ashuapp2_1   ping fb.com      Up              
[ashu@ip-172-31-29-98 ashucompose1]$ docker-compose -f  example2.yaml  down
Stopping ashucompose1_ashuapp2_1 ... done
Removing ashucompose1_ashuapp2_1 ... done
Removing ashuc1                  ... done
Removing network ashucompose1_default

```

### Example 3 for compose 

### httpd vs nginx 

<img src="webs.png">

##

```
[ashu@ip-172-31-29-98 ashucompose1]$ docker-compose -f example3.yaml up -d 
Creating network "ashucompose1_default" with the default driver
Building ashuapp1
Sending build context to Docker daemon  260.6kB
Step 1/3 : FROM nginx
 ---> dd34e67e3371
Step 2/3 : LABEL email=ashutoshh@linux.com
 ---> Running in edf50352a7df
Removing intermediate container edf50352a7df
 ---> ac90f611dd80
Step 3/3 : COPY  webapp /usr/share/nginx/html/
 ---> 7e134dd0dd83
Successfully built 7e134dd0dd83
Successfully tagged cisocweb:ashuv111
WARNING: Image for service ashuapp1 was built because it did not already exist. To rebuild this image you must use `docker-compose build` or `docker-compose up --build`.
Creating ashuc1 ... done

```

## to build image everytime 

```
[ashu@ip-172-31-29-98 ashucompose1]$ docker-compose -f example3.yaml up -d --build
Creating network "ashucompose1_default" with the default driver
Building ashuapp1
Sending build context to Docker daemon  260.6kB
Step 1/3 : FROM nginx
 ---> dd34e67e3371
Step 2/3 : LABEL email=ashutoshh@linux.com
 ---> Using cache
 ---> ac90f611dd80
Step 3/3 : COPY  webapp /usr/share/nginx/html/
 ---> f42ecf250197
Successfully built f42ecf250197
Successfully tagged cisocweb:ashuv111
Creating ashuc1 ... done


```

###  figureout problem and solution 

<img src="prob.png">

### COntainer management prob 


<img src="cont_man.png">

### Intro to k8s 

<img src="k8s.png">

## Understanding k8s plan and arch 

### arch L1 

<img src="k8sarch1.png">

### kube-apiserver in Master node 

<img src="apis.png">

### kube-schedular 

<img src="kube-sch.png">

### kube-controller -manager

<img src="kubem.png">

### ETCD in master node

<img src="etcd.png">



### k8s cluster deployment methods 


<img src="k8sdep.png">










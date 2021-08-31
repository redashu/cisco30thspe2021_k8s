# training plan 

<img src="plan.png">

## Namespaces 

<img src="ns.png">

## PYthon flask web application -- containerization 

<img src="flask.png">

### Cloning flask app 

```
[ashu@ip-172-31-29-98 myimages]$ git clone  https://github.com/redashu/flaskwebappnew
Cloning into 'flaskwebappnew'...
remote: Enumerating objects: 44, done.
remote: Counting objects: 100% (44/44), done.
remote: Compressing objects: 100% (35/35), done.
remote: Total 44 (delta 4), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (44/44), 162.39 KiB | 11.60 MiB/s, done.
Resolving deltas: 100% (4/4), done.
[ashu@ip-172-31-29-98 myimages]$ ls
flaskwebappnew  pythonapp

```
### building docker image 

```
ashu@ip-172-31-29-98 flaskwebappnew]$ docker  build  -t dockerashu/ciscoflask:v001  .  
Sending build context to Docker daemon  416.8kB
Step 1/8 : FROM centos
 ---> 300e315adb2f
Step 2/8 : LABEL email="ashutoshh@linux.com"
 ---> Running in a737fc5c1e0c
Removing intermediate container a737fc5c1e0c
 ---> 921fb1a3c08f
Step 3/8 : RUN yum  install python3  python3-pip -y
 ---> Running in 8f3b3ccfa941
CentOS Linux 8 - AppStream                       23 MB/s | 8.8 MB     00:00    
CentOS Linux 8 - BaseOS                          18 MB/s | 5.6 MB     00:00    
CentOS Linux 8 - Extras                          11 kB/s |  10 kB     00:00    
Dependencies resolved.
================================================================================
 Package             Arch   Version                             Repo       Size
================================================

```






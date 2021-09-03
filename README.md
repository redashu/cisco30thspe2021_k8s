# training plan 

<img src="plan.png">

## Deployment 

<img src="rolling.png">

### building sample web app calling it v1 

```
❯ docker  build  -t dockerashu/ciscowebapp:v0011  .
[+] Building 12.7s (5/7)                                                                                  
 => [internal] load build definition from Dockerfile                                                 0.2s
 => => transferring dockerfile: 92B                                                                  0.0s
 => [internal] load .dockerignore                                                                    0.2s
 => => transferring context: 2B                                                                      0.0s
 => [internal] load metadata for docker.io/library/nginx:latest                                      4.6s
 => [auth] library/nginx:pull token for registry-1.docker.io                                         0.0s
 => [internal] load build context                                                                    0.1s
 => => transferring context: 418B                                                                    0.0s
 => [1/2] FROM docker.io/library/nginx@sha256:e5c237fda6556a74408af0e8126aaf34812160722f0a24a01d583  7.6s
 => => resolve docker.io/library/nginx@sha256:e5c237fda6556a74408af0e8126aaf34812160722f0a24a01d583  0.0s
 => => sha256:e5c237fda6556a74408af0e8126aaf34812160722f0a24a01d58301e014fa98c 1.86kB / 1.86kB       0.0s
 => => sha256:dd34e67e3371dc2d1328790c3157ee42dfcae74afffd86b297459ed87a98c0fb 7.73kB / 7.73kB       0.0s
 => => sha256:e1acddbe380c63f0de4b77d3f287b7c81cd9d89563a230692378126b46ea6546 20.97MB / 27.15MB     7.5s
 => => sha256:5e95e5eb8be4322e3b3652d737371705e56809ed8b307ad68ec59ddebaaf60e4 1.57kB / 1.57kB       0.0s
 => => sha256:f3341cc17e586daa96
 
 
 ```
 
 ### pushing image 
 
 ```
 ❯ docker  images
REPOSITORY                    TAG       IMAGE ID       CREATED          SIZE
dockerashu/ciscowebapp        v0011     c9e0125a845a   11 seconds ago   133MB
gcr.io/k8s-minikube/kicbase   v0.0.25   8768eddc4356   2 months ago     1.1GB
❯ docker login -u dockerashu
Password: 
Login Succeeded
❯ docker push  dockerashu/ciscowebapp:v0011
The push refers to repository [docker.io/dockerashu/ciscowebapp]
93453793489a: Pushing  4.096kB
fb04ab8effa8: Preparing 
8f736d52032f: Preparing 
009f1d338b57: Preparing 

```

### creating yaml 

```
3694  kubectl  create  deployment  ashuwebapp --image=dockerashu/ciscowebapp:v0011  --dry-run=client -o yaml 
❯ kubectl  create  deployment  ashuwebapp --image=dockerashu/ciscowebapp:v0011  --dry-run=client -o yaml  >rolling.yaml

```

### creating service 

```
kubectl   create  service nodeport ashusvc11 --tcp 1234:80 --dry-run=client -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: ashusvc11
  name: ashusvc11
spec:
  ports:
  - name: 1234-80
    port: 1234
    protocol: TCP
    targetPort: 80
  selector:
    app: ashusvc11
  type: NodePort
status:
  loadBalancer: {}
  
  
```

### finally deploy -- app 

```
❯ kubectl  apply -f  rolling.yaml
deployment.apps/ashuwebapp created
service/ashusvc11 created
❯ kubectl  get deployment
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
ashuwebapp   1/1     1            1           8s
❯ kubectl  get  po
NAME                         READY   STATUS    RESTARTS   AGE
ashuwebapp-758654b4f-9ffdz   1/1     Running   0          14s
❯ kubectl  get  svc
NAME        TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
ashusvc11   NodePort   10.105.44.23   <none>        1234:30332/TCP   17s


```

### POd scaling in k8s 

<img src="scale.png">

### horizontal manual scaling 

```
❯ kubectl   get  deploy
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
ashuwebapp   1/1     1            1           8m2s
❯ kubectl  scale  deploy ashuwebapp  --replicas=3
deployment.apps/ashuwebapp scaled
❯ kubectl   get  deploy
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
ashuwebapp   3/3     3            3           8m22s
❯ kubectl  get  po
NAME                         READY   STATUS    RESTARTS   AGE
ashuwebapp-758654b4f-9ffdz   1/1     Running   0          8m33s
ashuwebapp-758654b4f-d4tg4   1/1     Running   0          15s
ashuwebapp-758654b4f-vvx8p   1/1     Running   0          15s


```

### End to end app 

<img src="final.png">

### updata app 

```
❯ docker  build  -t dockerashu/ciscowebapp:v0022  .
[+] Building 4.0s (8/8) FINISHED                                                                          
 => [internal] load build definition from Dockerfile                                                 0.1s
 => => transferring dockerfile: 36B                                                                  0.1s
 => [internal] load .dockerignore                                                                    0.1s
 => => transferring context: 2B                                                                      0.0s
 => [internal] load metadata for docker.io/library/nginx:latest                                      3.1s
 => [auth] library/nginx:pull token for registry-1.docker.io                                         0.0s
 => [internal] load build context                                                                    0.1s
 => => transferring context: 483B                                                                    0.0s
 => CACHED [1/2] FROM docker.io/library/nginx@sha256:e5c237fda6556a74408af0e8126aaf34812160722f0a24  0.0s
 => [2/2] COPY index.html /usr/share/nginx/html/                                                     0.1s
 => exporting to image                                                                               0.1s
 => => exporting layers                                                                              0.1s
 => => writing image sha256:769c459b7f5fd526951ace77781c7da37f6012f6dfe769bb7415be0c27156b57         0.0s
 => => naming to docker.io/dockerashu/ciscowebapp:v0022                                              0.0s
❯ docker push  dockerashu/ciscowebapp:v0022
The push refers to repository [docker.io/dockerashu/ciscowebapp]
f3961d0e0cbc: Pushing  4.096kB
fb04ab8effa8: Layer already exists 
8f736d52032f: Layer already exists 
009f1d338b57: Layer already exists 
678bbd796838: Layer already exists 

```

### updating image in deployment 

```
❯ kubectl  get deploy
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
ashuwebapp   3/3     3            3           32m
❯ kubectl  set  image  deploy  ashuwebapp  ciscowebapp=dockerashu/ciscowebapp:v0022
deployment.apps/ashuwebapp image updated
❯ kubectl  get  po
NAME                         READY   STATUS    RESTARTS   AGE
ashuwebapp-8d667dcc9-4lzxq   1/1     Running   0          27s
ashuwebapp-8d667dcc9-f8rsc   1/1     Running   0          22s
ashuwebapp-8d667dcc9-fxm2m   1/1     Running   0          25s

```

### reality of Loadbalancer. service 

<img src="lbsvc.png">

### auto scaling in POD 

<img src="hpa.png">

### hap conditions 

<img src="hpacon.png">

### HPA 

#### setting limits in Resources 

<img src="limit.png">

#### we need metric server 

<img src="metric.png">

### Deploying metric server 

[metric server](https://docs.aws.amazon.com/eks/latest/userguide/metrics-server.html)

### creating auto scaling rules 

```
❯ kubectl  get deploy
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
ashuwebapp   1/1     1            1           95m
❯ kubectl  autoscale  deploy ashuwebapp  --min=1  --max=10   --cpu-percent=80
horizontalpodautoscaler.autoscaling/ashuwebapp autoscaled
❯ kubectl  get  hpa
NAME         REFERENCE               TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
ashuwebapp   Deployment/ashuwebapp   0%/80%    1         10        1          17s
❯ kubectl  get  hpa
NAME         REFERENCE               TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
ashuwebapp   Deployment/ashuwebapp   0%/80%    1         10        1          27s

```

### app deploy in k8s from private registry 

```
❯ kubectl  run   privatepod  --image=phx.ocir.io/axmbtg8judkl/cisco:v1  --command ping fb.com --dry-run=client -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: privatepod
  name: privatepod
spec:
  containers:
  - command:
    - ping
    - fb.com
    image: phx.ocir.io/axmbtg8judkl/cisco:v1
    name: privatepod
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
❯ kubectl  run   privatepod  --image=phx.ocir.io/axmbtg8judkl/cisco:v1  --command ping fb.com --dry-run=client -o yaml   >pri.yml

```

### Deploy img 

```
❯ kubectl  apply -f  pri.yml
pod/privatepod created
❯ kubectl  get  po
NAME         READY   STATUS         RESTARTS   AGE
privatepod   0/1     ErrImagePull   0          8s

```

### secret will be used to store password or OCR 

<img src="sec.png">

### creating secret to OCR info 

```
kubectl  create  secret  docker-registry  ashuimgsec  --docker-server=phx.ocir.io  --docker-username axmg8judkl/learme@gmail.com  --docker-password="PQzp)biBr+"

```

### 

```
❯ kubectl  get secret
NAME                  TYPE                                  DATA   AGE
ashuimgsec            kubernetes.io/dockerconfigjson        1      8s
default-token-hhpt5   kubernetes.io/service-account-token   3      23h

```

### helm intro 

<img src="helm.png">

### always go with helm v3 

<img src="helmv3.png">

### helm client side installation 

[helm](https://helm.sh/docs/intro/install/)


### ingress controller 

<img src="ingress.png">

### Ingress controller 

<img src="ig.png">

### storage in k8s 


<img src="st.png">

### mysql Db deployment. 

```
kubectl  create  deployment   ashudb --image=mysql  --dry-run=client -o yaml   >ashudb.yaml

```

### create secret 

````
❯ kubectl  create  secret  generic  ashudbsec  --from-literal  key1=Ciscodb088
secret/ashudbsec created
❯ kubectl  get  secret
NAME                  TYPE                                  DATA   AGE
ashudbsec             Opaque                                1      11s
ashuimgsec            kubernetes.io/dockerconfigjson        1      137m
default-token-hhpt5   kubernetes.io/service-account-token   3      26h

```

### service create 


```
❯ kubectl  expose deploy  ashudb  --type ClusterIP  --port 3306 --dry-run=client  -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: ashudb
  name: ashudb
spec:
  ports:
  - port: 3306
    protocol: TCP
    targetPort: 3306
  selector:
    app: ashudb
  type: ClusterIP
status:
  loadBalancer: {}
❯ kubectl  expose deploy  ashudb  --type ClusterIP  --port 3306
service/ashudb exposed
❯ kubectl  get  svc
NAME     TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
ashudb   ClusterIP   10.105.159.201   <none>        3306/TCP   5s

```

### k8s volumes 

<img src="vol.png">

### Example of emptyDir vol 

```
❯ kubectl  get  po
NAME     READY   STATUS    RESTARTS   AGE
emppod   1/1     Running   0          25s
❯ kubectl  get  po  -o wide
NAME     READY   STATUS    RESTARTS   AGE   IP                NODE      NOMINATED NODE   READINESS GATES
emppod   1/1     Running   0          29s   192.168.179.217   minion2   <none>           <none>
❯ kubectl  exec -it emppod  -- sh
/ # cd /mnt/cisco/
/mnt/cisco # ls
time.txt
/mnt/cisco # cat  time.txt 
Fri Sep  3 10:11:57 UTC 2021
Fri Sep  3 10:12:02 UTC 2021
```

### helper / sidecar container 

<img src="sidecar.png">

###

```
❯ kubectl replace -f  empvol.yaml  --force
pod "emppod" deleted
pod/emppod replaced
❯ kubectl  get  po
NAME     READY   STATUS    RESTARTS   AGE
emppod   2/2     Running   0          8s
❯ kubectl  expose pod  emppod  --type NodePort --port 80 --name ss11
service/ss11 exposed
❯ kubectl  get  svc
NAME   TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
ss11   NodePort   10.107.200.111   <none>        80:31740/TCP   5s

```

### hostPath 

<img src="hostp.png">

## Deploy portainer webui using HostPath vol

```
kubectl  create  deployment  webui  --image=portainer/portainer  --dry-run=client -o yaml >portainer.yaml

```

===

```
❯ kubectl apply -f  portainer.yaml
deployment.apps/webui created
❯ kubectl  get  deploy
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
webui   1/1     1            1           9s
❯ kubectl  get  po
NAME                     READY   STATUS    RESTARTS   AGE
webui-784948c976-8mf22   1/1     Running   0          13s
❯ kubectl expose deploy webui  --type NodePort --port 9000 --name ss112
service/ss112 exposed

```





docker build . -t localhost:5000/mypod:v10

docker push localhost:5000/mypod:v10


docker stop mypod2; docker rm mypod2
docker run --name=mypod2 -dit localhost:5000/mypod:v10 /bin/sh

docker exec -it mypod2 /bin/sh

docker stop mypod2; docker rm mypod2

# edit mypod.yaml file image version
kubectl delete pod mypod
kubectl create -f mypod.yaml
kubectl get pods
kubectl logs mypod

docker build -t eestevez/multi-client:latest -t eestevez/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eestevez/multi-server:latest -t eestevez/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eestevez/multi-worker:latest -t eestevez/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push eestevez/multi-client:latest
docker push eestevez/multi-server:latest
docker push eestevez/multi-worker:latest

docker push eestevez/multi-client:$SHA
docker push eestevez/multi-server:$SHA
docker push eestevez/multi-worker:$SHA

kubectl apply -f k8s
kubectl set images deployments/server-deployment server=eestevez/multi-server:$SHA
kubectl set images deployments/client-deployment client=eestevez/multi-client:$SHA
kubectl set images deployments/worker-deployment worker=eestevez/multi-worker:$SHA
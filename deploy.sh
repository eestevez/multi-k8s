docker build -t eestevezp/multi-client:latest -t eestevezp/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eestevezp/multi-server:latest -t eestevezp/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eestevezp/multi-worker:latest -t eestevezp/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push eestevezp/multi-client:latest
docker push eestevezp/multi-server:latest
docker push eestevezp/multi-worker:latest

docker push eestevezp/multi-client:$SHA
docker push eestevezp/multi-server:$SHA
docker push eestevezp/multi-worker:$SHA

kubectl apply -f k8s
kubectl set images deployments/server-deployment server=eestevezp/multi-server:$SHA
kubectl set images deployments/client-deployment client=eestevezp/multi-client:$SHA
kubectl set images deployments/worker-deployment worker=eestevezp/multi-worker:$SHA
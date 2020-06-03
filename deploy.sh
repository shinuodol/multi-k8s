docker build -t odolshinu/multi-client:latest -t odolshinu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t odolshinu/multi-server:latest -t odolshinu/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t odolshinu/multi-worker:latest -t odolshinu/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push odolshinu/multi-client:latest
docker push odolshinu/multi-server:latest
docker push odolshinu/multi-worker:latest

docker push odolshinu/multi-client:$SHA
docker push odolshinu/multi-server:$SHA
docker push odolshinu/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=odolshinu/multi-server:$SHA
kubectl set image deployments/client-deployment client=odolshinu/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=odolshinu/multi-worker:$SHA
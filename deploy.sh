docker build -t charlieouyang/multi-client:latest -t charlieouyang/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t charlieouyang/multi-server:latest -t charlieouyang/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t charlieouyang/multi-worker:latest -t charlieouyang/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push charlieouyang/multi-client:latest
docker push charlieouyang/multi-client:$SHA
docker push charlieouyang/multi-server:latest
docker push charlieouyang/multi-server:$SHA
docker push charlieouyang/multi-worker:latest
docker push charlieouyang/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=charlieouyang/multi-server:$SHA
kubectl set image deployments/client-deployment client=charlieouyang/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=charlieouyang/multi-worker:$SHA

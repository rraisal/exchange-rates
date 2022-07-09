#!/bin/bash

set -e

prepare() {
eval $(minikube docker-env)
echo "[INFO]: Logged into the minikube docker environment";

docker build -t exchange-rate-app:local .

echo "[Success]: Image successfully builded";

runmyapp
}

runmyapp(){
sleep 2s;
echo "[INFO]: Enabling Addon Ingress for Minikube";
minikube addons enable ingress
sleep 5s;
echo "[INFO]: Starting the Application using Helm";
helm install exchange-rate-app -f helm-charts/app/values.yaml ./helm-charts/app
sleep 2s;
printf "\n"
echo "[Success]: App Deployed";
printf "\n\n"
kubectl get pods
printf "\n"
echo "Minikube IP = `minikube ip`"
printf "\n"
echo "[INFO]: Browse http://`minikube ip`"
printf "\n"
}
prepare
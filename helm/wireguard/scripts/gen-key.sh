#!/usr/bin/env sh
kubectl get secret --namespace $RELEASE_NAMESPACE $SECRET_NAME > /dev/null
if [ $? -eq 0 ] 
then
    echo "Secret $RELEASE_NAMESPACE/$SECRET_NAME already exists. Not chaging it."
    exit 0
fi
kubectl --namespace $RELEASE_NAMESPACE create secret generic $SECRET_NAME --from-literal=privatekey=$(wg genkey)

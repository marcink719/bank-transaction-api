# Transaction API Helm chart

## Configuration

Specify additional settings (e.g. replicaCount) in values.yaml file. 

## Installation

This manual assumes that Helm and k8s is already installed on the system.

Download dependencies:
```helm dependency build```

Install Helm chart in new namespace (run following command in the root directory of chart folder):
```helm install bank-api . --namespace bank-api --create-namespace```

Check status of resources:
```kubectl get all -n bank-api```

## Forward traffic

To enable testing on host computer running k8s (e.g. laptop running minikube cluster) you need to forward traffic on port 8080:
```kubectl port-forward -n bank-api svc/bank-transaction-api 8080:8080```

## Verify installation

Check if app is running on all pods and nodes:
```kubectl get pods -o=custom-columns=NAME:.metadata.name,NODE:.spec.nodeName -n bank-api```

Check deployment status:
```kubectl get deployments -n bank-api```

Scale deployment to desired replicas:
```kubectl scale deployment bank-api -n bank-api --replicas=3```

## Testing

A health check endpoint is available and can be used for probes, you can type:
`curl localhost:8080/health`

To add new entry in database, just send following snippet:
 ```curl -X POST http://localhost:8080/accounts -H "Content-Type: application/json"   -d '{"owner": "jan nowak", "currency": "USD"}'```

## Debugging

Tail logs of app from all nodes:
``` kubectl logs -l app=bank-api -n bank-api -f```


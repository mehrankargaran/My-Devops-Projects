# CICD_vprofile_Jenkins_monitoring

This project demonstrates a full CI/CD pipeline for the **VProfile application** using **Jenkins**, **Docker**, and **Kubernetes**, along with a monitoring stack based on **Prometheus**, **Grafana**, and **Node Exporter**. It also includes local Docker registry integration with certificates for secure image distribution.

---

## Project Structure

CICD_vprofile_Jenkins_monitoring/
├── Docker-files/
│ └── app/multistage/Dockerfile # Multi-stage Dockerfile for VProfile app
├── jenkins-certs/
│ └── config # Jenkins TLS and kubeconfig certificates
├── Jenkinsfile # Jenkins pipeline definition
├── k8s/
│ ├── deployment.yaml # Kubernetes Deployment for VProfile app
│ └── service.yaml # Kubernetes Service for VProfile app
├── monitoring/
│ ├── grafana-deployment.yaml # Grafana Deployment manifest
│ ├── node-exporter-daemonset.yaml # Node Exporter DaemonSet manifest
│ ├── prometheus-config.yaml # Prometheus configuration
│ ├── prometheus-deployment.yaml # Prometheus Deployment manifest
│ └── pushgateway-deployment.yaml # Pushgateway Deployment manifest
├── registry-certs/
│ ├── domain.crt # Docker registry certificate
│ └── domain.key # Docker registry private key
└── README.md # This file

---

## Prerequisites

1. **Jenkins server** with proper access to the Kubernetes cluster.
2. **Local Docker registry** running on `192.168.2.136:5000` with certificates in `registry-certs/`.
3. **Kubernetes cluster** with nodes configured for your application and monitoring stack.
4. **kubectl** configured on Jenkins or local machine.
5. **Maven 3** and **Java 17** installed on Jenkins agent.

---

## Setup Instructions

### 1. Docker Registry Certificates

Ensure that the local Docker registry is set up with certificates:

```bash
# On Jenkins or other nodes
sudo mkdir -p /etc/docker/certs.d/192.168.2.136:5000
sudo cp registry-certs/domain.crt /etc/docker/certs.d/192.168.2.136:5000/ca.crt
sudo systemctl restart docker

2. Kubernetes Integration with Jenkins
Copy your kubeconfig file to Jenkins:


sudo mkdir -p /var/lib/jenkins/.kube
sudo cp ~/.kube/config /var/lib/jenkins/.kube/config
sudo chown -R jenkins:jenkins /var/lib/jenkins/.kube

Test access:

sudo -u jenkins kubectl get nodes --kubeconfig=/var/lib/jenkins/.kube/config

3. Application Deployment
The Jenkins pipeline automatically builds, tags, and pushes Docker images, then deploys to Kubernetes.

Kubernetes manifests for the VProfile app are in k8s/.

Deployment example:

kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl rollout status deployment/vprofile-deployment
kubectl get svc vprofile-service -o wide

4. Monitoring Stack
Deploy Prometheus, Grafana, Node Exporter, and Pushgateway using manifests in monitoring/.

Example for Prometheus:

kubectl apply -f monitoring/prometheus-deployment.yaml
kubectl apply -f monitoring/prometheus-config.yaml
------------------
Node Exporter:

kubectl apply -f monitoring/node-exporter-daemonset.yaml
-----------------
Grafana:

kubectl apply -f monitoring/grafana-deployment.yaml
----------------
Pushgateway:

kubectl apply -f monitoring/pushgateway-deployment.yaml
---------------
Configure Prometheus to scrape metrics from:

Nodes (via Node Exporter)

Kubernetes pods and deployments

Jenkins pipeline metrics

5. Jenkins Pipeline Overview

Pipeline stages defined in Jenkinsfile:

Fetch Code: Clones the repository from GitHub.

Build with Maven: Packages the application.

Docker Build & Push: Builds Docker images, tags with BUILD_NUMBER and latest, pushes to local registry.

Kubernetes Deploy: Applies Kubernetes manifests for app deployment and service.

Metrics are pushed to Pushgateway for monitoring pipeline status.

Access URLs
Service	URL
VProfile Application	http://<NodeIP>:30080
Prometheus	http://<NodeIP>:30896
Grafana	http://<NodeIP>:30300
Pushgateway	http://192.168.2.25:9091

Replace <NodeIP> with your Kubernetes node IP where NodePort is accessible.

Notes
Certificates for Docker registry are critical for secure image pulling.

Jenkins user must have permissions to access Kubernetes cluster and Docker registry.

All manifests and pipeline scripts are configured for containerd runtime.

Adjust IP addresses and ports according to your environment.

License
This project is provided for educational purposes and does not include any commercial license.
 -by Mehran Kargaran

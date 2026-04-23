# TP Final DevOps — Lacets Connectés API

## Présentation
Ce projet met en place l'infrastructure complète pour déployer automatiquement l'API REST "Lacets Connectés" en utilisant les outils DevOps modernes.

## Prérequis
- VirtualBox 7.x
- Vagrant 2.4.x
- Ansible 2.16.x
- Docker Desktop
- kubectl

## Arborescence
tp-devops/
├── app/                    # Code source de l'API
├── vagrant/                # Partie 1 - Infrastructure k3s
│   ├── Vagrantfile
│   └── ansible/
│       ├── inventory.yml
│       └── playbook-k3s.yml
├── k8s/                    # Partie 3 - Manifests Kubernetes
├── monitoring/             # Partie 5 - Prometheus + Grafana
│   ├── Vagrantfile
│   └── ansible/
│       ├── inventory.yml
│       └── playbook-monitoring.yml
└── .github/
    └── workflows/
        └── deploy.yml      # Partie 4 - Pipeline CI/CD

## Partie 1 — Infrastructure
Démarrage de la VM k3s :
  cd vagrant && vagrant up
Installation de k3s via Ansible :
  ansible-playbook -i ansible/inventory.yml ansible/playbook-k3s.yml

## Partie 2 — Conteneurisation
Image Docker multi-stage sur Docker Hub : chrmahfzmane/lacets-connectes-api:latest
Build manuel :
  cd app && docker build -t chrmahfzmane/lacets-connectes-api:latest .
  docker push chrmahfzmane/lacets-connectes-api:latest

## Partie 3 — Déploiement Kubernetes
  kubectl apply -f k8s/ --validate=ignore
- MySQL avec PersistentVolumeClaim
- API avec HorizontalPodAutoscaler (min 1, max 3 pods)
- Tous les services en ClusterIP

## Partie 4 — Pipeline CI/CD
Pipeline GitHub Actions avec runner self-hosted.
Secrets GitHub requis :
- DOCKERHUB_USERNAME : chrmahfzmane
- DOCKERHUB_TOKEN : token Docker Hub

## Partie 5 — Monitoring
  cd monitoring && vagrant up
  ansible-playbook -i ansible/inventory.yml ansible/playbook-monitoring.yml
Accès :
- Grafana : http://192.168.56.11:3000
- Prometheus : http://192.168.56.11:9090
Dashboard Node Exporter Full (ID 1860) configuré pour les deux VMs.

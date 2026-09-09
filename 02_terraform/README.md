# TP Terraform AWS – Ulrich Franchinard

## 1. Présentation

Nous avons expérimenté et pu mettre en pratique lors du précedent cours,  l'Infrastructure as Code avec Terraform et le déploiement de ressources dans AWS.
À l’issue des cours, des exercices et des travaux pratiques, nous avons été amenés à comprendre le fonctionnement des différents composants, l’organisation des différents fichiers ainsi que la structure de l’ensemble des fichiers de configuration.
Avec ce projet , il s'agit de mettre en pratique les choses apprises en déployant une infrastructure Terraforma avec les fichiers déjà agencé . Quelques ajustements ont du être nécessaire pour adapter les variable, les credentials à l'xuistan,t .

---

## 2. Environnement de travail

Pour réaliser ce TP, j'ai utilisé :

- Windows 10
- Visual Studio Code
- PowerShell
- Git / GitHub
- Terraform
- AWS CLI
- AWS
- Amazon EC2
- Ubuntu 22.04 LTS
- Docker

Le projet est versionné sur mon fork GitHub du dépôt fourni pour le TP.
Il s'agit de : 

https://github.com/ufranchinard-devops/bootcamp-devops-projet/tree/main/02_terraform

---

## 3. Objectifs du TP

Ce TP m'a permis de travailler sur les éléments suivants :

- Cloner un dépot existant avec git
- Utiliser VScode avec les outils complémentaires
- Utiliser Terraform 
- Compréhension d'une architecture Terraform existante
- Adaptation du fichier de configuration 
- Configuration du provider AWS 
- Utilisation des variables Terraform 
- Génération d'une paire de clés SSH 
- Création d'une instance EC2 
- Installation automatique de Docker 
- Connexion SSH à une instance EC2 
- Validation du déploiement avec un conteneur Docker.

---

## 4. Structure de la partie Terraform

La partie Terraform du projet est organisée de cette manière :

02_terraform/
├── modules/
│   ├── docker/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   ├── keypair/
│   ├── kubernetes/
│   └── security_group/
│
├── scripts/
│   ├── docker.sh
│   └── kubernetes.sh
│
├── main.tf
├── outputs.tf
├── provider.tf
├── terraform.tf
├── terraform.tfvars
└── variables.tf

Cette organisation permet de séparer les différentes responsabilités du projet dans plusieurs modules.


## 5. Configuration AWS

J'ai installé AWS CLI sur mon poste Windows afin de permettre à Terraform de communiquer avec mon compte AWS.
J'ai configuré l'accès AWS avec un utilisateur IAM dédié à Terraform.
La région utilisée pour mon TP est : us-east-1

## 6. Initialisation de Terraform

Après avoir récupéré le projet, j'ai initialisé Terraform avec :

# terraform init

Cette commande permet notamment de télécharger les providers nécessaires au projet.
J'ai ensuite vérifié la configuration avec :

# terraform validate

Résultat obtenu :
Success! The configuration is valid.
J'ai également utilisé :

# terraform fmt , afin de formater les fichiers Terraform.

## 7. Prévisualisation de l'infrastructure

Avant de créer les ressources, j'ai exécuté :

# terraform plan

Cette étape m'a permis de vérifier les ressources que Terraform souhaitait créer avant de lancer le déploiement réel.


## 8. Déploiement AWS

J'ai ensuite lancé :

# terraform apply

Après validation du plan, Terraform a créé les ressources nécessaires au TP.
Parmi les éléments gérés par Terraform :

- récupération de l'AMI Ubuntu ;
- génération d'une clé privée ;
- création de la Key Pair AWS ;
- création du fichier de clé SSH local ;
- création du Security Group ;
- création de l'instance EC2 ;
- exécution du script d'installation Docker.


## 9. Installation automatique de Docker

L'installation de Docker sur l'instance EC2 est automatisée grâce au script :

scripts/docker.sh

Terraform se connecte à l'instance et exécute ce script grâce à un provisioner `remote-exec`.

Le script effectue notamment :

sudo apt update
sudo apt install wget curl git -y
curl -fsSL https://get.docker.com -o install-docker.sh
sudo sh install-docker.sh
sudo systemctl start docker
sudo usermod -aG docker ubuntu
sudo systemctl restart docker

Docker est ainsi installé automatiquement pendant le provisionnement de l'instance.


## 9. Résumé 

En définitive, le projet m'a permis de faire un premier déploiement via Teraform et de comprendre la pertinence d'un outil qui est très important lors de la création d'infrastructures .
J'ai également mis les captures dans le dossier photo .

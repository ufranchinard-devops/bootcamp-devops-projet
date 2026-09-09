# TP Terraform AWS – Ulrich Franchinard

## 1. Présentation

<<<<<<< HEAD
Nous avons expérimenté et pu mettre en pratique lors du précedent cours,  l'Infrastructure as Code avec Terraform et le déploiement de ressources dans AWS.
À l’issue des cours, des exercices et des travaux pratiques, nous avons été amenés à comprendre le fonctionnement des différents composants, l’organisation des différents fichiers ainsi que la structure de l’ensemble des fichiers de configuration.
Avec ce projet , il s'agit de mettre en pratique les choses apprises en déployant une infrastructure Terraforma avec les fichiers déjà agencé . Quelques ajustements ont du être nécessaire pour adapter les variable, les credentials à l'xuistan,t .
=======
Dans le cadre de ma formation DevOps, j'ai réalisé ce TP afin de mettre en pratique l'Infrastructure as Code avec Terraform et le déploiement de ressources dans AWS.

L'objectif était de comprendre la structure d'un projet Terraform existant, de configurer mon environnement AWS, puis de déployer réellement une instance EC2 Ubuntu sur laquelle Docker est installé automatiquement.

J'ai ensuite vérifié le fonctionnement de l'infrastructure en me connectant à l'instance en SSH et en exécutant un conteneur Docker.
>>>>>>> 73066d5 (Ajout de la documentation et des captures du TP Terraform)

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
<<<<<<< HEAD
Il s'agit de : 

https://github.com/ufranchinard-devops/bootcamp-devops-projet/tree/main/02_terraform
=======
>>>>>>> 73066d5 (Ajout de la documentation et des captures du TP Terraform)

---

## 3. Objectifs du TP

Ce TP m'a permis de travailler sur les éléments suivants :

<<<<<<< HEAD
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

=======
- utilisation de Terraform ;
- compréhension d'une architecture Terraform modulaire ;
- configuration du provider AWS ;
- utilisation des variables Terraform ;
- récupération dynamique d'une AMI Ubuntu ;
- génération d'une paire de clés SSH ;
- création d'un Security Group ;
- création d'une instance EC2 ;
- utilisation d'un script de provisionnement ;
- installation automatique de Docker ;
- connexion SSH à une instance EC2 ;
- utilisation des outputs Terraform ;
- gestion du state Terraform ;
- validation du déploiement avec un conteneur Docker.

---

## 4. Architecture

L'architecture mise en place pendant mon TP est la suivante :

```text
Poste Windows
     |
     | Terraform + AWS CLI
     v
    AWS
     |
     +----------------------+
     |                      |
     v                      v
Security Group          Key Pair SSH
     |                      |
     +----------+-----------+
                |
                v
          EC2 Ubuntu
                |
                | remote-exec
                v
           docker.sh
                |
                v
             Docker
                |
                v
       Conteneur hello-world
```

Terraform est donc utilisé pour automatiser la création de l'infrastructure AWS ainsi que le provisionnement de la machine.

---

## 5. Structure de la partie Terraform

La partie Terraform du projet est organisée de cette manière :

```text
>>>>>>> 73066d5 (Ajout de la documentation et des captures du TP Terraform)
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
<<<<<<< HEAD

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
=======
```

Cette organisation permet de séparer les différentes responsabilités du projet dans plusieurs modules.

Pour ce TP, j'ai travaillé avec :

```hcl
stack = "docker"
```

Le module Docker est donc celui qui est instancié pour le déploiement de l'EC2 utilisée pendant mes tests.

---

## 6. Configuration AWS

J'ai installé AWS CLI sur mon poste Windows afin de permettre à Terraform de communiquer avec mon compte AWS.

J'ai configuré l'accès AWS avec un utilisateur IAM dédié à Terraform.

La région utilisée pour mon TP est :

```text
us-east-1
```

J'ai vérifié l'authentification AWS avec :

```bash
aws sts get-caller-identity
```

Cette vérification m'a permis de confirmer que mon poste pouvait correctement s'authentifier auprès d'AWS avant de relancer Terraform.

---

## 7. Variables utilisées

Les principales valeurs utilisées dans mon fichier `terraform.tfvars` sont :

```hcl
protocol = "tcp"

security_groups_ports = [
  22,
  8080,
  8081,
  8082,
  8069,
  30012,
  30010,
  30011,
  6443
]

instance_type        = "t2.medium"
username             = "ubuntu"
region               = "us-east-1"
stack                = "docker"
security_groups_name = "kube_sg"
```

L'instance utilisée pour mon TP est donc une :

```text
t2.medium
```

avec Ubuntu comme système d'exploitation.

---

## 8. Initialisation de Terraform

Après avoir récupéré le projet, j'ai initialisé Terraform avec :

```bash
terraform init
```

Cette commande permet notamment de télécharger les providers nécessaires au projet.

J'ai ensuite vérifié la configuration avec :

```bash
terraform validate
```

Résultat obtenu :

```text
Success! The configuration is valid.
```

J'ai également utilisé :

```bash
terraform fmt
```

afin de formater les fichiers Terraform.

---

## 9. Prévisualisation de l'infrastructure

Avant de créer les ressources, j'ai exécuté :

```bash
terraform plan
```

Cette étape m'a permis de vérifier les ressources que Terraform souhaitait créer avant de lancer le déploiement réel.

---

## 10. Déploiement AWS

J'ai ensuite lancé :

```bash
terraform apply
```

Après validation du plan, Terraform a créé les ressources nécessaires au TP.

>>>>>>> 73066d5 (Ajout de la documentation et des captures du TP Terraform)
Parmi les éléments gérés par Terraform :

- récupération de l'AMI Ubuntu ;
- génération d'une clé privée ;
- création de la Key Pair AWS ;
- création du fichier de clé SSH local ;
- création du Security Group ;
- création de l'instance EC2 ;
- exécution du script d'installation Docker.

<<<<<<< HEAD

## 9. Installation automatique de Docker

L'installation de Docker sur l'instance EC2 est automatisée grâce au script :

scripts/docker.sh
=======
Les ressources suivies par Terraform peuvent être vérifiées avec :

```bash
terraform state list
```

Lors de mon TP, cette commande m'a notamment permis de retrouver :

```text
data.aws_ami.ubuntu
module.ec2_docker[0].aws_instance.ec2_project
module.keypair.aws_key_pair.key_project
module.keypair.local_file.local_project
module.keypair.tls_private_key.tls_key
module.security_groups.aws_security_group.sg_project
```

---

## 11. Installation automatique de Docker

L'installation de Docker sur l'instance EC2 est automatisée grâce au script :

```text
scripts/docker.sh
```
>>>>>>> 73066d5 (Ajout de la documentation et des captures du TP Terraform)

Terraform se connecte à l'instance et exécute ce script grâce à un provisioner `remote-exec`.

Le script effectue notamment :

<<<<<<< HEAD
=======
```bash
>>>>>>> 73066d5 (Ajout de la documentation et des captures du TP Terraform)
sudo apt update
sudo apt install wget curl git -y
curl -fsSL https://get.docker.com -o install-docker.sh
sudo sh install-docker.sh
sudo systemctl start docker
sudo usermod -aG docker ubuntu
sudo systemctl restart docker
<<<<<<< HEAD

Docker est ainsi installé automatiquement pendant le provisionnement de l'instance.


## 9. Résumé 

En définitive, le projet m'a permis de faire un premier déploiement via Teraform et de comprendre la pertinence d'un outil qui est très important lors de la création d'infrastructures .
J'ai également mis les captures dans le dossier photo .
=======
```

Docker est ainsi installé automatiquement pendant le provisionnement de l'instance.

---

## 12. Difficulté rencontrée : CRLF / LF

Lors de mon premier `terraform apply`, la création de l'instance EC2 s'est effectuée, mais l'exécution du script `docker.sh` a échoué.

J'ai obtenu l'erreur :

```text
/bin/bash^M: bad interpreter: No such file or directory
```

Après analyse, j'ai identifié que le script avait été enregistré avec les fins de ligne Windows :

```text
CRLF
```

alors que le script devait être exécuté sous Linux avec :

```text
LF
```

J'ai corrigé le fichier `docker.sh` dans Visual Studio Code en passant son format de `CRLF` à `LF`.

Après cette correction, j'ai relancé :

```bash
terraform apply
```

Terraform a remplacé l'instance concernée et a pu exécuter correctement le script d'installation de Docker.

Afin d'éviter que ce problème se reproduise lors des manipulations Git sous Windows, j'ai également ajouté à la racine du dépôt un fichier `.gitattributes` contenant :

```gitattributes
*.sh text eol=lf
```

J'ai vérifié la règle avec :

```bash
git check-attr eol -- 02_terraform/scripts/docker.sh
```

---

## 13. Connexion SSH à l'instance

Après le déploiement, je me suis connecté à l'instance EC2 en SSH avec la clé générée par Terraform.

Exemple :

```bash
ssh -i ./keypair/docker.pem ubuntu@<IP_PUBLIQUE>
```

Une fois connecté à Ubuntu, j'ai pu vérifier directement le fonctionnement de Docker.

---

## 14. Vérification de Docker

J'ai commencé par vérifier la version installée :

```bash
docker --version
```

Docker était correctement installé.

J'ai ensuite vérifié le service :

```bash
sudo systemctl status docker
```

Le service était :

```text
active (running)
```

J'ai enfin lancé un véritable conteneur :

```bash
docker run hello-world
```

Docker a téléchargé l'image `hello-world` puis a créé et exécuté le conteneur.

Le résultat obtenu était :

```text
Hello from Docker!
This message shows that your installation appears to be working correctly.
```

J'ai ensuite vérifié le conteneur avec :

```bash
docker ps -a
```

Le conteneur `hello-world` apparaissait avec :

```text
Exited (0)
```

Le code `0` confirme que le conteneur s'est terminé normalement.

---

## 15. Outputs Terraform

J'ai ajouté au module principal deux outputs afin de récupérer facilement les informations importantes de l'instance Docker :

```hcl
output "docker_ec2_id" {
  value = module.ec2_docker[0].ec2_id
}

output "docker_ec2_public_ip" {
  value = module.ec2_docker[0].ec2_public_ip
}
```

Après application de cette modification :

```bash
terraform apply
```

Terraform a indiqué :

```text
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```

Cela signifie qu'aucune ressource AWS n'a eu besoin d'être modifiée pour enregistrer ces outputs.

Ils peuvent ensuite être consultés avec :

```bash
terraform output
```

---

## 16. Vérification finale de l'infrastructure

Une fois les tests terminés, j'ai relancé :

```bash
terraform plan
```

Terraform a retourné :

```text
No changes. Your infrastructure matches the configuration.
```

Cela confirme que l'infrastructure réellement présente sur AWS correspond à la configuration Terraform.

La chaîne complète validée pendant mon TP est donc :

```text
Terraform
    ↓
AWS
    ↓
EC2 Ubuntu
    ↓
Provisionnement automatique
    ↓
Docker
    ↓
Connexion SSH
    ↓
hello-world
```

---

## 17. Sécurité des fichiers Terraform

Avant de publier mon travail sur GitHub, j'ai vérifié que les fichiers sensibles n'étaient pas versionnés.

Mon `.gitignore` exclut notamment :

```text
.terraform/
*.tfstate
*.tfstate.*
*.pem
terraform.tfplan
terraform.tfplan.*
```

Cela permet notamment de ne pas publier :

- le state Terraform ;
- les fichiers générés localement ;
- la clé privée SSH de l'instance.

Aucune clé privée n'est incluse dans mon dépôt Git.

---

## 18. Versionnement Git

Le projet d'origine ne m'autorisant pas à pousser directement mes modifications, j'ai créé un fork du dépôt sur mon compte GitHub.

J'ai conservé le dépôt original sous le remote :

```text
upstream
```

et mon fork personnel sous :

```text
origin
```

Mon travail Terraform a ensuite été versionné et envoyé sur mon fork.

---

## 19. Destruction des ressources

Lorsque l'infrastructure n'est plus nécessaire, elle peut être supprimée avec :

```bash
terraform destroy
```

Terraform présente alors les ressources qui vont être détruites avant de demander confirmation.

Cette étape permet notamment d'éviter de conserver inutilement une instance EC2 active sur AWS.

---

## 20. Bilan personnel

Ce TP m'a permis de mettre en pratique Terraform sur une infrastructure AWS réelle et de mieux comprendre le cycle de vie d'une infrastructure gérée en Infrastructure as Code.

J'ai pu manipuler les principales commandes Terraform :

```text
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform output
terraform state list
terraform destroy
```

Au-delà du déploiement, l'erreur rencontrée sur les fins de ligne `CRLF/LF` m'a également permis de comprendre l'importance de la compatibilité entre un environnement de développement Windows et l'exécution de scripts sur Linux.

Le test final avec Docker m'a permis de valider concrètement que l'instance créée par Terraform était accessible et correctement provisionnée.
>>>>>>> 73066d5 (Ajout de la documentation et des captures du TP Terraform)

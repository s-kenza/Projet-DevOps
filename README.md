# Projet DevOps - Déploiement Scaleway & Kubernetes (Groupe 7)

Bienvenue sur le projet de déploiement complet d'une infrastructure Scaleway Kapsule avec Kubernetes, Nginx Ingress et WordPress, réalisé dans le cadre du M2 ESGI DevOps.

## 👤 Membres du groupe

- Kenza SCHULER
- Arnaud GOUEL
- Antoine Falgiglio
- Loan COURCHINOUX-BILLONNET

## 🚀 Objectif

Déployer une stack cloud de A à Z sur Scaleway, automatisée avec Terraform :

- VPC, réseau privé, passerelle publique
- Cluster Kubernetes (Kapsule)
- Ingress Controller (Nginx)
- WordPress via Helm
- DNS public

## 🛠️ Prérequis

- [Terraform](https://www.terraform.io/downloads.html) installé
- Un compte Scaleway avec droits d'accès

## ⚙️ Variables d'environnement

Avant de lancer Terraform, configurez vos clés Scaleway :

```powershell
export SCW_ACCESS_KEY=<SCW...>
export SCW_SECRET_KEY=<xxxx-xxxx-xxxx-xxxx>
```

## 📦 Déploiement étape par étape

1. **Initialisation du projet**

   ```powershell
   terraform init
   ```

2. **Planification**

   ```powershell
   terraform plan
   ```

3. **Déploiement**
   ```powershell
   terraform apply
   ```

## 🏗️ Infrastructure déployée

- **VPC & Réseau privé**
- **Passerelle publique**
- **Cluster Kubernetes**

  - Version : `1.32.3`
  - Pool de nœuds :
    - Type : `DEV1-L`
    - Taille : `1`
  - [Documentation Kapsule](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/k8s_cluster)

- **Ingress Controller (Nginx)**

  - Déploiement via Helm
  - [Installer Nginx Ingress avec Helm](https://docs.nginx.com/nginx-ingress-controller/installation/installing-nic/installation-with-helm/)

- **WordPress**

  - Déploiement via Helm
  - [Chart Bitnami WordPress](https://github.com/bitnami/charts/tree/main/bitnami/wordpress)

- **DNS**
  - Enregistrement DNS créé avec l'IP du load balancer

## 🔑 Accès & Tests

- **Site WordPress** : [http://grp-7.esgi.slashops.fr/](http://grp-7.esgi.slashops.fr/)
- **Admin WordPress** : [http://grp-7.esgi.slashops.fr/wp-admin/](http://grp-7.esgi.slashops.fr/wp-admin/)
  - _username_ : `admin`
  - _mot de passe_ : `ChangeMe123-kenza!`

## 📚 Liens utiles

- [Documentation Scaleway](https://www.scaleway.com/en/docs/)
- [Documentation Terraform](https://www.terraform.io/docs)
- [Provider Scaleway Terraform](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs)
- [Bonnes pratiques Terraform](https://www.terraform.io/docs/language/best-practices/index.html)

## 🗝️ Sécurité

Pensez à ne jamais committer vos clés d'accès ou secrets dans le repo !

## 📝 Notes

- Console Scaleway utilisée : groupe `grp_7`
- Pastebin sécurisé : [PrivateBin](https://privatebin.info/)

---

_Pour toute question, contactez le groupe 7 ESGI DevOps._

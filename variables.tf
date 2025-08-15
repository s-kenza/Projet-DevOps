variable "zone" {
  description = "Zone Scaleway"
  type        = string
  default     = "fr-par-1"
}

variable "region" {
  description = "Région Scaleway"
  type        = string
  default     = "fr-par"
}

variable "project_name" {
  description = "Nom du projet"
  type        = string
  default     = "esgi-devops"
}

variable "wordpress_domain" {
  description = "Domaine pour WordPress"
  type        = string
  default     = "mon-wordpress.example.com"

  validation {
    condition = can(regex("^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$", var.wordpress_domain))
    error_message = "Le domaine doit respecter le format DNS (pas d'underscore, que des lettres minuscules, chiffres et tirets)."
  }
}

variable "student_name" {
  description = "Nom de l'étudiant"
  type        = string
  default     = "student"
}
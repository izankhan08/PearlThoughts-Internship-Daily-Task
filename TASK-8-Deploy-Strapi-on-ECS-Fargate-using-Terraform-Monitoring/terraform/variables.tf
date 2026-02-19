variable "cluster_name" {
  default = "strapi-cluster-task8-v12"
}

variable "service_name" {
  default = "strapi-service-v12"
}

variable "task_family" {
  default = "strapi-task-v12"
}

variable "image" {
  default = "811738710312.dkr.ecr.us-east-1.amazonaws.com/strapi:latest"
}
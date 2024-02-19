# Infrastructure

This is the Infrastructure needed to create the MEANZ stack generated with: 

- [Tofu](https://opentofu.org/docs/intro/install) 1.6.1

## Structure

- [modules](./modules) 
    - aws
- [live](./live)
    - Live Definition of the meanz site
- [secrets](secrets.sops.yml)
    - Secrets Sops yaml encrypted

## Improvements

- Terragrunt (tons of code  among versions providers variables , etc ... can be skipped with a common.hcl file)(most of the vairables were harcoded)
- VPC and subnets can have a better and more restricted Acces Control with WAF and more restricted SG's 
- Spot instances can be implemented on a more described node group with better autoscaling policy and AMI's (with scanned packages) as templates for our autoscaling groups
- Observability is not implemented , Cloud Watch and Cloud Trail should be a most in a larger environments to keep trag of the logs and record user movements. Also Prometheus and Grafana can be installed in place to gain visibility on metrics of the cluster. Will opt for other tools such as open telemetry ,ELK Stack,  Datadog ...
- Iam policies are wide open
- TF code is not refined by a tool as tfsec to perform compliance checks
- Structure on the repo is quite messy (its just structured with numbers to allow the reader know what goes first), 
- Modules repo should be splitten to gain visibility among the difference between the source code also tf modules can be stored on a private registry as citizen
- VPN, Bastion or any other fancy solution as (cloudflare tunnel)should be implemented to  be connected to the Cluster
- AWS SSO access can be implemented with more granted IAM permissions
- precommit webhook should be installed to enforce code lint and best code practices
- releases should be made in different k8s namespaces
- artifacts should be stored on private artifactories, as harbor , chartmuseum ecr acr etc ..
- CI missing (testing,scanning,pushing registry ...etc)
- Mongo auth can be implemented with an entrypoint.js for seek of simplicity we will not implement this feature 
- The Load Balancer Created in front of the Frontend service its nice but i would rather implement an ALB with the ALB controller and an ingress behind such as nginx , Istio or some other
- Acm could be used  with dns confirmation instead of CloudFLare tls encryption but will be more expensive
- Ingress rules should be more refined (dault pah to open)
- CD GitOps Such as ArgoCD , SpinnakerCD or FluxCD to have synced the state of the git repo with the actual infrastructure

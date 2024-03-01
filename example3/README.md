# 개요
* ipv4-only http sevrer와 ipv6-only http server

# 배포 방법

![img](./imgs/arch.png)

1. terraform.tfvars파일에서 변수 설정

2. terraform apply

```sh
terraform init
terraform apply
```

# 삭제 방법

```sh
terraform destroy
```

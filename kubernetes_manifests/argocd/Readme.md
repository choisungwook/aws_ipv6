<!-- TOC -->

- [개요](#%EA%B0%9C%EC%9A%94)
- [설치 방법](#%EC%84%A4%EC%B9%98-%EB%B0%A9%EB%B2%95)
- [argocd-server 접속 방법](#argocd-server-%EC%A0%91%EC%86%8D-%EB%B0%A9%EB%B2%95)
- [admin 비밀번호 조회](#admin-%EB%B9%84%EB%B0%80%EB%B2%88%ED%98%B8-%EC%A1%B0%ED%9A%8C)
- [삭제 방법](#%EC%82%AD%EC%A0%9C-%EB%B0%A9%EB%B2%95)

<!-- /TOC -->

# 개요
* kustomize로 argocd 설치

<br />

# 설치 방법
* ArgoCD manifest 설치
```bash
kubectl kustomize ./ | kubectl apply -f -
```

* ingress 설정 수정 후 ingress 배포

```sh
vi ingress.yaml
kubectl apply -f ingress.yaml
```

<br />

# argocd-server 접속 방법

> Warning: ALB controller가 설치되어 있어야 ingress를 생성할 수 있습니다. ALB controller 설치는 [](../bootstraps/argocd_applications/alb-controller-application.yaml)를 참고해주세요

* ingress에 설정한 host로 접속


<br />

# admin 비밀번호 조회
```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

# 삭제 방법

> Warning: 꼭 삭제 순서를 지켜주세요

* ArgoCD ingress 삭제

```sh
kubectl delete -f ingress.yaml
```

* ArgoCD Application 삭제

```sh
# 1. 조회
kubectl get application -n argocd

# 2. 조회한 applicatino 삭제
kubectl delete application {application 이름} -n argocd
```

* ArgoCD manifest 삭제

```sh
kubectl kustomize ./ | kubectl delete -f -
```

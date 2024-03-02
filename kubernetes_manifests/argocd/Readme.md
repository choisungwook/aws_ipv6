# 개요
* kustomize로 argocd 설치

<br />

# 설치 방법
* kustomize 설치 방법
```bash
kubectl kustomize ./ | kubectl apply -f -
```

<br />

# argocd-server 접속 방법

<br />

# admin 비밀번호 조회
```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

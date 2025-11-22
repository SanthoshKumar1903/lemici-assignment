# DevOps Internship Assignment

**Candidate:** Santhosh Kumar  
**Repo:** https://github.com/SanthoshKumar1903/lemici-assignment

---

## Part 1: Version Control (Git & SSH)

### SSH Setup

- Generated SSH key for GitHub authentication:
```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_github -C "mmsanthosh.02@gmail.com"
```
- Added public key to GitHub Settings → SSH and GPG keys
- Tested authentication:
```bash
ssh -T git@github.com
```

Output: `Hi SanthoshKumar1903! You've successfully authenticated`

### Git Fetch vs Git Pull

- **git fetch:** Downloads changes from remote but doesn't merge. You can review changes before merging manually.
- **git pull:** Fetches and automatically merges into current branch (fetch + merge in one command).

### Merge Conflict Resolution

- Created two branches: `feature-A` and `feature-B`
- Modified the same line in README.md differently on each branch
- Merged `feature-A` into main → no conflict
- Merged `feature-B` into main → conflict occurred
- Manually resolved by editing the file, removing conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)
- Staged and committed the resolved file

**Commands used:**
```bash
git checkout -b feature-A
# Made changes and committed
git checkout main
git merge feature-A

git checkout -b feature-B
# Made conflicting changes and committed
git checkout main
git merge feature-B
# Conflict appeared, resolved manually
git add README.md
git commit -m "Resolve merge conflict"
```

---

## Part 2: Docker & Containerization

### App

- Simple Flask app (`app.py`) that returns "Hello from DevOps Flask App"
- Dockerfile included in repo

### Key Terms

- **Dockerfile:** Instructions to build a Docker image (like a recipe)
- **Docker image:** Built package containing app code, dependencies, and runtime (read-only)
- **Docker container:** Running instance of an image (isolated process)

### Dockerfile Security

- Added **non-root user** for security:
```dockerfile
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser
USER appuser
```

This prevents container from running as root, reducing security risks.

### Reduce Image Size

- Use slim base images (`python:3.11-slim` instead of full `python:3.11`)
- Multi-stage builds (separate build and runtime stages)
- Install packages with `--no-cache-dir`
- Add `.dockerignore` to exclude unnecessary files
- Combine RUN commands to reduce layers

### Build and Push

```bash
docker build -t flask-app:v1 .
docker run -d -p 8080:8080 flask-app:v1
docker tag flask-app:v1 santhoshkumarmm/flask-app:v1
docker push santhoshkumarmm/flask-app:v1
```

Image available at: `santhoshkumarmm/flask-app:v1`

---

## Part 3: Kubernetes (EKS Basics)

### Concepts

- **Pod:** Smallest unit in Kubernetes. Contains one or more containers sharing network and storage.
- **Deployment:** Manages pods and replicas. Handles rolling updates and self-healing.
- **Service:** Provides stable network endpoint to access pods. Types:
  - `ClusterIP` — internal only
  - `NodePort` — external via node port
  - `LoadBalancer` — external via cloud load balancer

### Why EKS?

- AWS manages control plane (master nodes)
- Automated upgrades and patching
- Native AWS integration (IAM, VPC, CloudWatch)
- High availability built-in
- Less operational overhead than self-managed Kubernetes

### Kubernetes YAML

Created `k8s.yaml` with:
- Deployment with 2 replicas
- NodePort service exposing port 8080

```bash
kubectl apply -f k8s.yaml
kubectl get pods
kubectl get svc
```

Tested locally with Minikube.

---

## Part 4: CI/CD Pipeline

### GitHub Actions Workflow

Created `.github/workflows/ci-cd.yml` that:
1. Checks out code
2. Sets up Python 3.11
3. Installs Flask
4. Runs tests (simulated)
5. Builds Docker image
6. Simulates Docker push (as allowed by assignment)

---

## Part 5: Monitoring & Logs

### Metrics vs Logs vs Traces

- **Metrics:** Numbers over time (CPU, memory, request count). Used for alerts and dashboards.
- **Logs:** Text records of events. Used for debugging errors.
- **Traces:** Request path across services. Used for performance analysis.

### Debugging a Crashed Pod

```bash
kubectl get pods
kubectl describe pod <pod-name>
kubectl logs <pod-name>
kubectl logs <pod-name> --previous
kubectl exec -it <pod-name> -- /bin/sh
kubectl get events
```

### Monitoring Tools

- **Prometheus + Grafana:** Metrics collection and visualization
- **CloudWatch:** AWS-native monitoring for EKS
- **ELK Stack:** Centralized logging (Elasticsearch, Logstash, Kibana)
- **AWS X-Ray:** Distributed tracing for microservices

---

## Part 6: Problem-Solving Scenario

**Task:** Deploy a new microservice to AWS EKS with logging for dev team.

**Approach:**

1. **Containerize the app**
   - Write Dockerfile
   - Build and test locally

2. **Push to registry**
   - Push image to DockerHub or AWS ECR

3. **Create Kubernetes manifests**
   - Write deployment.yaml (with replicas)
   - Write service.yaml (ClusterIP or LoadBalancer)

4. **Set up CI/CD**
   - GitHub Actions workflow to build, push, and deploy
   - Use `kubectl apply` or `kubectl set image` to update deployment

5. **Configure logging**
   - Use CloudWatch Container Insights (easiest for EKS)
   - Or deploy Fluentd DaemonSet to ship logs to CloudWatch
   - Give dev team IAM access to CloudWatch Logs

---

## What I Completed

- ✅ SSH authentication with GitHub
- ✅ Git branching and merge conflict resolution
- ✅ Dockerfile with non-root user security
- ✅ Built and pushed Docker image to DockerHub
- ✅ Kubernetes deployment and service YAML
- ✅ Tested deployment with Minikube
- ✅ GitHub Actions CI/CD pipeline
- ✅ Documented monitoring and deployment approach

---

## Screenshots

Added my screesnshots in screenshots/ folder
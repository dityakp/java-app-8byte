# Docker Hub Setup Instructions

## 🔑 Configure GitHub Secrets for Docker Hub Push

To enable automatic Docker Hub push, follow these steps:

### Step 1: Get Docker Hub Access Token

1. Go to [Docker Hub](https://hub.docker.com/)
2. Log in with your account (`dityakp`)
3. Click your avatar → **Account Settings**
4. Click **Security** → **New Access Token**
5. Give it a name (e.g., "GitHub Actions")
6. Click **Generate** and copy the token

### Step 2: Add GitHub Secrets

1. Go to your GitHub repository: https://github.com/dityakp/java-app-8byte
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**

Add these two secrets:

**Secret 1:**
- Name: `DOCKER_USERNAME`
- Value: `dityakp`

**Secret 2:**
- Name: `DOCKER_PASSWORD`
- Value: `<your Docker Hub access token from Step 1>`

### Step 3: Push Updated Workflow

```bash
cd c:\Victus-D\Project\8byte-devops-intern-assignment
git add .github/workflows/ci.yml
git commit -m "Fix Docker Hub push configuration"
git push
```

### Step 4: Trigger the Workflow

Either:
- Make a commit and push to `main` branch, OR
- Go to GitHub → Actions → CI - Docker Build and Push → Run workflow

### Expected Result

After configuration, the CI pipeline will:
1. ✅ Build Docker image
2. ✅ Verify build
3. ✅ Test container
4. ✅ Login to Docker Hub
5. ✅ Push to `dityakp/8byte-intern-app:latest`
6. ✅ Push to `dityakp/8byte-intern-app:<commit-sha>`

Your Docker image will be available at:
**https://hub.docker.com/r/dityakp/8byte-intern-app**

---

## 🔍 What I Fixed

1. **Repository Name**: Changed from `${{ secrets.DOCKER_USERNAME }}/8byte-intern-app` to `dityakp/8byte-intern-app` (hardcoded your username)
2. **Secret Check**: Added condition to only run Docker Hub steps if secrets are configured
3. **Error Handling**: Kept `continue-on-error: true` so the workflow doesn't fail if Docker Hub push is skipped

---

## ✅ Verification

After pushing the updated workflow and configuring secrets:

1. Check GitHub Actions tab for successful workflow run
2. Visit https://hub.docker.com/r/dityakp/8byte-intern-app to see your image
3. Pull and test: `docker pull dityakp/8byte-intern-app:latest`

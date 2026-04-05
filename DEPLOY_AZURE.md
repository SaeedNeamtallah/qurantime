# Azure Deployment Guide (Backend + Frontend)

This repository is prepared for deploying to two Azure App Services.

## 1) Backend App Service (Python)

Create a Linux Web App with runtime stack Python 3.11.

### Backend Startup Command

Use one of the following in Azure App Service Configuration > General Settings > Startup Command:

```bash
bash startup.sh
```

or directly:

```bash
gunicorn -k uvicorn.workers.UvicornWorker -w 2 --timeout 120 --bind=0.0.0.0:$PORT main:app
```

### Backend App Settings

Set these values in backend App Service Configuration > Application settings:

- `SCM_DO_BUILD_DURING_DEPLOYMENT=true`
- `CLIENT_ID=...`
- `CLIENT_SECRET=...`
- `OAUTH_ENDPOINT=https://oauth2.quran.foundation`
- `GOOGLE_AI_API_KEY=...` (optional)
- `GOOGLE_TAFSIR_ENHANCE_MODEL=gemma-3-27b-it`
- `GROQ_API_KEY=...` (optional)
- `GROQ_TAFSIR_ENHANCE_MODEL=llama-3.3-70b-versatile`
- `TAFSIR_ENHANCE_PROVIDER=auto`
- `TAFSIR_ENHANCE_SHARED_SECRET=strong-random-secret`
- `TAFSIR_ENHANCE_REQUIRE_LOOPBACK=true`
- `TAFSIR_ENHANCE_MAX_TEXT_LENGTH=12000`
- `TAFSIR_ENHANCE_RATE_LIMIT_WINDOW_SECONDS=60`
- `TAFSIR_ENHANCE_RATE_LIMIT_MAX_REQUESTS=8`

## 2) Frontend App Service (Node)

Create a Linux Web App with runtime stack Node 20 LTS.

### Frontend Startup Command

Use one of the following in Azure App Service Configuration > General Settings > Startup Command:

```bash
bash startup.sh
```

or directly:

```bash
npm run start -- --hostname 0.0.0.0 --port $PORT
```

### Frontend App Settings

Set these values in frontend App Service Configuration > Application settings:

- `SCM_DO_BUILD_DURING_DEPLOYMENT=true`
- `FASTAPI_BASE_URL=https://<your-backend-app>.azurewebsites.net`
- `TAFSIR_ENHANCE_SHARED_SECRET=strong-random-secret` (same backend value)
- `TAFSIR_ENHANCE_MAX_TEXT_LENGTH=12000`
- `TAFSIR_ENHANCE_RATE_LIMIT_WINDOW_SECONDS=60`
- `TAFSIR_ENHANCE_RATE_LIMIT_MAX_REQUESTS=8`
- `NEXT_PUBLIC_SITE_URL=https://<your-frontend-app>.azurewebsites.net`
- `SITE_URL=https://<your-frontend-app>.azurewebsites.net`
- `GOOGLE_SITE_VERIFICATION=` (optional)
- `BING_SITE_VERIFICATION=` (optional)

## 3) Deploy Using GitHub Actions

1. Create the four GitHub secrets listed in the root README.
2. Push to `main` branch.
3. Workflows deploy automatically based on changed paths:
   - backend changes trigger backend workflow
   - frontend changes trigger frontend workflow

## 4) Post-Deploy Checks

Backend health check:

- `GET https://<backend>/api/status`

Frontend health check:

- `GET https://<frontend>/api/status`
- Open `https://<frontend>/reader/page`

If frontend reports backend unavailable, verify `FASTAPI_BASE_URL` and backend app state.

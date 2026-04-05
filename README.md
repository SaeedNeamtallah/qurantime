# qurantime

qurantime is a dual-service Quran app prepared for Azure App Service deployment:

- backend: FastAPI API service
- frontend: Next.js web app service

## Repository Layout

- `backend/` FastAPI service (`main.py`, `requirements.txt`, `quran_offline.json`)
- `frontend/` Next.js app (`package.json`, `src/`, `quran_offline.json`)
- `.github/workflows/` CI/CD workflows for backend and frontend App Services

## Local Run

Prerequisites:

- Python 3.11+
- Node.js 20+

### Backend

```bash
cd backend
python -m pip install -r requirements.txt
python -m uvicorn main:app --reload --host 127.0.0.1 --port 8080
```

### Frontend

```bash
cd frontend
npm install
npm run dev -- --hostname 127.0.0.1 --port 3000
```

## Azure App Service Deployment

Use two separate App Services:

- App Service 1: backend (Python)
- App Service 2: frontend (Node)

Detailed steps are in `DEPLOY_AZURE.md`.

## GitHub Actions Workflows

- `.github/workflows/deploy-backend-appservice.yml`
- `.github/workflows/deploy-frontend-appservice.yml`

Required GitHub repository secrets:

- `AZURE_BACKEND_APP_NAME`
- `AZURE_BACKEND_PUBLISH_PROFILE`
- `AZURE_FRONTEND_APP_NAME`
- `AZURE_FRONTEND_APP_PUBLISH_PROFILE`

## Notes

- Backend persistence file (`backend/state.json`) is intentionally git-ignored.
- Frontend includes its own `quran_offline.json` so standalone frontend App Service can still serve offline fallback endpoints.
- Set production site URL in frontend App Settings for correct canonical, robots, and sitemap metadata.

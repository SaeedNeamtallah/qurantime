@echo off
setlocal

set "ROOT=%~dp0"

start "qurantime-backend" cmd /k "cd /d %ROOT%backend && python -m uvicorn main:app --reload --host 127.0.0.1 --port 8080"
start "qurantime-frontend" cmd /k "cd /d %ROOT%frontend && npm run dev -- --hostname 127.0.0.1 --port 3000"

echo Backend:  http://127.0.0.1:8080
echo Frontend: http://127.0.0.1:3000

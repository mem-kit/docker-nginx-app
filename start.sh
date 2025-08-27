#!/bin/bash
set -e

# Start nginx in the background (with custom config)
nginx -g 'daemon off;' &

# Start the FastAPI application using uvicorn in production mode
exec uvicorn api:app --host 0.0.0.0 --port 7860
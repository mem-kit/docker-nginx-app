# docker-nginx-app

When we deploy the docker image into Azure AKS with sharing ingress and DNS domain, we need to use the sub-path or context-path.

If the app doesn't have the context-path and it is difficult to update/modify this app, we can use the nginx to redirect the requests into app root-path.

In this example, we have a demo application with root path '/' in it, which like this

 - http://127.0.0.1:7860

In the nginx.conf, it accepts the context path 'agent-flow' and redirect to localhost:8880/

 - localhost:8880/agent-flow

## Test api.py

pip install -r requirments.txt
python api.py

open it with root path: http://localhost:7860/health

## Build DockerImage

docker build . -t mcp/langflow

docker run -d -p 8880:8880 mcp/langflow

open it with context path: http://localhost:8880/agent-flow/health



# Job 9 - Build + Sonar + Push to Docker Hub

## Summary
- Build project with Maven
- Sonar analysis + Quality Gate
- Build Docker image using Dockerfile in repository root
- Push image to Docker Hub using credentials id 'dockerhub-login'

## Jenkins prerequisites
- Jenkins node running Docker (agent must have docker CLI & permissions)
- Jenkins Credentials: usernamePassword with id 'dockerhub-login'
- Tools: MAVEN3, OracleJDK17, sonar4.7
- Plugins: "Docker Pipeline" optional, but not mandatory if using shell docker commands

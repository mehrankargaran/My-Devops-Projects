# Job 3 — SonarQube Integration

## Overview
This pipeline extends the basic Maven build by adding static code analysis with SonarQube.

## Prerequisites
- SonarQube server up and running (e.g. `http://192.168.2.28:9000`)
- Token created via SonarQube → My Account → Security
- Add token in Jenkins credentials (ID: `MySonarToken`)
- Configure SonarQube server in Jenkins:
	Manage Jenkins → Configure System → SonarQube servers

## Jenkinsfile Highlights
- Includes `withSonarQubeEnv('sonar')`
- Runs:
	mvn clean install
	mvn sonar:sonar -Dsonar.projectKey=vprofile

## Script Path
	job3-sonarqube/Jenkinsfile

# Job 8 - Build + Sonar + Upload to Nexus

## Summary
- Clone project
- Build with Maven (skip tests in packaging)
- Run tests
- Checkstyle
- SonarQube analysis + wait for Quality Gate
- Upload WAR to Nexus repository (vprofile-repo)

## Jenkins prerequisites
- Tools: MAVEN3, OracleJDK17 configured in Manage Jenkins -> Global Tool Configuration
- SonarQube server added in Manage Jenkins -> Configure System (name 'sonar') + webhook optional
- Nexus credentials stored in Jenkins with id 'nexuslogin'
- Plugin: "Nexus Artifact Uploader" installed

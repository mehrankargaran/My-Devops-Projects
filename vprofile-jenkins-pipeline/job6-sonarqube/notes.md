# Job 6 — Build, Test, and SonarQube Analysis

**Purpose:**  
To integrate SonarQube with Jenkins Pipeline for code quality and static analysis.

---

## Prerequisites

Before running this job:

1. SonarQube server must be running, e.g., `http://192.168.2.28:9000`
2. Create a SonarQube **token**:  
   `My Account → Security → Generate Token`
3. Add the token in Jenkins:  
   `Manage Jenkins → Credentials → Global → Add Credentials`
   - **Kind:** Secret text  
   - **Secret:** (paste the token)  
   - **ID:** `MySonarToken`
4. In Jenkins → `Manage Jenkins → Configure System` → SonarQube servers:  
   - **Name:** `sonar`  
   - **Server URL:** `http://192.168.2.28:9000`  
   - **Server authentication token:** Use `MySonarToken`
5. Configure tools:  
   - **JDK:** OracleJDK17  
   - **Maven:** MAVEN3  
   - **SonarQube Scanner:** sonar4.7

---

## Jenkins Pipeline Setup

1. In Jenkins → **New Item** → **Pipeline**  
   Name it `job6-sonarqube-analysis`.
2. Set **Pipeline Definition** → `Pipeline script from SCM`.
3. **SCM:** Git  
   - **Repository URL:** `https://github.com/mehrankargaran/vprofile-jenkins-pipeline.git`
   - **Script Path:** `job6-sonarqube-analysis/Jenkinsfile`
4. Save → Build Now.

---

## Jenkinsfile Summary

**Main Stages:**
1. **Fetch code** → Clones repository.  
2. **Create pom.xml** → Generates the required POM with Java 17 compatibility.  
3. **Build** → Compiles project and creates `.war` artifact.  
4. **Test** → Runs Maven tests.  
5. **Checkstyle Analysis** → Performs static analysis.  
6. **Sonar Analysis** → Sends results to SonarQube via scanner.  

**Post actions:**
- Displays status messages for success or failure.

---

## Expected Output
- Build success with `.war` artifact archived.  
- SonarQube dashboard updated with new project metrics.  
- Checkstyle and test reports visible under the Jenkins workspace.

---

## Troubleshooting Tips
- Verify `scannerHome` tool name matches the one in Jenkins tool config.
- If analysis fails, check Jenkins logs for missing plugins or incorrect paths.
- Confirm `MySonarToken` credentials ID matches in both Jenkins and the pipeline file.

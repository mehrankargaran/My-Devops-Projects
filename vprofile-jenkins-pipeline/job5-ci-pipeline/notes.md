# Job 5 — Build and Test CI Pipeline with Maven

**Purpose:**  
To implement the Continuous Integration (CI) part of the project using Jenkins Pipeline as Code.

---

## Jenkins Pipeline Setup

1. In Jenkins → **New Item** → **Pipeline**  
   Name it `job5-ci-pipeline`.
2. In **Pipeline Definition**, select:  
   `Pipeline script from SCM`
3. Set:
   - **SCM:** Git  
     **Repository URL:** `https://github.com/mehrankargaran/vprofile-jenkins-pipeline.git`
   - **Script Path:** `job5-ci-pipeline/Jenkinsfile`
4. Save → Build Now.

---

## Jenkinsfile Overview

**Location:** `job5-ci-pipeline/Jenkinsfile`

**Stages:**
1. **Fetch code** — Clones the project from GitHub.  
2. **Build** — Runs `mvn clean install -DskipTests` to compile and package the code.  
3. **Test** — Executes unit tests using `mvn test`.  
4. **Checkstyle Analysis** — Runs static code analysis using Checkstyle.

**Tools Used:**
- Maven: `MAVEN3`  
- JDK: `OracleJDK17`

---

## Expected Output
- Successful build and test results in Jenkins console logs.
- Generated `.war` file archived automatically.
- Static analysis reports (Checkstyle) generated under `target/checkstyle-result.xml`.

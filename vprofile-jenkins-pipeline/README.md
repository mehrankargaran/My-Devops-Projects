# vprofile-jenkins-pipeline

This repository contains Jenkinsfiles and notes for CI/CD jobs for the **vprofile** project.  
It covers the continuous integration (CI) stages from simple Linux command execution up to SonarQube code analysis and Docker image build/push.

---

## 🧱 Job Overview

| Job | Name | Description |
|-----|------|--------------|
| 1 | `job1-linux-commands` | Runs basic Linux commands on Jenkins node (pwd, id, whoami) |
| 2 | `job2-git-maven-build` | Fetches the vprofile source code from GitHub and builds with Maven |
| 3 | `job3-maven-archiving` | Builds and archives `.war` artifacts |
| 4 | `job4-versioning` | Builds and versions the WAR file using BUILD_ID and timestamp |
| 5 | `job5-ci-pipeline` | Full CI pipeline: Build, Test, and Checkstyle analysis |
| 6 | `job6-sonarqube` | Extends CI pipeline with SonarQube static code analysis |
| 8 | `job8-maven-build` | Build + SonarQube + Upload to Nexus repository |
| 9 | `job9-sonarqube` | Build + SonarQube + Docker image build + Push to Docker Hub |
| 10 | `job10-local-registry` | Build + SonarQube + Push to local Docker registry |

---

## ⚙️ Tools and Technologies Used

- **Jenkins** — CI/CD automation server  
- **Maven** — Build automation tool  
- **JDK 8 / 11 / 17** — Different versions used per job  
- **SonarQube** — Code quality and security scanner  
- **GitHub** — Source code management  
- **Docker & Nexus** — Image and artifact storage (used in later stages)

---

## 📦 Repository Structure

vprofile-jenkins-pipeline/
│
├── job1-run-linux-commands/
│   ├── Jenkinsfile
│   └── README.md
│
├── job2-maven-build/
│   ├── Jenkinsfile
│   └── README.md
│
├── job3-sonarqube/
│   ├── Jenkinsfile
│   └── README.md
│
├── job8-maven-build/
│   ├── Jenkinsfile
│   └── notes.md
│
├── job9-sonarqube/
│   ├── Jenkinsfile
│   └── notes.md
│
├── job10-local-registry/
│   ├── Jenkinsfile
│   └── notes.md
│
├── .gitignore
└── README.md

## 🧱 Prerequisites

Before running any pipeline, make sure you have:

- Jenkins installed and running (v2.440+ recommended)
- Maven configured (`MAVEN3`)
- JDK configured (`OracleJDK8`)
- SonarQube server running (for jobs 3, 8, 9, 10)
- Nexus or Docker Registry configured depending on the job
- GitHub repository accessible by Jenkins

---

## 🔐 Credentials Required in Jenkins

| ID | Type | Description |
|----|------|--------------|
| **MySonarToken** | Secret Text | SonarQube authentication token |
| **dockerhub-creds** | Username/Password | DockerHub credentials |
| **nexus-creds** | Username/Password | Nexus repository credentials |

To add them:
	Jenkins → Dashboard → Manage Jenkins → Credentials → Global → Add Credentials
---

## 🧩 Pipeline Overview

Each Jenkinsfile in this repository follows a declarative pipeline syntax with multiple stages, such as:

- **Fetch code** → Pull latest code from GitHub  
- **Build** → Compile and package using Maven  
- **Test** → Run unit tests  
- **Checkstyle Analysis** → Run static code check  
- **SonarQube Analysis** → Perform quality scan  
- **Docker Build/Push** → Build Docker image and push to Hub or local registry  

---

## ⚙️ Example Usage

To use one of these pipelines:

1. In Jenkins → “New Item” → select **Pipeline**
2. Set the name (e.g. `job9-sonarqube`)
3. Choose **Pipeline script from SCM**
4. Select “Git” and enter your repository URL:
	https://github.com/mehrankargaran/vprofile-jenkins-pipeline.git
5. Set **Script Path** according to the job folder, e.g.:
	job9-sonarqube/Jenkinsfile
6. Save and build the job.

---

## 🧠 Notes

Each job folder includes a `notes.md` file with step-by-step explanations and configuration details specific to that job.  
Please check those files before running the pipelines to match your environment settings (IP addresses, credentials, etc.).

---

## 🧑‍💻 Author

**Mehran Kargaran**  
DevOps Practice Exercises — Jenkins CI/CD for vprofile project  
GitHub: [mehrankargaran](https://github.com/mehrankargaran)

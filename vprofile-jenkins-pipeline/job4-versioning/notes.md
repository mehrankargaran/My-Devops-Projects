# Job 4 — Build, Archive, and Version with Maven

**Purpose:**  
To build the project with Maven, archive the generated `.war` file, and create versioned artifacts using Jenkins environment variables.

---

## Jenkins Job Setup

1. In Jenkins, create a **Freestyle Project** named `job4-maven-archiving-versioning`.
2. Under **Source Code Management**, select **Git** and set:  
   - **Repository URL:** `https://github.com/mehrankargaran/vprofile`
   - **Branch Specifier:** `*/main`
3. Under **Build Environment**, make sure JDK and Maven are configured (e.g. JDK 17 and Maven 3).
4. Under **Build** → **Execute Shell**, add the following:

```bash
# Create versions directory and copy the WAR file with build ID and timestamp
mkdir -p versions

# If build timestamp plugin is installed, use BUILD_TIMESTAMP
# Otherwise, generate one with date
export BUILD_TIMESTAMP=$(date +%y-%m-%d_%H%M)

# Copy the WAR file to the versions folder with version name
cp target/*.war versions/vprofile-V${BUILD_ID}-${BUILD_TIMESTAMP}.war

# List files to verify
ls -l versions

5. Under Post-build Actions, enable:
	Archive the artifacts → Files to archive: **/*.war
6. Save → Build Now.
---
Expected Output

The job will compile and package the project.

The versions directory will contain a uniquely named .war file:

vprofile-V23-10-24_1215.war


The archived artifact will be available in the Jenkins build history.

Job 1 — Run Linux Commands Local

#Purpose:

To test running simple Linux commands inside the Jenkins environment (to verify the workspace and user context).

#Jenkinsfile:

	Location: job1-run-linux-commands/Jenkinsfile

#Pipeline stages:

Run Linux commands: executes whoami, pwd, id, and ls -la

#How to use:

In Jenkins → New Item → choose Pipeline

Enter a name, for example: job1-linux-commands

Under Pipeline → Definition, select Pipeline script from SCM

#SCM: Git

#Repository URL: 
	https://github.com/mehrankargaran/vprofile-jenkins-pipeline

#Script Path:
	 job1-linux-commands/Jenkinsfile

Click Save → then Build Now

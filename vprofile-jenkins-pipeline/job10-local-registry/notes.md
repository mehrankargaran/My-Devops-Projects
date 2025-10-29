# Job 10 - Build + Sonar + Push to Local Docker Registry

## Summary
- Same as Job9 but pushes images to a local registry (192.168.2.29:5000)
- Useful to keep images inside lab network

## Jenkins prerequisites
- Local registry running at 192.168.2.29:5000 (docker registry)
- Jenkins agent with docker CLI & permission to push to that registry
- Tools: MAVEN3, OracleJDK17, sonar4.7

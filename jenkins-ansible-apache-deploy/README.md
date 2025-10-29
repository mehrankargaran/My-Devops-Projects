# Jenkins + Ansible: Apache Deployment

This project demonstrates how to integrate **Jenkins** and **Ansible** to automatically install and start the Apache web server on a remote Ubuntu VM.

---

## 🧱 Architecture
- **Jenkins Server** → 192.168.2.25  
- **Target Server (Web)** → 192.168.2.26  

Jenkins runs an Ansible playbook that connects via SSH to the target server, installs Apache, and starts the service.

---

## ⚙️ Steps
1. Install Jenkins and Ansible on the controller (192.168.2.25)
2. Generate SSH keys for Jenkins user
3. Copy the public key to the target VM
4. Add sudo permission for Ansible tasks
5. Create the playbook (`ansible/playbook.yml`)
6. Create Jenkins freestyle job to execute:
   ```bash
   ansible-playbook -i ansible/hosts ansible/playbook.yml
7. Run the job and verify Apache service is running

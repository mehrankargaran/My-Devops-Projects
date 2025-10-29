## `remote/README.md`

```markdown
# Remote Nginx Installation

This folder contains files for **installing Nginx on remote VMs**.

### Files:

- `main.tf` → Terraform script using remote-exec and file provisioner  
- `install_nginx.sh` → Bash script to create the custom site and configure Nginx  

### Running Terraform:

```bash
cd remote
terraform init
terraform apply -auto-approve
Verifying Installation (Optional):
bash
Copy code
ssh mehran@192.168.2.119
systemctl status nginx
curl http://192.168.2.119:8080
exit

ssh mehran@192.168.2.120
systemctl status nginx
curl http://192.168.2.120:8080
exit
The custom HTML page should appear on both VMs.

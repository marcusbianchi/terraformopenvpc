# terraformopenvpc
Sample to create an AWS infrastructure to with an OpenVPC server

Installation
The infrastructure will be created on AWS Ec2 instance, using Terraform. This instance will use a AMI that already contains the OpenVPC software configured.

Prerequisites

Required software:

AWS CLI (https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
Terraform (https://learn.hashicorp.com/terraform/getting-started/install.html)
AWS credentials configured properly (https://www.terraform.io/docs/providers/aws/index.html)
Sample Infrastructure
This example will set the following resources:

1 - AWS VPC
3 - AWS Subnets on different subregions
1 - Internet Gateway
1 - EC2 Instance with OpenVPN AMI installed with public IP
Clone Repository:

git clone https://gitlab.gerdau.digital/industrial/cratedb.git
 
cd cratedb
Execute init command

terraform init
Start the Infrastructure

terraform plan -out "planfile"
Review the Plan of Execution BEFORE executing it

To execute the changes
```bash
terraform apply -input=false "planfile"
```
The command will show the public IP of the virtual Machine to SSH into.
```bash
Apply complete!
 
Resources: 3 added, 0 changed, 0 destroyed.
 
Outputs: public_address = 52.202.242.162
```
SSH to the host using the openvpnas login and the key used in the configuration:
```bash
ssh -i <key>.pem openvpnas@<public_address>
```
OpenVPN AS running  ovpn-init:
```bash
sudo ovpn-init --ec2
```
For the first setup answer the questions as bellow, but first write DELETE to erase the default config:
- Will this be the primary Access Server node?  yes
- Please specify the network interface and IP address to be used by the Admin Web UI: 1
- Please specify the port number for the Admin Web UI. 943
- Please specify the TCP port number for the OpenVPN Daemon 443
- Should client traffic be routed by default through the VPN? no
- Should client DNS traffic be routed by default through the VPN? no
- Use local authentication via internal DB?  yes
- Private subnets detected: [‘10.0.9.0/24’] Should private subnets be accessible to clients by default? yes
- Do you wish to login to the Admin UI as “openvpn”? yes
- > Please specify your OpenVPN-AS license key (or leave blank to specify later): leave blank
Set the openvpn user ‘s password
```bash
sudo passwd openvpn
Enter new UNIX password:
Retype new UNIX password:
passwd: password updated successfully
```
Now you can open your admin page using EIP created before – https://<public_address>:943/adminin this case.
# HelloAWS

I play with AWS on this repository

## Log

### 2021/10/28

I created a server referring to [a video](https://www.youtube.com/watch?v=HvrIPQ77xRY).

#### Create a VPC and subnet

- Go to [AWS](https://aws.amazon.com).
- Sign in console.
- "Service", "Networking and content delivery", "VPC"
- "Start VPC wizard"
- "Choose"
- Set private IPv4 CIDR `192.168.0.0/24`
- Set VPC name `HelloAWS`
- Set public subnet IPv4 CIDR `192.168.0.0/25` (So, `192.168.0.128/25` is reserved for private subnet.)
- Set availability zone `ap-northeast-1a`
- Set public subnet name `PublicSubnet`
- Don't add service endpoint
- Enable DNS host name
- Set hardware tenancy default
- Create a VPC

#### Create internet gateway

- "Internet gateway"
- "Create an internet gateway"
- Set internet gateway name `InternetGateway`
- "Action", "Attach to a VPN"

Then, "VPC not found" even though I certainly created a VPC.
So, I withheld the problem and went to the next step.

#### Create a EC2

- "Service", "Computing", "EC2"
- "Instance"
- "Start a instance"
- Set machine image `Amazon Linuz x86-64`
- Set instance type `t2.micro`
- "Next step: Determine instance details"
- Set number of instance `1`
- No spot instance request
- Locate the EC2 on the subnet `PublicSubnet` in the VPC `HelloAWS`
- Enable public IP automatic assignment
- Add a storage
- "Next step: Add tags"

| Key  | Value    |
| ---- | -------- |
| Name | HelloAWS |

- "Next step: Set a security group"
- Set the security group name `SecurityGroup`
- Set the secyrity group description `security group for HelloAWS`

| type | protocol | port range | source    | destination       |
| ---- | -------- | ---------- | --------- | ----------------- |
| SSH  | TCP      | 22         | 0.0.0.0/0 | SSH for HelloAWS  |
| HTTP | TCP      | 80         | 0.0.0.0/0 | HTTP for HelloAWS |

- "Check and create"
- "Start"
- "Create a new key pair"
- Set the key pair type RSA
- Set the key pair name `KeyPair`
- "Download the key pair"

Then, I kept the private key `KeyPair.pem` on my private repository.

- "Create an instance"
- "Display the instance"

#### Create a route table

- "Service", "Networking and content delivery", "VPC"
- "Route table"
- "Create a route table"
- Set the route table name `RouteTable`
- Deploy the route table on the VPC `HelloAWS`
- "Edit routes"

Then, an internet gateway was needed.
I guessed that another internet gateway is already attached to the VPC.
So, I tried to delete all internet gateways and create a new internet gateway.
After deleting, I found that a new nameless internet gateway attached to the VPC is automatically created.
So, I named the internet gateway `InternetGateway`.

- Choose the internet gateway
- "Action", "Manage tags", "Add a new tag"

| Key  | Value           |
| ---- | --------------- |
| Name | InternetGateway |

- Choose the route table `RouteTable`
- "Action", "Edit routes"

| Destination    | Target                             | Status | propagated |
| -------------- | ---------------------------------- | ------ | ---------- |
| 192.168.0.0/24 | local                              | active | no         |
| 0.0.0.0/0      | Internet Gateway `InternetGateway` | -      | no         |

- Save the routes
- "Connect with a subnet", "Edit connection with a subnet"
- Choose the subnet `PublicSubnet`
- Save the connection

#### Connect with the EC2 by SSH

- "Service", "Computing", "EC2"

I confirmed that the EC2's public IPv4 address is 54.250.198.82.
I succeeded in connecting to the EC2 with following command.

```
> ssh -i <private key> ec2-user@54.250.198.82
```

And I added following lines to `%HOMEDRIVE%%HOMEPATH%\.ssh\config` on a windows host.

```
Host 54.250.198.82
	HostName 54.250.198.82
	IdentityFile ~/.ssh/AWS/KeyPair.pem
	User ec2-user
```

Now, I can connect to the EC2 with following command.

```
> ssh 54.250.198.82
```

### 2021/10/30

#### Implement `make login`

I wrote following `Makefile`.

```
SERVER = 54.250.198.82
SSH = ssh

login:
	$(SSH) $(SERVER)

```

Now, I can connect to the EC2 with following command.

```
> make login
```

I can't enter the server through `make login` even though I can do `ssh` directly.
Specifically, `make` can't find `C:\Windows\System32\OpenSSH\ssh.exe`.
I think this problem is because of Windows default 32bit ssh (in my case `C:\Windows\System32\OpenSSH\ssh.exe`).
So, I installed [OpenSSH-Win64](https://github.com/PowerShell/Win32-OpenSSH/releases) and it worked well.

#### Clone this repository on the EC2

I entered the server and install git by following commands.

```
> make login
$ sudo yum update -y
$ sudo yum install git -y
```

And I returned to the windows host in order to deploy ssh configuration and private keys from the windows host.

```
$ exit
> scp %HOMEDRIVE%%HOMEPATH%\.ssh\config ec2-user@54.250.198.82:~/.ssh
> scp -r %HOMEDRIVE%%HOMEPATH%\.ssh\AWS ec2-user@54.250.198.82:~/.ssh
> scp -r %HOMEDRIVE%%HOMEPATH%\.ssh\GitHub ec2-user@54.250.198.82:~/.ssh
```

I entered the server again and set access rights of the configuration and private keys.

```
> make login
$ chmod 600 ~/.ssh/config
$ chmod 600 ~/.ssh/AWS/KeyPair.pem
$ chmod 600 ~/.ssh/GitHub/github
```

Then I cloned this repository on the server.

```
$ cd ~
$ git clone git@github.com:TaiseiIto/HelloAWS.git
```

Finally, I initialized git configuration

```
$ ~/HelloAWS/git/initconfig.sh
```


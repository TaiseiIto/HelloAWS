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
- "Next step: determine instance details"
- Set number of instance `1`
- No spot instance request
- Locate the EC2 on the subnet `PublicSubnet` in the VPC `HelloAWS`
- Enable public IP automatic assignment
- Add a storage
- "Next step: add tags"

| Key  | Value    |
| ---- | -------- |
| Name | HelloAWS |

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


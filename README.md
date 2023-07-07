# 3-tier-AWS-Architecture
This is a 3-tier AWS Architecture consisting of a web layer, application layer and data layer
The web layer consists of an application load balancer present in a public subnet.
The application layer consists of a group of autoscaled EC2 instances that contain user data scripts which help them contact the databases in data layer.
The resources utilized in this are VPC,subnetting, route-tables, EC2, AutoScaling, Loadbalancers, Route 53(Public and Private Hosted Zones), RDS, Security Groups.
Moreover majority of the resources have been deployed using terraform modules.
![image](https://github.com/Muffy-Phx/3-tier-AWS-Architecture/assets/84915307/2b902a9d-396a-4852-8c59-b082df55dd77)

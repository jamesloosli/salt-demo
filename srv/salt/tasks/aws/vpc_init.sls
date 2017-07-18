# Get the key and secret from a pillar
{% set aws_id = salt['pillar.get']('aws_id') %}
{% set aws_key = salt['pillar.get']('aws_key') %}

# Create a network for the demo
white_vpc:
  boto_vpc.present:
    - name: white
    - cidr_block: 10.0.0.0/20
    - region: us-west-2
    - keyid: {{ aws_id }}
    - key: {{ aws_key }}

# Create an internet gateway
white_gateway:
  boto_vpc.internet_gateway_present:
    - name: white
    - vpc_name: white
    - region: us-west-2
    - keyid: {{ aws_id }}
    - key: {{ aws_key }}
    - require:
      - boto_vpc: white_vpc

# Create the route table
white_route_public:
  boto_vpc.route_table_present:
    - name: white_public
    - vpc_name: white
    - subnet_names:
      - white_public
    - routes:
      - destination_cidr_block: 0.0.0.0/0
        internet_gateway_name: white
    - region: us-west-2
    - keyid: {{ aws_id }}
    - key: {{ aws_key }}
    - require:
      - boto_vpc: white_subnet
# Create a subnet 
white_subnet:
  boto_vpc.subnet_present:
    - name: white_public
    - cidr_block: 10.0.0.0/22
    - vpc_name: white
    - region: us-west-2
    - keyid: {{ aws_id }}
    - key: {{ aws_key }}
    - require:
      - boto_vpc: white_vpc

white_sg_saltmaster:
  boto_secgroup.present:
    - name: white_saltmaster
    - description: "Created with Salt."
    - vpc_name: white
    - rules:
      # SSH
      - ip_protocol: "tcp"
        from_port: "22"
        to_port: "22"
        cidr_ip: "0.0.0.0/0"
      # Salt connections
      - ip_protocol: "tcp"
        from_port: "4505"
        to_port: "4506"
        cidr_ip: "10.0.0.0/20"
      - ip_protocol: "udp"
        from_port: "4505"
        to_port: "4506"
        cidr_ip: "10.0.0.0/20"
    - region: us-west-2
    - keyid: {{ aws_id }}
    - key: {{ aws_key }}
    - require:
      - boto_vpc: white_vpc

white_sg_nginx:
  boto_secgroup.present:
    - name: white_nginx
    - description: "Created with Salt."
    - vpc_name: white
    - rules:
      # SSH
      - ip_protocol: "tcp"
        from_port: "22"
        to_port: "22"
        cidr_ip: "0.0.0.0/0"
      # Salt connections
      - ip_protocol: "tcp"
        from_port: "4505"
        to_port: "4506"
        cidr_ip: "10.0.0.0/20"
      - ip_protocol: "udp"
        from_port: "4505"
        to_port: "4506"
        cidr_ip: "10.0.0.0/20"
      # Web connections
      - ip_protocol: "tcp"
        from_port: "80"
        to_port: "80"
        cidr_ip: "0.0.0.0/0"
      - ip_protocol: "tcp"
        from_port: "443"
        to_port: "443"
        cidr_ip: "0.0.0.0/0"
    - region: us-west-2
    - keyid: {{ aws_id }}
    - key: {{ aws_key }}
    - require:
      - boto_vpc: white_vpc



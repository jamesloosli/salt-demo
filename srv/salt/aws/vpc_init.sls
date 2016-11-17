# Get the key and secret from a pillar
{% set aws_id = salt['pillar.get']('aws_id') %}
{% set aws_key = salt['pillar.get']('aws_key') %}

# Create a network for the demo
white_vpc:
  boto_vpc.present:
    - name: white
    - cidr_block: 10.0.0.0/20
    - region: us-west-2
    - key_id: {{ aws_id }}
    - key: {{ aws_key }}

# Create a public and private subnet
white_subnet_public:
  boto_vpc.subnet_present:
    - name: white_public
    - cidr_block: 10.0.0.0/22
    - vpc_name: white
    - region: us-west-2
    - key_id: {{ aws_id }}
    - key: {{ aws_key }}

#white_subnet_private:
#  boto_vpc.subnet_present:
#    - name: white_private
#    - cidr_block: 10.0.2.0/22
#    - vpc_name: white
#    - region: us-west-2
#    - key_id: {{ aws_id }}
#    - key: {{ aws_key }}

# Create an internet gateway
white_gateway:
  boto_vpc.internet_gateway_present:
    - name: white
    - vpc_name: white
    - region: us-west-2
    - key_id: {{ aws_id }}
    - key: {{ aws_key }}


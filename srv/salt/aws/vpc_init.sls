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

# Create an internet gateway
white_gateway:
  boto_vpc.internet_gateway_present:
    - name: white
    - vpc_name: white
    - region: us-west-2
    - key_id: {{ aws_id }}
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
    - key_id: {{ aws_id }}
    - key: {{ aws_key }}
    - require:
      - boto_vpc: white_gateway
# Create a subnet 
white_subnet:
  boto_vpc.subnet_present:
    - name: white_public
    - cidr_block: 10.0.0.0/22
    - vpc_name: white
    - region: us-west-2
    - key_id: {{ aws_id }}
    - key: {{ aws_key }}
    - require:
      - boto_vpc: white_route_public

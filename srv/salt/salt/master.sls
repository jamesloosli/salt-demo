# Missing python deps
salt_master_boto:
  pip.installed:
    - name: boto

salt_master_boto3:
  pip.installed:
    - name: boto3

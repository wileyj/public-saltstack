#!/usr/bin/env python
import httplib
import boto3
import json
import logging
log = logging.getLogger(__name__)
domain = "moil.io"

regions = {
    "us-east-1" : "use1",
    "us-west-1" : "usw1",
    "us-west-2" : "usw2"
}
env_short = {
    "production": "prd",
    "dev": "dev",
    "qa": "qa",
    "staging": "stg",
    "core": "core",
    "bastion": "b",
    "app": "app",
    "web": "web",
    "db": "db"
}
def _call_aws(url):
    log.trace("[ec2-data] contacting metadata service...")
    conn = httplib.HTTPConnection("169.254.169.254", 80, timeout=1)
    conn.request('GET', url)
    log.trace("[ec2-data] executing else clause")
    return conn.getresponse().read()

def _ec2_network(data):
    ec2_network_grain = {}
    nics = []
    ec2_network_grain["private_ip_address"] = data['NetworkInterfaces'][0]['PrivateIpAddress']
    ec2_network_grain["private_dns_name"] = data['NetworkInterfaces'][0]['PrivateDnsName']
    ec2_network_grain["description"] = data['NetworkInterfaces'][0]['Description']
    ec2_network_grain["first_two_octets"] = data['NetworkInterfaces'][0]['PrivateIpAddress'].split(".")[0]+"."+data['NetworkInterfaces'][0]['PrivateIpAddress'].split(".")[1]
    ec2_network_grain["gateway"] = data['NetworkInterfaces'][0]['PrivateIpAddress'].split(".")[0]+"."+data['NetworkInterfaces'][0]['PrivateIpAddress'].split(".")[1]+".0.2"
    log.trace("setting ec2_network grains")
    log.trace("\t[ec2-data] private_ip_address: %s" % (ec2_network_grain['private_ip_address']))
    log.trace("\t[ec2-data] private_dns_name: %s" % (ec2_network_grain["private_dns_name"]))
    log.trace("\t[ec2-data] description: %s" % (ec2_network_grain["description"]))
    log.trace("\t[ec2-data] first_two_octets: %s" % (ec2_network_grain["first_two_octets"]))
    log.trace("\t[ec2-data] gateway: %s" % (ec2_network_grain["gateway"]))
    for index, nic in enumerate(data['NetworkInterfaces'][0]['PrivateIpAddresses'], start=0):
        info = {
            "Nic": {
                "PrivateIpAddress": nic['PrivateIpAddress'],
                "PrivateDnsName": nic['PrivateDnsName'],
                "PublicIp": nic['Association']['PublicIp'],
                "PublicDnsName": nic['Association']['PublicDnsName'],
                "public": {
                    "PublicIp": nic['Association']['PublicIp'],
                    "PublicDnsName": nic['Association']['PublicDnsName']
                }
            }
        }
        nics.append(info)
    return ec2_network_grain

def _ec2_disk(data):
    ec2_disk_grain = {}
    ec2_disk_grain['RootDeviceType'] = data['RootDeviceType']
    ec2_disk_grain['RootDeviceName'] = data['RootDeviceName']
    ec2_disk_grain['EbsOptimized'] = data['EbsOptimized']
    disks = []
    log.trace("[ec2-data] setting ec2_disk grains")
    for index, ebs in enumerate(data['BlockDeviceMappings'], start=0):
        short = ebs['DeviceName'].split("/")[2]
        info = {
            ebs['DeviceName']: {
                "DeviceName": ebs['DeviceName'],
                "DeviceShort": short,
                "Status": ebs['Ebs']['Status'],
                "DeleteOnTermination": ebs['Ebs']['DeleteOnTermination'],
                "VolumeId": ebs['Ebs']['VolumeId'],
                "AttachTime": str(ebs['Ebs']['AttachTime'])
            }
        }
        disks.append(info)
    ec2_disk_grain["block_device_mappings"] = disks
    log.trace("\t[ec2-data] block_device_mappings: %s" % (ec2_disk_grain["block_device_mappings"]))
    return ec2_disk_grain

def _ec2_tags(data):
    ec2_tag_grain = {}
    log.trace("setting ec2_tags grains")
    for tag in data:
        ec2_tag_grain[tag['Key']] = tag['Value']
        log.trace("\t[ec2-data] Tag(%s): %s" % (tag['Key'], tag['Value']))
    return ec2_tag_grain

def _ec2_info(data):
    ec2_info_grain = {}
    sg = []
    for index, group in enumerate(data['SecurityGroups'], start=0):
        sg.append(group["GroupId"])
    ec2_info_grain["LaunchTime"] = str(data['LaunchTime'])
    ec2_info_grain["VpcId"] = data['VpcId']
    ec2_info_grain["InstanceId"] = data['InstanceId']
    ec2_info_grain["ImageId"] = data['ImageId']
    ec2_info_grain["KeyName"] = data['KeyName']
    ec2_info_grain["SecurityGroups"] = sg
    ec2_info_grain["SubnetId"] = data['SubnetId']
    ec2_info_grain["InstanceType"] = data['InstanceType']
    ec2_info_grain["Architecture"] = data['Architecture']
    ec2_info_grain["IamInstanceProfile"] = data['IamInstanceProfile']['Arn']
    log.trace("[ec2-data] setting the ec2_info grains:")
    log.trace("\t[ec2-data] LaunchTime: %s" % (ec2_info_grain["LaunchTime"]))
    log.trace("\t[ec2-data] VpcId: %s" % (ec2_info_grain["VpcId"]))
    log.trace("\t[ec2-data] InstanceId: %s" % (ec2_info_grain["InstanceId"]))
    log.trace("\t[ec2-data] ImageId: %s" % (ec2_info_grain["ImageId"]))
    log.trace("\t[ec2-data] KeyName: %s" % (ec2_info_grain["KeyName"]))
    log.trace("\t[ec2-data] SecurityGroups: %s" % (ec2_info_grain["SecurityGroups"]))
    log.trace("\t[ec2-data] SubnetId: %s" % (ec2_info_grain["SubnetId"]))
    log.trace("\t[ec2-data] InstanceType: %s" % (ec2_info_grain["InstanceType"]))
    log.trace("\t[ec2-data] Architecture: %s" % (ec2_info_grain["Architecture"]))
    log.trace("\t[ec2-data] IamInstanceProfile: %s" % (ec2_info_grain["IamInstanceProfile"]))
    return ec2_info_grain

#if __name__ == "__main__":
def function():
    try:
        log.trace("[ec2-data] starting ec2_info.py")
        log.trace("[ec2-data] Trying to retrieve instance_id from metadata service")
        instance_id = str(_call_aws("/latest/meta-data/instance-id/"))
        log.trace("[ec2-data] Trying to retrieve region from metadata service")
        region = str(json.loads(_call_aws("/latest/dynamic/instance-identity/document"))['region'])
    except IOError as e:
        log.trace("error: %s" % (e))
        return {'ec2-data': ''}
    ec2_client = boto3.client('ec2', region_name='us-west-2')
    instances = ec2_client.describe_instances(
        Filters=[{
            'Name': 'instance-id',
            'Values': [instance_id]
        }]
    )['Reservations'][0]['Instances']
    grains = {}
    log.trace("[ec2-data] setting network grains")
    network = _ec2_network(instances[0])
    log.trace("[ec2-data] setting disk grains")
    disks = _ec2_disk(instances[0])
    log.trace("[ec2-data] setting info grains")
    info = _ec2_info(instances[0])
    log.trace("[ec2-data] setting tags grains")
    tags = _ec2_tags(instances[0]['Tags'])

    log.trace("[ec2-data] Updating grains...")
    grains.update({'ec2-tags': tags})
    grains.update({'ec2-info': info})
    grains.update({'ec2-disks': disks})
    grains.update({'ec2-network': network})
    log.trace("create grains complete")
    return {'ec2-data': grains}
    #print "{'ec2-data': %s}" % (grains)

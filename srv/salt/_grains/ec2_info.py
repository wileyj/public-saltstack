#!/usr/bin/env python
""" docstring """
import httplib
import json
import logging
log = logging.getLogger(__name__)
from boto3.session import Session

session = Session()

domain = "domain.com"
regions = {
    "us-east-1" : "use1",
    "us-west-1" : "usw1",
    "us-west-2" : "usw2"
}
env_short = {
    "production": "p",
    "dev": "d",
    "qa": "q",
    "staging": "s",
    "core": "c"
}
def _call_aws(url):
    conn = httplib.HTTPConnection("169.254.169.254", 80, timeout=1)
    conn.request('GET', url)
    return conn.getresponse().read()

#def _ec2_disks(ec2_instance):
#    """ docstring """
#    ec2_disk_grain = {}
#    ec2_disk_grain["root_device_name"] = ec2_instance.root_device_name
#    ec2_disk_grain["root_device_type"] = ec2_instance.root_device_type
#    ec2_disk_grain["ebs_optimized"] = ec2_instance.ebs_optimized
#    #ec2_disk_grain["block_device_mappings"] = ec2_instance.block_device_mappings
#    return ec2_disk_grain

def _ec2_disks(ec2_instance):
    """ docstring """
    ec2_disk_grain = {}
    disks = []
    ec2_disk_grain["root_device_name"] = ec2_instance.root_device_name
    ec2_disk_grain["root_device_type"] = ec2_instance.root_device_type
    ec2_disk_grain["ebs_optimized"] = ec2_instance.ebs_optimized
    for index, ebs in enumerate(ec2_instance.block_device_mappings, start=0):
      short = ebs['DeviceName'].split("/")[2]
      try:
        info = {
          "Disk": short,
          "Ebs": {
            "DeviceName": ebs['DeviceName'],
            "Status": ebs['Ebs']['Status'],
            "DeleteOnTermination": ebs['Ebs']['DeleteOnTermination'],
            "VolumeId": ebs['Ebs']['VolumeId'],
            "AttachTime": str(ebs['Ebs']['AttachTime'])
          }
        }
        disks.append(info)
      except Exception:
        ephemeral = True
    ec2_disk_grain["block_device_mappings"] = disks
    return ec2_disk_grain

def _ec2_network(ec2_instance):
    """ docstring """
    ec2_network_grain = {}
    ec2_network_grain["private_dns_name"] = ec2_instance.private_dns_name
    ec2_network_grain["private_ip_address"] = ec2_instance.private_ip_address
    ec2_network_grain["public_dns_name"] = ec2_instance.public_dns_name
    ec2_network_grain["public_ip_address"] = ec2_instance.public_ip_address
    ec2_network_grain["first_two_octets"] = ec2_instance.private_ip_address.split(".")[0]+"."+ec2_instance.private_ip_address.split(".")[1]
    ec2_network_grain["gateway"] = ec2_instance.private_ip_address.split(".")[0]+"."+ec2_instance.private_ip_address.split(".")[1]+".0.2"
    #ec2_network_grain["network_interfaces_attribute"] = ec2_instance.network_interfaces_attribute
    return ec2_network_grain

def _ec2_tags(ec2_instance, ec2_region):
    """ docstring """
    ec2_tag_grain = {}
    beanstalk = 0
    env_name = ""
    for tag in ec2_instance.tags:
        if tag['Key'] == "Name":
            ec2_tag_grain["business_unit"] = tag['Value'].split("-")[0]
            ec2_tag_grain["role"] = tag['Value'].split("-")[1]
            ec2_tag_grain["region_short"] = tag['Value']
            ec2_tag_grain["role"] = tag['Value'].split("-")[1]
            if tag['Value'].split("-")[2]:
                ec2_tag_grain["host_num"] = tag['Value'].split("-")[2]
            else:
                ec2_tag_grain["host_num"] = "000"
            ec2_tag_grain["name"] = tag['Value'].lower()
        elif tag['Key'] == "Environment":
            ec2_tag_grain["environment"] = tag['Value'].lower()
            try:
                if env_short[tag['Value']]:
                    env_name = env_short[tag['Value'].lower()]
                else:
                    env_name = "default"
            except Exception:
                print "Defined ENV not found %s" % (tag['Value'])
        elif tag['Key'] == "Region":
            ec2_tag_grain["region"] = (tag['Value'].lower())
        elif tag['Key'] == "SiteName":
            ec2_tag_grain["sitename"] = tag['Value'].lower()
        elif tag['Key'] == "elasticbeanstalk:environment-id":
            ec2_tag_grain["elasticbeanstalk_id"] = tag['Value']
            beanstalk = 1
        elif tag['Key'] == "elasticbeanstalk:environment-name":
            ec2_tag_grain["elasticbeanstalk_name"] = tag['Value']
        else:
            ec2_tag_grain[tag['Key']] = tag['Value']
    ec2_tag_grain["region_short"] = regions[ec2_region].lower()
    if beanstalk == 1:
        ec2_tag_grain["hostname_full"] = ec2_tag_grain["business_unit"].lower() + "-" + ec2_tag_grain["role"].lower() + "-" + ec2_tag_grain["host_num"] + "-" + ec2_tag_grain["instance_id"] + "." + env_name.lower() + "." + "." + regions[ec2_region].lower() + "." + domain.lower()
    else:
        ec2_tag_grain["hostname_full"] = ec2_tag_grain["business_unit"].lower() + "-" + ec2_tag_grain["role"].lower() + "-" + ec2_tag_grain["host_num"] + "." + env_name.lower() + "." + regions[ec2_region].lower() + "." + domain.lower()
    ec2_tag_grain["region_searchpath"] = regions[ec2_region]+"."+domain
    return ec2_tag_grain

def _ec2_info(ec2_instance, ec2_region):
    """ docstring """
    ec2_info_grain = {}
    ec2_info_grain["region"] = ec2_region
    ec2_info_grain["ami_launch_index"] = ec2_instance.ami_launch_index
    ec2_info_grain["availability_zone"] = ec2_instance.placement['AvailabilityZone']
    ec2_info_grain["monitored"] = ec2_instance.monitoring['State']
    ec2_info_grain["state"] = ec2_instance.state['Name']
    ec2_info_grain["architecture"] = ec2_instance.architecture
    ec2_info_grain["hypervisor"] = ec2_instance.hypervisor
    ec2_info_grain["iam_instance_profile"] = ec2_instance.iam_instance_profile
    ec2_info_grain["image_id"] = ec2_instance.image_id
    ec2_info_grain["instance_id"] = ec2_instance.instance_id
    ec2_info_grain["instance_type"] = ec2_instance.instance_type
    ec2_info_grain["kernel_id"] = ec2_instance.kernel_id
    ec2_info_grain["key_name"] = ec2_instance.key_name
    ec2_info_grain["launch_time"] = str(ec2_instance.launch_time)
    ec2_info_grain["monitoring"] = ec2_instance.monitoring
    ec2_info_grain["placement"] = ec2_instance.placement
    ec2_info_grain["platform"] = ec2_instance.platform
    ec2_info_grain["ramdisk_id"] = ec2_instance.ramdisk_id
    ec2_info_grain["security_groups"] = ec2_instance.security_groups
    ec2_info_grain["source_dest_check"] = ec2_instance.source_dest_check
    ec2_info_grain["virtualization_type"] = ec2_instance.virtualization_type
    ec2_info_grain["vpc_id"] = ec2_instance.vpc_id
    return ec2_info_grain

#if __name__ == "__main__":
def function():
    """ docstring """
    instance_id = _call_aws("/latest/meta-data/instance-id/")
    region = str(json.loads(_call_aws("/latest/dynamic/instance-identity/document"))['region'])
    client = session.resource('ec2', region_name=region)
    instances = client.instances.filter(
        Filters=[{
            'Name': 'instance-id',
            'Values': [instance_id]
        }]
    )
    grains = {}
    for instance in instances:
        tags = _ec2_tags(instance, region)
        info = _ec2_info(instance, region)
        disks = _ec2_disks(instance)
        network = _ec2_network(instance)
        grains.update({'ec2-tags': tags})
        grains.update({'ec2-info': info})
        grains.update({'ec2-disks': disks})
        grains.update({'ec2-network': network})
    return {'ec2-data': grains}
    #print {'ec2-data': grains}

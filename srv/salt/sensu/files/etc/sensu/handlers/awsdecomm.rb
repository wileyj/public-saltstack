#!/usr/bin/env ruby

require 'sensu-handler'
require 'aws-sdk'

class Decomm < Sensu::Handler

  def delete_sensu_client
    puts "Sensu client #{@event['client']['name']} is being deleted."
    if api_request(:DELETE, '/clients/' + @event['client']['name']).code != '202'
      puts "Sensu API call failed"
    end
  end

  def check_aws
    %w{ us-east-1 us-west-1 us-west-2 ap-southeast-1 }.each do |my_region|
      ec2 = Aws::EC2::Resource.new(region: my_region)
      my_instance_addr= @event['client']['address']
      not_found = true

      ec2.instances.each do |instance|
        if my_instance_addr.eql?(instance.private_ip_address)
          not_found = false
          puts "Instance #{@event['client']['name']} exists; Checking state"
          if instance.state["name"] != "running"
            puts "Instance #{@event['client']['name']} is #{instance.state["name"]}; I will proceed with decommission activities."
            delete_sensu_client
          end
        end
      end
      if not_found
        puts "Couldnt find #{@event['client']['name']} on AWS. Decommissioning instance. "
        delete_sensu_client
      end
    end
  end

  def handle
    if @event['action'].eql?('create')
      check_aws
    end
  end

end


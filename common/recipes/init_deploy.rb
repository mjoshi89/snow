#
# Cookbook Name:: common
# Recipe:: default
#
# Copyright 2018, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

host_name = `curl http://169.254.169.254/latest/meta-data/public-hostname`

#Make sure that the required group exists
group 'my_staff' do

#Make sure the required user exists
node[:common][:user_name].each do |user_name|
  user user_name do
    home '/home/user_name'
    gid 'my_staff'
  end
end

#Make sure the monitoring agent configuration file is presend and has hostname configured
template "#{node[:common][:monitoring][:install_path]}/agent.conf" do
  source 'agent.conf.erb'
  variables({
    :host_name => "#{host_name}"
	  })
   action :create
   owner 'root'
   group 'root'
   mode 0664
end



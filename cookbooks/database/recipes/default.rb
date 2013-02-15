#
# Cookbook Name:: database
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

database_server = search(:node, "role:database AND chef_environment:#{node.chef_environment}").first
Chef::Log.error("search found #{database_server.length} nodes")

hostname = database_server['fqdn']

credentials = Chef::EncryptedDataBagItem.load("crendentials", "database","/tmp/othersecret")

username = credentials[node.chef_environment]['username']
password = credentials[node.chef_environment]['password']

template "/tmp/database.yml" do 
  mode "777"
  source "database.yml.erb"
  variables(
    :database_host => hostname,
    :username => username,
    :password => password
  )
end
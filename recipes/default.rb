#
# Cookbook Name:: azure_fqdn_fix
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template '/etc/hosts' do 
	source 'etc_hosts.erb'
	mode '0644' # Default file permissions for this file.
	owner 'root'
	group 'root'
	variables({
		domain: node['azure_fqdn_fix']['domain'],
		hostname: node['azure_fqdn_fix']['hostname'],
		nodename: node['hostname']
		})
end
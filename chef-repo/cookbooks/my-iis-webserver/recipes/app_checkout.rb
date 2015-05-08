# Cookbook Name:: my-iis-webserver
# Recipe:: app_checkout
#
# Copyright 2015, Great Websites Inc
#

log "*** Hello from the iis-webserver::app_checkout recipe!"

include_recipe 'git::default'

# Add app version to node data. Unknown for now
node.set['my-iis-webserver']['app-ver'] = 'unknown'

# Use the 'git' resource to checkout from the provided repository
git node['my-iis-webserver']['doc-root'] do
  repository node['my-iis-webserver']['git-repo']
  revision node['my-iis-webserver']['git-revision']
  action :sync
end

powershell_script 'dir git folder' do
  code '
    dir c:\inetpub\wwwroot
  '
  action :run
end

# Get the app version from VERSION.txt and add it to the node data
ruby_block 'Retrieve app version' do
  block do
    version = File.open("#{node['my-iis-webserver']['doc-root']}/VERSION.txt").readline.chomp
    node.set['my-iis-webserver']['app-ver'] = version
  end
  only_if { File.exist?("#{node['my-iis-webserver']['doc-root']}/VERSION.txt") }
end

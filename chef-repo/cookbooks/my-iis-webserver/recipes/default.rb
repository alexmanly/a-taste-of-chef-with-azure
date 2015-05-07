#
# Cookbook Name:: my-iis-webserver
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#

log "*** Hello from the my-iis-webserver::default recipe!"

# Use the registry_key resource to change the startup type for the chef-client service
registry_key 'HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\chef-client' do
  values [{
    :name => "DelayedAutostart",
    :type => :dword,
    :data => 1
  }]
  action :create
end

windows_feature 'IIS-WebServerRole' do
  action :install
end

file 'c:/inetpub/wwwroot/iisstart.htm' do
  action :delete
end

file 'c:/inetpub/wwwroot/iis-85.png' do
  action :delete
end

file 'c:/inetpub/wwwroot/welcome.png' do
  action :delete
end

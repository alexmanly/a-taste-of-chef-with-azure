#include_recipe 'my-iis-webserver::_azure_settings'

require 'chef/provisioning/azure_driver'
with_driver 'azure'

machine_options = {
  :bootstrap_options => {
    :vm_user => node['my-iis-webserver']['azure']['vm_user'], #required if Windows
    :cloud_service_name => node['my-iis-webserver']['azure']['cloud_service_name'], #required
    :storage_account_name => node['my-iis-webserver']['azure']['storage_account_name'], #required
    :location => node['my-iis-webserver']['azure']['location'], #optional
    :tcp_endpoints => node['my-iis-webserver']['azure']['tcp_endpoints'], #optional
    :winrm_transport => { #optional
      'https' => { #required (valid values: 'http', 'https')
        :disable_sspi => node['my-iis-webserver']['azure']['winrm_transport']['https']['disable_sspi'], #optional, (default: false)
        :basic_auth_only => node['my-iis-webserver']['azure']['winrm_transport']['https']['basic_auth_only'], #optional, (default: false)
        :no_ssl_peer_verification => node['my-iis-webserver']['azure']['winrm_transport']['https']['no_ssl_peer_verification'] #optional, (default: false)
      }
    }
  },
  :password => node['my-iis-webserver']['azure']['password'], #required
  :image_id => node['my-iis-webserver']['azure']['image_id'] #required
}

azure_storage_account node['my-iis-webserver']['azure']['storage_account_name'] do
  action :create
  options :location => node['my-iis-webserver']['azure']['location'],
          :geo_replication_enabled => node['my-iis-webserver']['azure']['geo_replication_enabled']
end

azure_cloud_service node['my-iis-webserver']['azure']['cloud_service_name'] do
  action :create
  options :location => node['my-iis-webserver']['azure']['location']
end

machine node['my-iis-webserver']['azure']['vm_name'] do
  machine_options machine_options
  recipe "my-iis-webserver::default"
  tag "my-iis-webserver"
  converge true
  action :converge
end

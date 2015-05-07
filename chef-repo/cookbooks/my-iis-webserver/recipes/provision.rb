include_recipe 'my-iis-webserver::_azure_settings'

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

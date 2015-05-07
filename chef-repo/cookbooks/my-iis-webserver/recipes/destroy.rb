include_recipe 'my-iis-webserver::_azure_settings'

machine node['my-iis-webserver']['azure']['vm_name'] do
 machine_options machine_options
 action :destroy
end

azure_storage_account node['my-iis-webserver']['azure']['storage_account_name'] do
  action :destroy
  options :location => node['my-iis-webserver']['azure']['location']
end

azure_cloud_service node['my-iis-webserver']['azure']['cloud_service_name'] do
  action :destroy
  options :location => node['my-iis-webserver']['azure']['location']
end

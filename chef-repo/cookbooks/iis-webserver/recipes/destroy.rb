require 'chef/provisioning/azure_driver'
with_driver 'azure'
machine_options = {
 :bootstrap_options => {
   :cloud_service_name => 'emea-amanly-demo01',
   :storage_account_name => 'emeaamanlydemo01',
   :location => 'West US'
 },
 # Until SSH keys are supported (soon)
 :password => "P2ssw0rd"
}

machine 'emeaamanlydemo01' do
 machine_options machine_options
 action :destroy
end

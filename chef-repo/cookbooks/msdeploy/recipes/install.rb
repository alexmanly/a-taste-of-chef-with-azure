include_recipe 'webpi'

webpi_product 'WDeployNoSMO' do
	accept_eula true
	action :install
end
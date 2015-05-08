# a-taste-of-chef-with-azure

1) Clone this repo
2) Request access to the https://api.opscode.com/organizations/a_taste_of_chef_with_azure manage chef organisation.
3) Once you have access to the organisation download the client and org PEM file and add them to the [PATH_TO_REPO]/a-taste-of-chef-with-azure/chef-repo/.chef directory.
4) Edit the [PATH_TO_REPO]/a-taste-of-chef-with-azure/chef-repo/.chef/knife.rb with the new PEM files.
5) Ensure the Azure credentials are correct in the ~/.azure directory.
6) Run this command from chef-repo: sudo chef-client -c [PATH_TO_REPO]/a-taste-of-chef-with-azure/chef-repo/.chef/knife.rb -r 'recipe[my-iis-webserver::provision]'


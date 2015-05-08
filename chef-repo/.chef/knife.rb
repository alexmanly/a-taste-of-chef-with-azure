# See https://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "alexmanly"
client_key               "#{current_dir}/alexmanly.pem"
validation_client_name   "a_taste_of_chef_with_azure-validator"
validation_key           "#{current_dir}/a_taste_of_chef_with_azure-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/a_taste_of_chef_with_azure"
cookbook_path            ["#{current_dir}/../cookbooks"]

# A Taste of Chef with Azure

1. Clone this repo
2. Request access to the https://api.opscode.com/organizations/a_taste_of_chef_with_azure manage chef organisation.
3. Once you have access to the organisation download the client and org PEM file and add them to the [PATH_TO_REPO]/a-taste-of-chef-with-azure/chef-repo/.chef directory.
4. Edit the [PATH_TO_REPO]/a-taste-of-chef-with-azure/chef-repo/.chef/knife.rb with the new PEM files.
5. Ensure the Azure credentials are correct in the ~/.azure directory.
6. Run this command from chef-repo: sudo chef-client -c [PATH_TO_REPO]/a-taste-of-chef-with-azure/chef-repo/.chef/knife.rb -r 'recipe[my-iis-webserver::provision]'


PROVISION
=========

#### Create an environment.json file.
This will drive your project setup and configuration.

Export the name of your environment:

```
$ export CHEF_ENV=my_new_environment
```

__UPDATE THE LINES STARTING WITH `>>` to your values.__

```
$ cat environments/test.json
{
>>"name": "test",
  "description": "",
  "json_class": "Chef::Environment",
  "chef_type": "environment",
  "override_attributes": {
    "my-iis-webserver": {
      "demo": {
>>      "name": "mydemo"
      },
      "azure": {
        "vm_user": "localadmin",
        "location": "West US",
        "tcp_endpoints": "80:80",
        "password": "P2ssw0rd",
        "image_id": "a699494373c04fc0bc8f2bb1389d6106__Windows-Server-2012-R2-201502.01-en.us-127GB.vhd",
        "geo_replication_enabled": false,
      }
    }
  }
}

```

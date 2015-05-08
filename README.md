# A Taste of Chef with Azure

## Microsoft Azure Management Certificate installation
To retrieve the .PFX file required, follow the steps in this great blog post (kudos to Stuart Preston for his help):

http://stuartpreston.net/2015/02/retrieving-microsoft-azure-management-certificates-for-use-in-cross-platform-automationprovisioning-tools/

The resulting .pfx file needs to be placed in the following locations:

Mac:
```
~/.azure/mgmtcert.pfx
```

Windows
```
%USERPROFILE%\.azure\mgmtcert.pfx
```

##Microsoft Azure configuration file

Azure configuration for Chef Provisioning is expected to be found in a file called ~/.azure/config or %USERPROFILE%\.azure\config depending on your platform.  Eventually this config will support multiple profiles/subscriptions.

The file should look something like the following:

Mac:
```
[default]
management_certificate = "/users/StuartPreston/.azure/mgmtcert.pfx"
subscription_id = "b6e7eee9-12ab-12ab-12ab-03ab624df016"
```
Windows:
```
[default]
management_certificate = "c:\users\Stuart\mgmtcert.pfx"
subscription_id = "b6e7eee9-12ab-12ab-12ab-03ab624df016"
(the subscription id can be found within the downloaded .publishsettings file against your subscription name)
```

1. Clone this repository.
2. Either:
  * Request access to the https://api.opscode.com/organizations/a_taste_of_chef_with_azure manage chef organisation or use your own server.  Once you have access to the organisation download the client and org PEM files and add them to the [PATH_TO_REPO]/a-taste-of-chef-with-azure/chef-repo/.chef directory.  Edit the [PATH_TO_REPO]/a-taste-of-chef-with-azure/chef-repo/.chef/knife.rb with the new PEM files.
  * Or if you use your own server then configure the .chef directory to point to your server and upload all the cookbooks from this repository to your server.
3. Ensure the Azure credentials are correct in the ~/.azure directory.
4. Run this command from chef-repo: sudo chef-client -c [PATH_TO_REPO]/a-taste-of-chef-with-azure/chef-repo/.chef/knife.rb -r 'recipe[my-iis-webserver::provision]'


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

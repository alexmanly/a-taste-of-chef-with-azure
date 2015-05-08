# A Taste of Chef with Azure

The purpose of this project is to show how to use Chef to provision a Window Server 2012 R2 in Azure, install a Microsoft IIS web server and then deploy a static web site downloaded from a public Git repository.  

The main cookbook to in this repository is 'my-iis-webserver'.

| Recipe           | Description                |
| -----------------| -------------------------- |
| `my-iis-webserver::default` | The `default` recipe will install IIS and then call the `app_checkout` recipe. |
| `my-iis-webserver::app_checkout` | The `app_checkout` recipe will install Git and then use git to download and install the static web site. |
| `my-iis-webserver::provision` | The `provision` recipe will create the following azure resources: storage account, cloud service and a Window Server 2012 R2 virtual machine configured with the `default` recipe. |
| `my-iis-webserver::destroy` | The `destroy` recipe will destroy the azure resources created in the `provision` recipe. |


## Microsoft Azure Management Certificate installation
To retrieve the .PFX file required, follow the steps in this great blog post from Stuart Preston (kudos to Stuart Preston for all his help):

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

Azure configuration for Chef Provisioning is expected to be found in a file called ~/.azure/config or %USERPROFILE%\.azure\config depending on your platform.  The file should look something like the following (note: the subscription id can be found within the downloaded .publishsettings file against your subscription name):

Mac:
```
[default]
management_certificate = "/users/USERNAME/.azure/mgmtcert.pfx"
subscription_id = "43e53945-f02b-4269-8854-ad7dd14ac6f2"
```
Windows:
```
[default]
management_certificate = "c:\users\USERNAME\mgmtcert.pfx"
subscription_id = "43e53945-f02b-4269-8854-ad7dd14ac6f2"
```

##  Install the Azure provisioning Gems.

This project uses a couple resources (azure_storage_account and azure_cloud_service) that have not been merged into the master branch of the chef-provisioning-azure repository.  Therefore we need to build the gem from Stuart's branch using the following commands.

```
git clone https://github.com/chef/chef-provisioning-azure.git
cd chef-provisioning-azure
git checkout sp/asm-resources
gem build chef-provisioning-azure.gemspec
gem install chef-provisioning
chef gem install ./chef-provisioning-azure-0.3.2.gem
```

## Create an environment.json file.
This will drive your project setup and configuration.

Export the name of your environment:

```
$ export CHEF_ENV=demo_env
```

__UPDATE THE LINES STARTING WITH `>>` to your values.__

```
$ cat environments/demo_env.json
{
  "name": "demo_env",
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
        "image_id": "a699494373c04fc0bc8f2bb1389d6106__Windows-Server-2012-R2-201502.01-en.us-127GB.vhd"
      }
    }
  }
}
```


1. Clone this repository.
2. Either:
  * Request access to the https://api.opscode.com/organizations/a_taste_of_chef_with_azure manage chef organisation or use your own server.  Once you have access to the organisation download the client and org PEM files and add them to the [PATH_TO_REPO]/a-taste-of-chef-with-azure/chef-repo/.chef directory.  Edit the [PATH_TO_REPO]/a-taste-of-chef-with-azure/chef-repo/.chef/knife.rb with the new PEM files.
  * Or if you use your own server then configure the .chef directory to point to your server and upload all the cookbooks from this repository to your server.
3. Upload the environment to the Chef server
```
knife environment from file demo_env.json
```
4. Run this command from chef-repo directory [PATH_TO_REPO]/a-taste-of-chef-with-azure/chef-rep:
```
sudo chef-client -c [PATH_TO_REPO]/a-taste-of-chef-with-azure/chef-repo/.chef/knife.rb -E $(CHEF_ENV) -r 'recipe[my-iis-webserver::provision]'
```

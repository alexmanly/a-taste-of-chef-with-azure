# my-iis-webserver

## Test Kitchen

To be able to test this cookbook using test kitchen, you need to firstly install the Windows Server 2012R2 image in to VirtualBox.  To do this download the box image (from the usual channels) and install it using this command.

```
vagrant box add win2012r2 ./eval-win2012r2-datacenter-nocm-1.0.3.box
```

To speed up the test process, download the Windows client installer file and store it locally.  This saves each test run from downloading the Windows chef client on each run.  Next edit the location of the synced folder in the .kitchen.yml file.  Also edit the chef_metadata_url attribute to be the location from within the synced folder.  The contents of the file: windows_v12.2.1.txt should look similar to this:

```
url	file:///c:/share/chef/chef-client-12.2.1-1.msi
md5	f0c483e11c628c0e9f9fc57d162d5e12
sha256	626560ce83aa82a610c7cdfe86fa896b043004053439cdc5dcd926135a3ee90d
```

Once the box is installed and the synced folder is configured, you can then run TestKitchen using this command.

```
kitchen provision
```

Test the installed web page is accessible from this url: http://192.168.56.31

To destroy the image run this command.

```
kitchen destroy
```

Happy testing....

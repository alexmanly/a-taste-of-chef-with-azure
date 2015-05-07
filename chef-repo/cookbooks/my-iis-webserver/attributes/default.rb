default['my-iis-webserver']['doc-root']                       = 'c:/inetpub/wwwroot'
default['my-iis-webserver']['git-repo']                       = 'https://github.com/alexmanly/myhtml-app'
default['my-iis-webserver']['git-revision']                   = 'master'

default['my-iis-webserver']['demo']['name']                  = 'amanly'

default['my-iis-webserver']['azure']['vm_user']               = 'localadmin'
default['my-iis-webserver']['azure']['cloud_service_name']    = node['my-iis-webserver']['demo']['name'] + '-cs-demo'
default['my-iis-webserver']['azure']['storage_account_name']  = node['my-iis-webserver']['demo']['name'] + 'sademo'
default['my-iis-webserver']['azure']['vm_name']               = node['my-iis-webserver']['demo']['name'] + 'demo01'
default['my-iis-webserver']['azure']['location']              = 'West US'
default['my-iis-webserver']['azure']['tcp_endpoints']         = '3389:3389'
default['my-iis-webserver']['azure']['winrm_transport']['https']['disable_sspi']  = false
default['my-iis-webserver']['azure']['winrm_transport']['https']['basic_auth_only']  = false
default['my-iis-webserver']['azure']['winrm_transport']['https']['no_ssl_peer_verification']  = true
default['my-iis-webserver']['azure']['password']              = 'P2ssw0rd'
default['my-iis-webserver']['azure']['image_id']              = 'a699494373c04fc0bc8f2bb1389d6106__Windows-Server-2012-R2-201502.01-en.us-127GB.vhd'
default['my-iis-webserver']['azure']['geo_replication_enabled']  = false

webpi Cookbook
==============
Microsoft Web Platform Installer (WebPI) automates the installation of Microsoft's entire Web Platform.  This cookbook makes it easy to get WebpiCmdLine.exe the lightweight CLI version of WebPI onto a Windows node.  It also exposes a resource for installing WebPI products idempotently.


Requirements
------------
### Platforms
* Windows XP
* Windows Vista
* Windows Server 2003 R2
* Windows 7
* Windows Server 2008 (R1, R2)
* Windows 8
* Windows Server 2012

### Cookbooks
* windows


Attributes
----------
* `node['webpi']['home']` - location to install WebPI files to. Default is `%SYSTEMDRIVE%\webpi`
* `node['webpi']['url']` - Path to download webpi zip.
* `node['webpi']['xmlpath']` - Optional path to custom xml file.
* `node['webpi']['install_method']` - Method of installing webpi via msi or zip. Default is msi.
* `node['webpi']['msi']` - Location of msi file to use.
* `node['webpi']['msi_package_name']` - Windows package name, found in registry, for msi. Defaults to "Microsoft Web Platform Installer 4.5"


Resource/Provider
-----------------
### webpi_product
#### Actions
- :install: install a product using WebpiCmdLine

#### Attribute Parameters
- product_id: name attribute. Specifies the ID of a product to install.
- accept_eula: specifies that WebpiCmdline should auto-accept EULAs. Default is false.

#### Examples
Install IIS 7 Recommended Configuration (will install IIS 8 on Windows 2012 despite the name)
```ruby
webpi_product 'IIS7' do
  accept_eula true
  action :install
end
```

Install Windows PowerShell 2.0
```ruby
webpi_product 'PowerShell2' do
  accept_eula true
  action :install
end
```


Usage
-----
### default
Downloads and unzips `WebpiCmdLine.exe` to the location specified by `node['webpi']['home']`.  `WebpiCmdLine.exe` is used required by the `webpi_product` LWRP for taking all actions.


License & Authors
-----------------
Author:: Seth Chisamore (<schisamo@opscode.com>)

```text
Copyright:: 2011-2013, Opscode, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

name             'iis-webserver'
maintainer       'Alex Manly'
maintainer_email 'am@chef.io'
license          'All rights reserved'
description      'Installs/Configures iis-webserver cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

depends 'windows'
depends 'iis'
depends 'git'
depends 'msdeploy'

recipe 'iis-webserver::default', 'Default recipe to install IIS'
recipe 'iis-webserver::app_checkout', 'Recipe to deploy public git code'

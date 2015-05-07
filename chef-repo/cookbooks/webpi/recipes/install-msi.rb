#
# Author:: Guilhem Lettron (<guilhem.lettron@youscribe.com>)
# Cookbook Name:: webpi
# Recipe:: install-msi
#
# Copyright 2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "windows"

msi_file = cached_file(node['webpi']['msi'], node['webpi']['msi_checksum'])

# Do this stuff at compile time so we can build the path and use the exe on this run for the LWRP
windows_package node['webpi']['msi_package_name'] do
  source msi_file
  action :nothing
end.run_action(:install)

# MSI manage PATH
if system("where WebpiCmd.exe 2>&1 > NUL")
  node.default['webpi']['bin'] = "WebpiCmd.exe"
elsif ::File.exists? "#{ENV['ProgramW6432']}/Microsoft/Web Platform Installer/WebpiCmd.exe"
  node.default['webpi']['bin'] = "#{ENV['ProgramW6432']}/Microsoft/Web Platform Installer/WebpiCmd.exe"
elsif ::File.exists? "#{ENV['ProgramFiles']}/Microsoft/Web Platform Installer/WebpiCmd.exe"
  node.default['webpi']['bin'] = "#{ENV['ProgramFiles']}/Microsoft/Web Platform Installer/WebpiCmd.exe"
else
  Chef::Log.error "Unable to find Webpi executable"
  raise "WebpiCmd.exe can't be found"
end

#
# Cookbook Name:: ubuntu
# Recipe:: default
#
# Copyright 2008-2009, Opscode, Inc.
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

template "/etc/apt/sources.list" do
  mode 0644
  variables :code_name => node[:lsb][:codename]
  source "sources.list.erb"
end

class MyUbuntuFiles
  extend Chef::Mixin::FindPreferredFile
end

node[:ubuntu][:additional_apt_keys].each do |apt_key_name, apt_key_file|
  execute "adding apt key \"#{apt_key_name}\"" do
    file_name = MyUbuntuFiles.find_preferred_file(
                  cookbook_name,
                  :remote_file,
                  apt_key_file,
                  node[:fqdn],
                  node[:platform],
                  node[:platform_version]
                )
    command "apt-key add #{file_name}"
    not_if do
      `apt-key list` =~ /#{apt_key_name}/
    end
  end
end

include_recipe "apt"

#
# Cookbook Name:: festival-kibana
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

systemd_unit 'kibana.service' do
  action [:stop, :disable]
end

apt_package 'kibana' do
  action :remove
end

file '/etc/apt/sources.list.d/kibana.list' do
  action :delete
end

file '/opt/kibana/config/kibana.yml' do
  action :delete
end

#
# Cookbook Name:: festival-kibana
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

cookbook_file '/etc/apt/sources.list.d/kibana.list' do
  source 'kibana.list'
  owner 'root'
  group 'root'
  mode '0664'
  action :create
end

apt_update 'Update the apt cache' do
  action :update
end

apt_package 'kibana' do
  options '--allow-unauthenticated'
  action :install
end

template '/opt/kibana/config/kibana.yml' do
  source 'kibana.yml.erb'
  owner 'root'
  group 'root'
  mode '0664'
  variables({
    :server_host => node.combined_default['festival-kibana']['server.host'],
    :tilemap_url => node.combined_default['festival-kibana']['tilemap.url'],
    :tilemap_options_maxzoom => node.combined_default['festival-kibana']['tilemap.options.maxZoom'],
    :tilemap_options_attribution => node.combined_default['festival-kibana']['tilemap.options.attribution']
  })
end

systemd_unit 'kibana.service' do
  action [:enable, :start]
end

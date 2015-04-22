#
# Cookbook Name:: phpapp
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


include_recipe "php"

# configure php to use gearman via cli for debugging
begin
  t = resources(:template => "/etc/php5/cli/php.ini")
  t.source "php.ini.erb"
  t.cookbook "phpapp"
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn "could not find template /etc/php5/cli/php.ini to modify"
end

include_recipe "php::module_mysql"
include_recipe "php5-fpm::install"
include_recipe "nginx"
include_recipe "gearman"
include_recipe "gearman::server"
include_recipe 'git'


# the php_pear resource expects this directory to exist
directory "/etc/php5/conf.d" do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# The gearman cookbook installs the server, worker and client.
# This resource makes the php extension available via PECL
php_pear "gearman" do
  action :install
end

# todo
# set cgi.fix_pathinfo=0 in /etc/php5/fpm/php.ini

# create vhosts dir
directory "/var/vhosts" do
  owner node['nginx']['user']
  group node['nginx']['group']
  mode '0755'
  action :create
end

# add vhost config for QA
template '/etc/nginx/sites-available/qa-prime' do
  source 'nginx.qa-prime.erb'
  cookbook 'phpapp'
  mode '0644'
  owner 'root'
  group 'root'
end

# Enable QA vhost
link "/etc/nginx/sites-enabled/qa-prime" do
  to "/etc/nginx/sites-available/qa-prime"
end

=begin
# install API source code
git "/usr/share/nginx/html" do
  repository "https://github.com/sentientdecisionscience/Sentient-Prime-Survey-API.git"
  revision "master"
  action :sync
end
=end



mysql_service 'default' do
  port node['phpapp']['mysql']['port'] # todo: need to use this port because the "mysql" instance still gets installed on 3306
  version '5.5'
  initial_root_password node['phpapp']['mysql']['initial_root_password']
  action [:create, :start]
end

mysql_config 'default' do
  cookbook 'phpapp'
  source 'mysite.cnf.erb'
  notifies :restart, 'mysql_service[default]'
  action :create
end

mysql_client 'default' do
  action :create
end

mysql2_chef_gem 'default' do
  action :install
end

mysql_database node['phpapp']['database_name'] do
  connection(
    :host     => node['phpapp']['mysql']['host'],
    :username => node['phpapp']['mysql']['username'],
    :password => node['mysql']['server_root_password'],
    :socket   => node['phpapp']['mysql']['socket'],
    :port     => node['phpapp']['mysql']['port']
  )
  action :create
end

mysql_database_user node['phpapp']['db_username'] do
  connection({
    :host => node['phpapp']['mysql']['host'],
    :username => node['phpapp']['mysql']['username'],
    :password => node['mysql']['server_root_password'],
    :socket   => node['phpapp']['mysql']['socket'],
    :port     => node['phpapp']['mysql']['port']
  })
  password node['phpapp']['db_user_password']
  database_name node['phpapp']['database_name']
  privileges [:select,:update,:insert,:create,:delete]
  action :grant
end
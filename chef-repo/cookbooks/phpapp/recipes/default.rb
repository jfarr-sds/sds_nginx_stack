#
# Cookbook Name:: phpapp
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


include_recipe "php"
include_recipe "php::module_mysql"
include_recipe "php5-fpm::install"
include_recipe "nginx"
include_recipe "gearman"
include_recipe "gearman::server"
include_recipe 'git'
include_recipe 'phpunit'



# the php_pear resource expects this directory to exist
directory "/etc/php5/conf.d" do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# add gearman config to php mods-enabled
template '/etc/php5/mods-available/gearman.ini' do
  source 'gearman.ini.erb'
  cookbook 'phpapp'
  mode '0644'
  owner 'root'
  group 'root'
end

# symlink the .ini to the php-fpm confs
link "/etc/php5/fpm/conf.d/20-gearman.ini"do
  to "/etc/php5/mods-available/gearman.ini" 
end

# symlink the .ini to the cli confs
link "/etc/php5/cli/conf.d/20-gearman.ini" do
  to "/etc/php5/mods-available/gearman.ini"
end

# The gearman cookbook installs the server, worker and client.
# This resource makes the php extension available via PECL
php_pear "gearman" do
  action :install
end

# todo
# set cgi.fix_pathinfo=0 in /etc/php5/fpm/php.ini

nginx_site 'default' do
  enable false
end

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

# link the source to the deployment 
# todo: this is for development only
link "/var/vhosts/qa-prime" do
  to "/home/vagrant/chef-repo/Sentient-Prime-Survey-API/"
end


=begin
# install API source code
git "/var/vhost/" do
  repository "https://github.com/sentientdecisionscience/Sentient-Prime-Survey-API.git"
  revision "master"
  owner node['nginx']['user']
  group node['nginx']['group']  
  action :sync
end
=end

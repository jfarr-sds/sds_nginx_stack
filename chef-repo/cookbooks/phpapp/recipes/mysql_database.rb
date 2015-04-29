
mysql_service 'default' do
  port node['phpapp']['mysql']['port'] # todo: need to use this port because the "mysql" instance still gets installed on 3306
  socket node['phpapp']['mysql']['socket']
  version '5.5'
  initial_root_password node['mysql']['server_root_password']
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

# god-awful hack to get around the mysql cookbooks insistence on installing 
# multiple instances of mysql.

remote_file "mysql conf hack" do
  path "/etc/mysql/my.cnf" 
  source "file:///etc/mysql-default/my.cnf"
  owner 'mysql'
  group 'mysql'
  mode 0640
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
  privileges [:select,:update,:insert,:create,:delete,:execute]
  action :grant
  notifies :restart, 'mysql_service[default]'
end
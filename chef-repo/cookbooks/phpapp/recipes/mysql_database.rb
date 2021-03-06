
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

mysql_database_user node['phpapp']['dba_username'] do
  connection({
    :host => node['phpapp']['mysql']['db_host'],
    :username => node['phpapp']['mysql']['username'],
    :password => node['mysql']['server_root_password'],
    :socket   => node['phpapp']['mysql']['socket'],
    :port     => node['phpapp']['mysql']['port']
  })
  password node['phpapp']['dba_password']
  host node['phpapp']['dba_host']
  database_name node['phpapp']['database_name']
  privileges [:select,:update,:insert,:create,:delete,:execute]
  action :grant
  notifies :restart, 'mysql_service[default]'
end

mysql_database_user node['phpapp']['da_systems_username'] do
  connection({
    :host => node['phpapp']['mysql']['db_host'],
    :username => node['phpapp']['mysql']['username'],
    :password => node['mysql']['server_root_password'],
    :socket   => node['phpapp']['mysql']['socket'],
    :port     => node['phpapp']['mysql']['port']
  })
  password node['phpapp']['da_systems_password']
  host node['phpapp']['da_systems_host']
  database_name node['phpapp']['database_name']
  privileges [:select,:update,:insert,:create,:delete,:execute]
  action :grant
  notifies :restart, 'mysql_service[default]'
end

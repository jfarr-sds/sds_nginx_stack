default["phpapp"]["database_name"] = 'api-prime'
default["phpapp"]["db_username"] = 'api-prime'

default["phpapp"]['mysql']["host"] = '127.0.0.1'
default["phpapp"]['mysql']["username"] = 'root'
default["phpapp"]['mysql']["port"] = '3307'
default["phpapp"]['mysql']["socket"] = ':socket   => "/var/run/mysql-default/mysqld.sock'

node.default["php_fpm"]["pools"] = 
'{ 	"www":
	{
		"user": "fpm_user",
		"group": "fpm_group",
		"listen": "/var/run/php5-fpm.sock",
		"pm": "dynamic",
		"pm.max_children": "10",
		"pm.start_servers": "4",
		"pm.min_spare_servers": "2",
		"pm.max_spare_servers": "6",
		"pm.process_idle_timeout": "10s",
		"pm.max_requests": "0",
		"pm.status_path": "/status",
		"ping.path": "/ping",
		"ping.response": "/pong",
		"access.format": "%R - %u %t \"%m %r\" %s",
		"request_slowlog_timeout": "0",
		"request_terminate_timeout": "0",
		"chdir": "/",
		"catch_workers_output": "no",
		"security.limit_extensions": ".php",
		"access.log": "NOT_SET",
		"slowlog": "NOT_SET",
		"rlimit_files": "NOT_SET",
		"rlimit_core": "NOT_SET",
		"chroot": "NOT_SET"
	}
}'


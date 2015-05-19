<?php
class gm_save_request
{
    public function run($job) {
		$mysqli = new mysqli('localhost','root','password','api-prime');

		if($mysqli->connect_error) {
			echo $mysqli->connect_error;
		}

		xdebug_start_trace();
		$result = $mysqli->query("insert into session_requests(response_id) values('1')");

		echo $result;

		$result = $mysqli->query("select response_id from session_requests");

		echo "done\n";
    }
}
?>
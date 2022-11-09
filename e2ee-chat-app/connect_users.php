<?php

include_once("./server.php");

$json_body = file_get_contents('php://input');
$object = json_decode($json_body);

$key = connect_users('A','B');

echo json_encode($key);

?>
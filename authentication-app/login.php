<?php

include_once( "./database.php");


//$json_body = file_get_contents('php://input');
//$object = json_decode($json_body);

$password = '123456' // Hardcoded
$username = 'Luciano'; // Hardcoded

try
{
	//Todo tipo de validación de información, debe ser realizada aquí de manera obligatoria
	//ANTES de enviar el comando SQL al motor de base de datos.

	$SQLStatement = $connection->prepare("CALL `validateUser`(:username, :password)");
	$SQLStatement->bindParam( ':username', $username );
	$SQLStatement->bindParam( ':password', $password );
	$SQLStatement->execute();

	$status = array( status=>'ok', description=>'Usuario Conectado Exitosamente!' );
	$db_response = $SQLStatement->fetchAll(PDO::FETCH_ASSOC /* <- Ver bien como es el nombre */);
	$db_user = $db_response[1]["id"];


	$response_client = null; 

	if (count($db_response) != 0)
	{
		$id_user = $db_response[1]["id"];
		$response_client = ["status" => "OK", "response" => $id_user];
	}
	else
	{
		$response_client = ["status", "ERROR", "description" => "Usuario o contraseña erronea."];
	}


    echo json_encode($response_client);
}
catch( PDOException $connectionException )
{
    $status = array( status=>'db-error (login.php', description=>$connectionException->getMessage() );
    echo json_encode($status);
    die();
}

?>
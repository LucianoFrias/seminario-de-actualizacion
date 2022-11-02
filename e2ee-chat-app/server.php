<?php

//openssl_encrypt($string, $encryptd_method, $key)
//openssl_decrypt($string, $encrypt_method, $key);

/* Por cada función que declaremos, debe haber un archivo PHP dedicado. */

function connect_users($id_user_a, $id_user_b)
{
  //Acá haría varias cosas.. pero al final,
  //Debe devolver la clave simétrica.

  return generate_key($id_user_a, $id_user_b);

}

function disconnect_users( $id_user_a, $id_user_b )
{


}

function send_message($id_user_sender, $id_user_target, $body_message)
{
    return $body_message;
}

function generate_key( $id_user_sender, $id_user_target)
{
    return hash('sha256',uniqid());
}

function get_messages( $id_user )
{
  session_start();
  return echo "Mensajes: " . $_SESSION["usuario"];
}

?>
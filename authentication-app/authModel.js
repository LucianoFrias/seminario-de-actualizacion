class AuthModel
{

    constructor()
    {

    }

    authenticate( data )
    {
        return fetch('./loginToken.php').then()        
    }

}



export { AuthModel }
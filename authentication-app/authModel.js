class AuthModel
{

    constructor()
    {

    }

    authenticate( data )
    {
        return fetch('./loginToken.php')
        .then(response => response.json())
        .then(data => console.log(data))        
    }

}



export { AuthModel }
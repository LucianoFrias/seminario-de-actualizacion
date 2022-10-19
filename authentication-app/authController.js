class AuthController
{

    constructor(model, view)
    {
        this.innerModel = model;
        this.innerView = view;
    }

    getData(username, password)
    {
       let formData =
       {
         username: username,
         password: password
       }

       this.innerModel.authenticate( formData );

    }

    

}

export { AuthController }
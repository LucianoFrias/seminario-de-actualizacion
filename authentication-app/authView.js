class AuthView extends HTMLElement
{
    constructor(model)
    {
        super();
        this.innerModel = model;

        this.test = document.createElement('h1');
        this.test.innerText = 'Hello World!'

    }

    connectedCallback()
    {
        document.body.appendChild(this.test);
    }

}

customElements.define('x-auth', AuthView)

export { AuthView }
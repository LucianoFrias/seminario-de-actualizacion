import {AuthView} from './authView.js'
import {AuthModel} from './authModel.js'

function main()
{
    let model = new AuthModel();
    let view = new AuthView(model);

    document.body.appendChild(view);
    
}

window.addEventListener('load', main);
function numberIsInteger(number){
    if(!number)
        return false;
    if(!/^[0-9]+$/.test(number))
        return false;
    return true;
}
function HTMLObjectIdIsInDOM(element_id){
    if(!element_id)
        return false;
    let object = document.querySelector(`#${element_id}`);
    if(object === null)
        return false;
    return true;
}
function HTMLObjectsIdAreInDOM(elements_id){
    if(!elements_id)
        return false;
    for(let element_id of elements_id){
        let object = document.querySelector("#"+element_id);
        if(object === null)
            return false;
    }
    return true;
}
function stringIsValid(text){
    if(!text)
        return false;
    if(!/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚÄëÏöÜäëïöü]+$/.test(text))
        return false;
    return true;
}
function emailIsValid(email){
    if(!email)
        return false;
    let emailRegex = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i;
    if(!emailRegex.test(email))
        return false;
    return true;
}
function dateIsValid(date){
    if(!date)
        return false;
    if(date instanceof Date)
        return true;
    return false;
}
function firstdateIsBigger(date_a, date_b){
    if(!dateIsValid(date_a))
        return false;
    if(!dateIsValid(date_b))
        return false;
    if(date_b > date_a)
        return false;
    return true;
}
function dateIsActual(date){
    if(!dateIsValid)
        return false;
    let today = new Date();
    if (date < today)
        return false;
    return true;
}
function BirthdayIsLogic(date){
    //Max age 110 years old
    if(!dateIsValid)
        return false;
    let today = new Date();
    if((today.getFullYear() - date.getFullYear()) > 110)
        return false;
    return true;
}
function passwordIsSafe(password){
    if(!password)
        return {description: "Ingresa una contraseña"};
    if(password.length < 8)
        return {description: "La contraseña debe de tener mínimo 8 caracteres"};
    if(/^[a-zA-ZñÑáéíóúÁÉÍÓÚÄëÏöÜäëïöü]+$/.test(password))
        return {description: "La contraseña debe de incluir letras y números"};
    if(/^[0-9]+$/.test(password))
        return {description: "La contraseña debe de incluir letras y números"};
    return true;
}
function stringHasNotNumbers(text){
    if(!/^[a-zA-ZñÑáéíóúÁÉÍÓÚÄëÏöÜäëïöü]+$/.test(text))
        return false;
    return true;
}
function userDataIsValid(user_data){
    if(!stringHasNotNumbers(user_data.name))
        return false;
    if(!stringHasNotNumbers(user_data.appat))
        return false;
    if(user_data.apmat)
        if(stringHasNotNumbers(user_data.apmat))
            return false;
    if(!numberIsInteger(user_data.age))
        return false;
    if(!emailIsValid(user_data.email))
        return false;
    if(!numberIsInteger(user_data.school_certificate))
        return false;
    if(user_data.school_certificate < 1)
        return false;
    if(user_data.school_certificate > 7)
        return false;
    return true;
}
function textHasBadWords(){
    
}
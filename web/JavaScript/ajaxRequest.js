function ajaxRequest(method, url, json_data){
    return new Promise(resolve =>{
        const req = new XMLHttpRequest();
        req.onreadystatechange = () => {
            if (req.readyState === 4) 
                if (req.status === 200)
                    return resolve (JSON.parse(req.responseText));
            else return resolve (false);
        };
        req.open(method, url, true);
        req.setRequestHeader("Content-Type", "application/json;charset=utf-8");
        req.send(JSON.stringify(json_data));
    });
};
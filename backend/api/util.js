const bcrypt = require("bcryptjs");
async function getPassword(password){
    const salt = await bcrypt.genSalt(10);
    var hash = await bcrypt.hash(password, salt);
}
function parseDocument(document){
    //Parse the content of a google document as retrieved by the Docs API
    ret_string = "";
    for(var i in document){
        if(document[i]["paragraph"] != null){
        for(var j in document[i]["paragraph"]["elements"]){
            if(document[i]["paragraph"]["elements"][j]["textRun"]){
            bold = false
            italic = false
            underline = false
            ret_string +="*"
            if(document[i]["paragraph"]["elements"][j]["textRun"]["textStyle"]["bold"]){
                bold = true
                ret_string +="b"
            }
            if(document[i]["paragraph"]["elements"][j]["textRun"]["textStyle"]["italic"]){
                italic = true
                ret_string += 'i'
            }
            if(document[i]["paragraph"]["elements"][j]["textRun"]["textStyle"]["underline"]){
                underline = true
                ret_string +='u'
            }
            ret_string+= '*'+ document[i]["paragraph"]["elements"][j]["textRun"]["content"] + '*';
            if(bold){
                ret_string +='b'
            }
            if(italic){
                ret_string += 'i'
            }
            if(underline){
                ret_string += 'u'
            }
            ret_string +="*"
        }
    }
    }
}
    return ret_string;
}
module.exports = {
    parseDocument: parseDocument,
    getPassword: getPassword
}
const bcrypt = require("bcryptjs");
async function getPassword(password){
    const salt = await bcrypt.genSalt(10);
    var hash = await bcrypt.hash(password, salt);
    console.log(hash);
}
getPassword("Zarathustra42!");
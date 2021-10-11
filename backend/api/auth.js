const express = require("express");
const router = express.Router();
const bcrypt = require("bcryptjs");
const crypto = require("crypto");
const jwt = require("jsonwebtoken");
const config = require("../config/default.json");
const Writer = require('../models/Writer');
//authorize with dart app and send bearer token here
router.post("/login/writer", async (req, res) => {
    try {
          if(req.body.length == 0){
            return res.json({error:{msg:"Email and password are required."}});
          }
          const email = req.body.email;
          const password = req.body.password;
          if(email == undefined || password == undefined){
            return res.json({error:{msg:"Email and password are required."}});
          }
          const user = await Writer.findOne({email: email});
          if(!user){
            return res.status(400).json({error: {msg: "Invalid Credentials"}});
          }
          const passwordMatch = await bcrypt.compare(password, user.password);
          if (!(passwordMatch)) {
              return res.status(400).json({ error: { msg: 'Invalid Credentials' }});
          }
          var encrypt = crypto.createHmac("SHA256", email).update(password).digest('base64');
          const payload = {
            user: {
              //send the user id
              id:user.id,
            },
          };
          //sign the token
          jwt.sign(
            payload,
            config["jwtSecret"],
            { expiresIn: "5 days" },
            (err, token) => {
              if (err) throw err;
              res.cookie('auth', token).json({token: token, admin: user.admin});
            }
          );
        } catch (err) {
          console.error(err.message);
          res.status(500).send("Server error");
        }
});
module.exports = router;
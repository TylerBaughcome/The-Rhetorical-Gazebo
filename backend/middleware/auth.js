const jwt = require("jsonwebtoken");
const config = require("../config/default.json");
const crypto = require('crypto');

module.exports = function (req, res, next) {
  // Get token from header
  var token = req.cookies.auth;
  // Check if not token
  if (!token) {
    token = req.headers['x-auth-token'];
    if(!token){
    return res.status(401).json({ msg: "No token, authorization denied" });
    }
  }

  // Verify token
  try {
    const decoded = jwt.verify(token, config["jwtSecret"]);
    req.user = decoded.user;
    next();
  } catch (err) {
    res.status(401).json({ msg: "Token is not valid" });
  }
}
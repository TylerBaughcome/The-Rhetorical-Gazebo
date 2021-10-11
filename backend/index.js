require("dotenv").config();
var express = require("express");
var app = express();
var path = require("path");
const session = require("express-session");
const cookieParser = require("cookie-parser");
const cors = require('cors');
const connectDB = require("./config/db");
const { header } = require("express-validator");
app.use(express.json({ extended: false }));
app.use(cookieParser());
app.use(
  session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false,
    //cookie: { secure: true }
  })
  
);
connectDB()

app.use('/api/auth', require('./api/auth'));
app.use('/api/articles', require('./api/articles'));
app.use('/api/users', require('./api/users'));
const port = process.env.PORT || 3000;

// Start the server
app.listen(port, () =>
  console.log(`Gazebo server listening on port ${port}!`)
);
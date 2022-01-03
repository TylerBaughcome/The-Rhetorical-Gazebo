require("dotenv").config();
var express = require("express");
var app = express();
const router = express.Router();
var path = require("path");
const session = require("express-session");
const cookieParser = require("cookie-parser");
const cors = require("cors");
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
connectDB();

app.use(
  "/",
  router.get("/", async (req, res) => {
    //may want to check those with greatest rate of viewing eventually
    //Can now just say newest or something
    try {
      return res.json({ message: "Welcome to the Rhetorical Gazebo's API!" });
    } catch (err) {
      return res.status(500).send("Server error");
    }
  })
);
app.use("/api/auth", require("./api/auth"));
app.use("/api/articles", require("./api/articles"));
app.use("/api/users", require("./api/users"));
app.use("/api/uploads", require("./api/uploads"));
const port = process.env.PORT || 3000;

// Start the server
app.listen(port, () => console.log(`Gazebo server listening on port ${port}!`));

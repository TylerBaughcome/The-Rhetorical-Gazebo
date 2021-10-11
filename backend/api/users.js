const express = require("express");
const router = express.Router();
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const config = require("../config/default.json");
const { check, validationResult } = require("express-validator");
const normalize = require("normalize-url");
const Writer = require("../models/Writer");
const auth = require("../middleware/auth")
const quotedPrintable = require("quoted-printable");



//TODO: add route for normal users eventually



// @route   POST api/users
// @desc    Register user
// @access  Public
router.post(
  "/writer",
  [
    check("name", "Name is required").not().isEmpty(),
    check("email", "Please include a valid email").isEmail(),
    check(
      "password",
      "Please enter a password with 6 or more characters"
    ).isLength({ min: 6 }),
    check("token", "Referral token is required").not().isEmpty(),
  ],

  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ error:{msg: "Missing fields" , errors: errors.array() }});

    }
    const { name,pseudonym, email, password , token} = req.body;
    try {
      let user = await Writer.findOne({ email });
      // See if user exists
      if (user) {
        return res
          .status(400)
          .json({ error: { msg: "That email is already associated with a writer." }});

      }
      //need to check token (encode referrer's email into token somehow)
      const referrer = await Writer.findOne({email: atob(token), admin: true});
      if(!referrer){
        return res.status(400).json({error: {msg: "That token is invalid."}});
      }
      //without normalize
      user = new Writer({
        name,
        pseudonym,
        email,
        password,
      });

      // Encrypt password by hashing
      const salt = await bcrypt.genSalt(10);
      user.password = await bcrypt.hash(password, salt);
      await user.save(); //save user in the data base

      // Return jsonwebtoken
      const payload = {
        user: {
          id: user.id,
        },
      };
      jwt.sign(
        payload,
        config["jwtSecret"],
        { expiresIn: "5 days" },
        (err, token) => {
          if (err) throw err;
          res.json({ token });
        }
      );
    } catch (err) {
      console.error("Error registering writer:", err.message);
      res.status(500).send("Server error");
    }
  }
);
router.post("/admin", async (req, res) => {
  try{
  //TODO: consider adding token from another admin for converting to admin
  const email = req.body.email;
  const password = req.body.password
  const token = req.body.token;
  const user = await Writer.findOne({email: email});
  if(!user){
    return res.status(400).json({error: {msg: "Invalid credentials"}});
  }
  const passwordMatch = await bcrypt.compare(password, user.password);
  if(!passwordMatch){
    return res.status(400).json({error: {msg: "Invalid credentials"}});
  }
  const admin_referrer = await Writer.findOne({email: atob(token), admin: true});
  if(!admin_referrer){
    return res.status(400).json({"error": {msg: "Invalid credentials."}});
  }
  user.admin = true;
  await user.save();
  res.json({msg: "New administrator added."})
  }
  catch(err){
    console.error("Error posting admin:", err);
    res.status(500).send("Server error");
  }

});
router.get("/referralToken", auth, async(req, res) => {
  //get referral token to allow registration access for utility app
  try{
  const user = await Writer.findOne({_id: req.user.id});
  if(!user){
    return res.status(404).json({error: {msg: "No user found."}})
  }
  var encrypt = quotedPrintable.encode(btoa(user.email));
  return res.json({"referral_token": encrypt});
  }
  catch(err){
    console.error("Error getting referral token:", err);
    res.status(500).send("Server error");
  }
})
module.exports = router;
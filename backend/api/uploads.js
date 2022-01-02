const express = require("express");
const router = express.Router();
const auth= require("../middleware/auth");
var multer  = require('multer');
const aws = require("aws-sdk")
const fs = require("fs")
const s3 = new aws.S3({
    accessKeyId: process.env.S3_KEY_ID,
    secretAccessKey: process.env.S3_TOKEN
});
var upload = multer({ dest: __dirname + '/uploads' });
router.post('/image',upload.single("file"), auth, async (req, res) => {
    var params = {
      Bucket: process.env.S3_BUCKET_NAME,
      Body: fs.createReadStream(req.file.path),
      Key: req.file.filename,
      "ContentType": "image/jpeg",
      ACL: "public-read"
    };
    try {
      s3.upload(params, async function (err, data) {
        if (err) {
          console.log("Received error: ");
          console.log(err)
          res.status(500).json({ error: true, Message: err });
        } else {
          console.log("Sent to S3 successfully");
  
          //remove the temp stored file
          var deletePath = req.file.path;
  
          fs.unlink(deletePath, function (err) {
            if (err) return console.log("Error deleting file", err);
            console.log('File deleted from local storage successfully');
          });
          return res.json({"image": data });
        }
      });
    } catch (e) {
      console.log("Received error: ");
      console.log(e);
      return res.json({"error": e}).status(300);
    }
  
  
    return res.status(200);
  
  });
module.exports = router;
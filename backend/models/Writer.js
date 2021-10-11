const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const RequestSchema = new Schema({
  name: {
      type: String,
  },
  pseudonym: {
      type: String
  },
  email : {
      type: String,
      required: true
  },
  password: {
      type: String,
      required: true
  },
  admin: {
    type: Boolean,
    default: false,
  },
  registration_date: {
    type: Date,
    default: Date.now
  },
});

module.exports = mongoose.model("writer", RequestSchema);

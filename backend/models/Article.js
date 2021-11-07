const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const RequestSchema = new Schema({
  googleDocId: {
    type: String,
    required:true
  },
  title: {
    type: String,
    required:true
  },
  subtitle: {
    type: String,
  },
  isFeatured: {
    type: Boolean,
    required:true
  },
  image_link: {
    type: String,
    required: false 
  },
  author: {
    type: String,
    required: true
  },
  genre: {
    type: String,
    required: true,
  },
  content: {
    type: String,
    required: true 
  },
  clicks: {
    type: Number,
    required: true,
    default: 0
  },
  date: {
    type: Date,
    default: Date.now
  },
});

module.exports = mongoose.model("article", RequestSchema);
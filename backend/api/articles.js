const express = require("express");
const router = express.Router();
const bcrypt = require("bcryptjs");
const crypto = require("crypto");
const jwt = require("jsonwebtoken");
const config = require("../config/default.json");
const auth= require("../middleware/auth");
const Article = require("../models/Article");
const axios = require("axios");
const querystring = require("querystring");
const {getPassword, parseDocument} = require("./util")
router.post("/", auth, async (req, res)=> {
    //upload article to database
    try{
    var fields = req.body.fields;
    fields["author"] = req.user.id;
    const old_article = await Article.findOne({googleDocId: fields.googleDocId});
    if(old_article){
        return res.status(400).json({error: {msg: "An article for that google document already exists."}});
    }
    //Parse document here
    const content = parseDocument(fields["content"]);
    fields["content"] = content;
    const new_article = new Article(fields);
    await new_article.save();
    res.json({"request_fields": req.body.fields, "success": 1});
    }
    catch(err){
        if(err._message == "article validation failed"){
            //get missing fields
            var missing_fields = Object.keys(err.errors);
            return res.json({"error": {msg: "Article fields missing", missing: missing_fields}})
        }
        console.log("Error uploading file => ", err);
        res.status(500).send("Server error")
    }
});
router.get("/digest", async (req, res)=> {
    //Get featured, popular, and recommended eventually (for those topics the user selects)
    try{
        var featured_articles = await Article.find({isFeatured: true}).limit(4);
        var popular_articles = await Article.find({isFeatured: false}).sort({clicks:-1}).limit(10); 
       
        var data = {};
        data["featured"] = featured_articles;
        data["popular"] = popular_articles;
        return res.json({"digest": data});
    }
    catch(err){
        console.error("Error getting digest:", err);
        res.status(500).send("Server error");

    } 
    
});
router.get("/popular", async (req, res)=> {
    //may want to check those with greatest rate of viewing eventually
    //Can now just say newest or something
    try{
    var popular_articles = await Article.find({isFeatured: false}).sort({clicks:-1}).limit(10); 
    if(!popular_articles){
        return res.json({"popular": []});
    }
    return res.json({"popular": popular_articles});
    }
    catch(err){
        console.error("Error getting popular articles:", err);
        return res.status(500).send("Server error");
    }
})
router.get("/featured", async (req,res) => {
    //TODO: may need way to regulate which articles are featured eventually
    try{
        const featured_articles = await Article.find({isFeatured: true}).limit(4);
        if(!featured_articles){
            return res.json({"featured": []});
        }
        res.json({"featured": featured_articles});
    }
    catch(err){
        console.error("Error getting featured articles:", err);
        res.status(500).send("Server error");

    }
});
router.get("/:genre", async (req, res)=> {
    try{
    const genre = req.params.genre;
    const genre_specific_articles = await Article.find({genre: genre});
    var data = {}
    data[genre+"_articles"] = genre_specific_articles
    res.json(data);
    }
    catch(err){
        const genre = req.params.genre;
        console.error(`Error getting ${genre} articles: ${err}`);
        res.status(500).send("Server error");
    }
});
router.put("/click/:article_id", async (req, res)=> {
    try{
    const article = await Article.updateOne({_id: req.params.article_id}, {$inc: {clicks: 1}});
    if(!article){
        return res.status(404).json({error: {msg: "Article not found"}});
    }
    return res.json({"success": 1});
    }
    catch(err){
        console.error("Error updating article:", err);
        return res.status(500).send("Server error");
    }
});
module.exports = router;
const express = require('express');
const fs = require('fs');
const bodyParser = require('body-parser');

const app = express();

const routes = require("./routes.js")(app, fs);

const server = app.listen(8000, ()=>{
    console.log("listening on port %s...", server.address().port);
})

/*
const http = require("http");
const url = require("url");
const profileJSON = require("./profile.json");
const courseJSON = require("./course.json");

const host = 'localhost';
const port = 8000;


const server = http.createServer((req, res)=>{
const reqUrl = url.parse(req.url).pathname
if(req.method == "GET"){
    if (reqUrl == "/profile"){
        res.write(JSON.stringify(profileJSON))
        res.end()
    }else if(reqUrl == "/course"){
        res.write(JSON.stringify(courseJSON))
        res.end()
    }
}});


server.listen(port);
console.log("Server is listening on port:" + port);

*/
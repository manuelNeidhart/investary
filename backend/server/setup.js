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
}
});

server.listen(port);
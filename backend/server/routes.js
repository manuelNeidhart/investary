const routes = require("./endpoints");
const profileJSON = require("./data/profile.json");
const courseJSON = require("./data/course.json");
const appRouter = (app, fs) => {

    app.get("/", (req, res) => {
        res.send("Hello Server");
    });

    routes(app, fs);
};

module.exports = appRouter;
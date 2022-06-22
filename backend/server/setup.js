const express = require('express');
const fs = require('fs');
const bodyParser = require('body-parser');

const app = express();

const routes = require("./routes.js")(app, fs);

const server = app.listen(8000, () => {
    console.log("listening on port %s...", server.address().port);
})
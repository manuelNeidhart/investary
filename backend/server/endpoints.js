const userRoutes = (app, fs) => {
    const profileData = "./data/profile.json";
    const courseData = "./data/course.json";

    const readFile = (
        callback,
        returnJson = false,
        filePath,
        encoding = 'utf8'
    ) => {
        fs.readFile(filePath, encoding, (err, data) => {
            if (err) {
                throw err;
            }
            callback(returnJson ? JSON.parse(data) : data);
        });
    };

    const writeFile = (
        fileData,
        callback,
        filePath,
        encoding = 'utf8'
    ) => {
        fs.writeFile(filePath, fileData, encoding, err => {
            if (err) {
                throw err;
            }
            callback();
        });
    };


    app.get("/profile", (req, res) => {
        readFile(data => {
            res.send(data);
        }, true, profileData);
    });

    app.get("/course/:courseLevel", (req, res) => {
        const courseLevel = req.params["courseLevel"];
        readFile(data => {
            res.send(data[parseInt(courseLevel)]);
        }, true, courseData);
    });

    app.get("/courseProgress/:courseLevel", (req, res) => {
        const courseLevel = req.params["courseLevel"];
        
            readFile(data => {
                res.status(200).send(String(data["courses"][parseInt(courseLevel)]["courseProgress"]));
            }, true, profileData);
    });



    app.put("/profile/:courseLevel", (req, res) => {
        const courseLevel = req.params["courseLevel"];
        readFile(data => {
            let currentCount = data["courses"][parseInt(courseLevel)]["courseProgress"];
            data["courses"][parseInt(courseLevel)]["courseProgress"] = currentCount+1;
            writeFile(JSON.stringify(data), () => {
                res.status(200).send("test");
            }, profileData);
                
        }, true, profileData);
    });

    app.put("/resetCourse/:courseLevel", (req, res) => {
        const courseLevel = req.params["courseLevel"];
        readFile(data => {
            data["courses"][courseLevel]["courseProgress"] = 0;

            writeFile(JSON.stringify(data), () => {
                res.status(200).send("test");
            }, profileData);
        }, true, profileData);
    });

};



module.exports = userRoutes;
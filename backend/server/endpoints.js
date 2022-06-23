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

    app.get("/course", (req, res) => {
        readFile(data => {
            res.send(data);
        }, true, courseData);
    });

    app.put("/profile/:courseLevel", (req, res) => {
        readFile(data => {
            const currentCount = data["courses"][0]["courseProgress"]

            data["courses"][0]["courseProgress"] = currentCount+1;

            writeFile(JSON.stringify(data), () => {
                res.status(200).send("test");
            }, profileData);
        }, true, profileData);
    });

    app.put("/resetCourse", (req, res) => {
        readFile(data => {
            data["courses"][0]["courseProgress"] = 0;

            writeFile(JSON.stringify(data), () => {
                res.status(200).send("test");
            }, profileData);
        }, true, profileData);
    });

};



module.exports = userRoutes;
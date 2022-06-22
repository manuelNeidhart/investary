const userRoutes = (app,fs)=>{
    const profileData = "./data/profile.json";
    const courseData = "./data/course.json";

    const readFile = (
        callback,
        returnJson = false,
        filePath,
        encoding = 'utf8'
    )=>{
        fs.readFile(filePath, encoding, (err, data)=>{
            if (err){
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
    )=>{
        fs.writeFile(filePath, fileData, encoding, err =>{
            if (err) {
                throw err;
            }
            callback();
        });
    };


    app.get("/profile", (req, res)=>{
        readFile(data => {
            res.send(data);
        }, true, profileData);
    });

    app.get("/course", (req, res)=>{
        readFile(data => {
            res.send(data);
        }, true, courseData);
    });

    app.put("/profile/:courseCount", (req, res)=>{
        readFile(data => {
            const courseCount = req.params["courseCount"];
            data["courses"]["courseProgress"] = courseCount;

            writeFile(data, ()=>{
                res.status(200).send("Hob den Neger für dich geupdated!");
            }, profileData);
        }, true);
    });
    
    };



    module.exports = userRoutes;
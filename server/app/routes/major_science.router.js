module.exports = app => {
    const major_sciences = require("../controllers/major_science.controller.js");
  
    var router = require("express").Router();

    // Retrieve all Major Sciences
    router.get("/", major_sciences.findAll);

    // Retrieve one major science by id
    router.get("/:id",major_sciences.findById)

    router.post("/findByName",major_sciences.findByName)

    //Create
    router.post("/create",major_sciences.create)

    app.use('/api/major_sciences', router);
};
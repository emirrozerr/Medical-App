module.exports = app => {
    const patient = require("../controllers/patient.controller.js");
  
    var router = require("express").Router();

    router.post("/create", patient.create);
    
    // Retrieve all patients
    router.get("/", patient.findAll);
  
    app.use('/api/patients', router);
  };
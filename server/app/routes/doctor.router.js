module.exports = app => {
    const doctors = require("../controllers/doctor.controller.js");
  
    var router = require("express").Router();

    router.post("/create", doctors.create);
    
    // Retrieve all Doctors
    router.get("/", doctors.findAll);
  
    app.use('/api/doctors', router);
  };
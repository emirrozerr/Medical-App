const db = require("../models");
const Patient = db.patients;
const Op = db.Sequelize.Op;
const bcryptjs = require("bcryptjs")

exports.findAll = (req, res) => {
    
    Patient.findAll()
      .then(data => {
        res.send(data);
      })
      .catch(err => {
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving Patients."
        });
      });
};


exports.create = async (req, res) => {
    // Validate request
    if (!req.body.first_name) {
      res.status(400).send({
        message: "Content can not be empty!"
      });
      return;
    }

    const hashedPassword = await bcryptjs.hash(req.body.password,8)
    
    const patient = {
      first_name: req.body.first_name,
      last_name: req.body.last_name,
      mail: req.body.mail,
      password: hashedPassword,
    };
  
    // Save Patient in the database
    Patient.create(patient)
      .then(data => {
        res.send(data);
      })
      .catch(err => {
        res.status(500).send({
          message:
            err.message || "Some error occurred while creating the Patient."
        });
      });
  };
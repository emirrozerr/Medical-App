const db = require("../models");
const Doctor = db.doctors;
const Major_science = db.major_sciences;
const Op = db.Sequelize.Op;
const bcryptjs = require("bcryptjs")
const axios = require('axios');

exports.findAll = (req, res) => {
    const first_name = req.query.first_name;

  
    Doctor.findAll()
      .then(data => {
        res.send(data);
      })
      .catch(err => {
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving tutorials."
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
    // let major_science_id = 0
    // const major_science_name = req.body.major_science_name
    // axios.post('http://localhost:8080/api/major_sciences/findByName', { //major_science tablosuna istek atılıp ismi girilen değerin idsi alınır.
    //     name: major_science_name                                   // yada dropdawna itemleri girerken ismini değil idsini kaydederiz.
    //   })
    //   .then(function (response) {
    //     major_science_id = response.id
    //     console.log(response)
    //   })
    //   .catch(function (error) {
    //     console.log(error);
    //   });



    const doctor = {
      first_name: req.body.first_name,
      last_name: req.body.last_name,
      mail: req.body.mail,
      password: hashedPassword,
      graduated_school: req.body.graduated_school,
    };
  
    // Save Doctor in the database
    Doctor.create(doctor)
      .then(data => {
        res.send(data);
      })
      .catch(err => {
        res.status(500).send({
          message:
            err.message || "Some error occurred while creating the Tutorial."
        });
      });
  };
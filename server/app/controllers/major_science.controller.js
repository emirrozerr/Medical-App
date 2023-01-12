const db = require("../models");
const Major_science = db.major_sciences;
const Op = db.Sequelize.Op;
const bcryptjs = require("bcryptjs")


exports.findAll = (req, res) => {
    const name = req.query.name;
    var condition = name ? { name: { [Op.like]: `%${name}%` } } : null;

    Major_science.findAll()
      .then(data => {
        res.send(data);
      })
      .catch(err => {
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving major sciences."
        });
      });
};

exports.findById = (req, res) => {
    const id = req.params.id;
  
    Major_science.findByPk(id)
      .then(data => {
        if (data) {
          res.send(data);
        } else {
          res.status(404).send({
            message: `Cannot find Major science with id= ${id}.`
          });
        }
      })
      .catch(err => {
        res.status(500).send({
          message: "Error retrieving Major science with id=" + id
        });
      });
  };

  exports.create =  (req, res) => {
    const major_science = {
      name: req.body.name
    };
  
    // Save Major science in the database
    Major_science.create(major_science)
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

  exports.findByName = (req, res) => {
    const _name = req.body.name;
  
    Major_science.findOne({ where: { name: _name } })
      .then(data => {
        if (data) {
          res.send({id: data.id});
        } else {
          res.status(404).send({
            message: `Cannot find Major science with name= ${_name}.`
          });
        }
      })
      .catch(err => {
        res.status(500).send({
          message: "Error retrieving Major science with name=" + _name
        });
      });
  };
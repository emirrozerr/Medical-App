const dbConfig = require("../config/db.config.js");

const Sequelize = require("sequelize");
const sequelize = new Sequelize(dbConfig.DB, dbConfig.USER, dbConfig.PASSWORD, {
  host: dbConfig.HOST,
  dialect: dbConfig.dialect,
  operatorsAliases: false,

  pool: {
    max: dbConfig.pool.max,
    min: dbConfig.pool.min,
    acquire: dbConfig.pool.acquire,
    idle: dbConfig.pool.idle
  }
});

const db = {};

db.Sequelize = Sequelize;
db.sequelize = sequelize;

db.doctors = require("./doctor.js")(sequelize, Sequelize);
db.patients = require("./patient.js")(sequelize, Sequelize);
db.major_sciences = require("./major_science.js")(sequelize, Sequelize);
db.specialties = require("./specialty.js")(sequelize, Sequelize);
db.doctor_specialties = require("./doctor_specialty.js")(sequelize, Sequelize);

module.exports = db;
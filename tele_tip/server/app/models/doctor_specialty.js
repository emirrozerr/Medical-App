module.exports = (sequelize, Sequelize) => {
    const Doctor_specialty = sequelize.define("doctor_specialty", {
      doctor_id: {
        type: Sequelize.INTEGER
      },
      specialty_id: {
        type: Sequelize.INTEGER
      }
    });
  
    return Doctor_specialty;
  };
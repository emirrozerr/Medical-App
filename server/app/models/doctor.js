module.exports = (sequelize, Sequelize) => {
    const Doctor = sequelize.define("doctor", {
      first_name: {
        type: Sequelize.STRING
      },
      last_name: {
        type: Sequelize.STRING
      },
      mail: {
        type: Sequelize.STRING
      },
      password: {
        type: Sequelize.STRING
      },
      hospital: {
        type: Sequelize.STRING
      },
      clinic: {
        type: Sequelize.STRING
      },
      major_science_id: {
        type: Sequelize.INTEGER
      },
      img: {
        type: Sequelize.STRING
      },
    });
  
    return Doctor;
  };